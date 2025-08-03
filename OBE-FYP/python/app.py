# pip install flask flask-cors pymupdf python-docx sentence-transformers textstat scikit-learn
# pip install flask flask-cors pymupdf python-docx sentence-transformers textstat scikit-learn --dev
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
# venv\Scripts\activate
# pip install pymupdf
# python -c "import fitz; print(fitz.__doc__)"
# python python/app.py

import io
import math
import os
import tempfile
import requests
import re
import matplotlib
from flask_cors import CORS
import matplotlib.pyplot as plt
from flask import Flask, request, jsonify, send_file

import fitz
from docx import Document
from sentence_transformers import SentenceTransformer, util
from textstat import flesch_reading_ease
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.decomposition import LatentDirichletAllocation
from sklearn.feature_extraction.text import CountVectorizer

app = Flask(__name__)

matplotlib.use('Agg')
CORS(app, resources={r"/*": {"origins": "*"}})
model = SentenceTransformer("sentence-transformers/all-MiniLM-L6-v2")  # Free relevance model

ALLOWED_EXTENSIONS = {".pdf", ".txt", ".docx"}
RELEVANCY_THRESHOLD = 20  # Below 20% is considered irrelevant


@app.route("/upload", methods=["POST"])

def upload_file():
    global calculated_scores
    # 'question' not in request.form or
    if 'file' not in request.files or  'totalMarks' not in request.form:
        return jsonify({"error": "Missing required fields"}), 400
    
    file = request.files['file']
    # question = request.form['question']

    # Handle either a question file OR a question file URL
    question_file = request.files.get('questionFile')  # File (if uploaded)
    question_url = request.form.get('questionFileURL')  # URL (if provided)

    total_marks = float(request.form['totalMarks'])
    print(file, "--------------file")
    print(question_file, "--------------questionFile")
    print(question_url, "--------------questionFileURL")
    print(total_marks, "--------------total_marks")
    if file.filename == '':
        return jsonify({"error": "No file found"}), 400
    
    ext = os.path.splitext(file.filename)[1].lower()
    # ext_question = os.path.splitext(question.filename)[1].lower()
    if ext not in ALLOWED_EXTENSIONS:
        return jsonify({"error": "Wrong file extension uploaded"}), 400
    
    with tempfile.NamedTemporaryFile(delete=False, suffix=ext) as temp_file:
        file.save(temp_file.name)
        temp_path = temp_file.name
    
    text = extract_text_from_file(temp_path)
    os.unlink(temp_path)

       # Process the question file (either from file upload OR URL)
    question_text = None
    if question_file and question_file.filename != '':
        ext_question = os.path.splitext(question_file.filename)[1].lower()
        if ext_question not in ALLOWED_EXTENSIONS:
            return jsonify({"error": "Invalid question file type"}), 400
        
        with tempfile.NamedTemporaryFile(delete=False, suffix=ext_question) as temp_q_file:
            question_file.save(temp_q_file.name)
            question_text = extract_text_from_file(temp_q_file.name)
            os.unlink(temp_q_file.name)

    elif question_url:
        question_text = download_text_from_url(question_url)
    
    if text is None or question_text is None:
        return jsonify({"final_grade": "F", "plagiarism_score": 0, "relevancy_score": 0, "readability_score": 0, "assignment_marks": 0}), 200
    
    cleaned_text = preprocess_text(text)
    cleaned_question = preprocess_text(question_text)

    if not is_valid_file(cleaned_text):
        return jsonify({"final_grade": "F", "assignment_marks": 0}), 200
    
    calculated_scores = {}
    plagiarism_score = check_plagiarism(cleaned_text)
    relevancy_score = check_relevancy(cleaned_text, cleaned_question)
    readability_score = flesch_reading_ease(cleaned_text)
    final_grade, assignment_marks = compute_grade(plagiarism_score, relevancy_score, readability_score, total_marks)
    gpa = compute_gpa(plagiarism_score, relevancy_score, readability_score)

    print(f" Calculated Scores - Plagiarism: {plagiarism_score}, Relevancy: {relevancy_score}, Readability: {readability_score}")
    
    calculated_scores = {
        "plagiarism_score": plagiarism_score,
        "relevancy_score": relevancy_score,
        "readability_score": readability_score
    }

    return jsonify({
        "plagiarism_score": plagiarism_score,
        "relevancy_score": relevancy_score,
        "readability_score": readability_score,
        "final_grade": final_grade,
        "gpa": gpa,
        "assignment_marks": assignment_marks,
    })

def extract_text_from_file(file_path):
    ext = os.path.splitext(file_path)[1].lower()
    if ext == ".pdf":
        doc = fitz.open(file_path)
        return "\n".join([page.get_text() for page in doc])
    elif ext == ".txt":
        with open(file_path, "r", encoding="utf-8") as f:
            return f.read()
    elif ext == ".docx":
        doc = Document(file_path)
        return "\n".join([para.text for para in doc.paragraphs])
    return None  # Unsupported format

def download_text_from_url(url):
    """Downloads text from a URL (PDF, TXT, or DOCX)."""
    try:
        response = requests.get(url)
        if response.status_code == 200:
            file_ext = ".pdf" if "pdf" in url else (".docx" if "docx" in url else ".txt")
            with tempfile.NamedTemporaryFile(delete=False, suffix=file_ext) as temp_q_file:
                temp_q_file.write(response.content)
                temp_q_file.flush()
                print(f"✅ Successfully downloaded question file: {temp_q_file.name}")
                return extract_text_from_file(temp_q_file.name)
        else:
            return None
    except Exception as e:
        print(f"Error downloading file: {e}")
        return None

def preprocess_text(text):
    text = re.sub(r'\[.*?\]', '', text)
    text = re.sub(r'\b(?:References|Bibliography)\b.*', '', text, flags=re.DOTALL)
    text = re.sub(r'\b(?:Appendix|Acknowledgments)\b.*', '', text, flags=re.DOTALL)
    text = re.sub(r'\d{1,3}\.\d{1,3}', '', text)
    text = re.sub(r'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+', '', text)
    return text

def is_valid_file(text):
    if len(text.split()) < 50:
        return False
    if re.search(r"(this\s?document\s?is\s?irrelevant|random\s?data)", text, re.I):
        return False
    return True

def topic_modeling(texts):
    vectorizer = CountVectorizer(stop_words='english')
    X = vectorizer.fit_transform(texts)
    lda = LatentDirichletAllocation(n_components=5, random_state=42)
    lda.fit(X)
    return lda.components_

def check_plagiarism(text):
    corpus = ["This is an example reference document.", "Another academic source for plagiarism check."]
    corpus.append(text)
    vectorizer = TfidfVectorizer()
    tfidf_matrix = vectorizer.fit_transform(corpus)
    similarity_scores = cosine_similarity(tfidf_matrix[-1], tfidf_matrix[:-1])
    max_score = max(similarity_scores[0]) * 100
    return 100 - max_score

def check_relevancy(text, question):
    cleaned_text = preprocess_text(text)
    assignment_embedding = model.encode(cleaned_text, convert_to_tensor=True)
    question_embedding = model.encode(question, convert_to_tensor=True)
    similarity = util.pytorch_cos_sim(assignment_embedding, question_embedding).item()
    return similarity * 100

def compute_grade(plagiarism, relevancy, readability, total_marks):
    if relevancy < RELEVANCY_THRESHOLD:
        return "F", 0
    weighted_score = (0.4 * plagiarism) + (0.4 * relevancy) + (0.2 * readability)
    marks_obtained = (weighted_score / 100) * total_marks
    if weighted_score >= 90:
        return "A+", marks_obtained
    elif weighted_score >= 80:
        return "A", marks_obtained
    elif weighted_score >= 75:
        return "B+", marks_obtained
    elif weighted_score >= 70:
        return "B", marks_obtained
    elif weighted_score >= 65:
        return "C+", marks_obtained
    elif weighted_score >= 60:
        return "C", marks_obtained
    else:
        return "F", marks_obtained

def compute_gpa(plagiarism, relevancy, readability):
    if relevancy < RELEVANCY_THRESHOLD:
        return "0.00"
    weighted_score = (0.4 * plagiarism) + (0.4 * relevancy) + (0.2 * readability)
    if weighted_score >= 90:
        return "4.00"
    elif weighted_score >= 80:
        return "4.00"
    elif weighted_score >= 75:
        return "3.50"
    elif weighted_score >= 70:
        return "3.00"
    elif weighted_score >= 65:
        return "2.50"
    elif weighted_score >= 60:
        return "2.00"
    else:
        return "0.00"

def generate_pie_chart(plagiarism_score, relevancy_score, readability_score):
    labels = ['Plagiarism', 'Relevancy', 'Readability']
    sizes = [plagiarism_score, relevancy_score, readability_score]
    colors = ['#ff9999', '#66b3ff', '#99ff99']

    # Check for invalid or zero data
    if any([math.isnan(score) or math.isinf(score) for score in sizes]) or sum(sizes) == 0:
        raise ValueError("Invalid score values passed to pie chart")

    plt.figure(figsize=(5, 5))
    plt.pie(sizes, labels=labels, autopct='%1.1f%%', colors=colors, startangle=150)
    plt.axis('equal')

    img_bytes = io.BytesIO()
    plt.savefig(img_bytes, format='png')
    plt.close()

    img_bytes.seek(0) 
    return img_bytes
    
@app.route('/generate_chart', methods=['POST'])
def generate_chart():
    try:
        global calculated_scores
        if not calculated_scores:
            return jsonify({"error": "No scores available. Upload an assignment first."}), 400
        print(f"Received Data: {calculated_scores}")
        # data = request.get_json()
        # print("Received data:", data)

        plagiarism_score = float(calculated_scores.get('plagiarism_score', 0))
        relevancy_score = float(calculated_scores.get('relevancy_score', 0))
        readability_score = float(calculated_scores.get('readability_score', 0))
        print("Parsed scores:", plagiarism_score, relevancy_score, readability_score)

        # if not any([plagiarism_score, relevancy_score, readability_score]):
        #     return jsonify({"error": "Invalid input values."}), 400
        if plagiarism_score is None or relevancy_score is None or readability_score is None:
            return jsonify({"error": "Missing required scores."}), 400
        if not (0 <= plagiarism_score <= 100) or not (0 <= relevancy_score <= 100) or not (0 <= readability_score <= 100):
            return jsonify({"error": "Scores must be between 0 and 100."}), 400

        # Generate and return pie chart
        return send_file(generate_pie_chart(plagiarism_score, relevancy_score, readability_score), mimetype="image/png")

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True)
