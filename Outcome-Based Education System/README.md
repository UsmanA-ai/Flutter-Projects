# OBE-FYP Management System

**OBE-FYP** is a comprehensive educational management system built to facilitate Outcome-Based Education (OBE) and streamline the evaluation of student performance, particularly focusing on Final Year Projects (FYP) and regular coursework. 

The project features a **Flutter** cross-platform mobile frontend with a dual-backend architecture, utilizing **Firebase** for realtime data and authentication, and a custom **Python (Flask)** AI backend for automated assignment evaluation.

## 🚀 Key Features

### Role-Based Access Control
The application supports three distinct user portals:
- **Admin Portal**: Enroll faculty and students, manage courses, monitor system-wide performance, issue notices, and handle help/complaints.
- **Faculty Portal**: Manage course folders (assignments, quizzes, mids, finals) for CS and SE departments, mark attendance, map assessments to PLOs (Program Learning Outcomes), and analyze student performance.
- **Student Portal**: View attendance, check academic performance, receive notices, and interact with course materials.

### Automated AI Assignment Grading
A dedicated Python Flask backend leverages AI to automatically grade student submissions based on:
- **Relevancy**: Uses `sentence-transformers` to compare student submissions against the assignment prompt.
- **Plagiarism**: Uses `sklearn` TF-IDF and Cosine Similarity to check against a corpus.
- **Readability**: Uses `textstat` for Flesch Reading Ease evaluation.
- Supports PDF, DOCX, and TXT extraction using `pymupdf` and `python-docx`.

### Comprehensive OBE Mapping
- Map quizzes, assignments, midterm, and final exams directly to specific course learning outcomes.
- Visualize performance analysis through generated dashboards and charts.

### Realtime Database & File Management
- **Firebase Auth, Firestore, and Realtime Database** for instant syncing of grades, attendance, and notices.
- **Firebase Storage** for handling user profile pictures and document uploads.

## 🛠️ Technology Stack

**Frontend:**
- Flutter (Dart)
- State Management & Utilities: `provider`, `shared_preferences`, `dio`, `http`
- File Handling: `file_picker`, `open_file`, `pdf`, `excel`, `file_saver`

**Backend (AI Grading Service):**
- Python 3
- Framework: Flask (`flask`, `flask-cors`)
- NLP & ML: `sentence-transformers`, `scikit-learn`
- Data Processing: `pymupdf` (fitz), `python-docx`, `textstat`
- Visualization: `matplotlib`

**Database & Auth:**
- Firebase (Auth, Core, Storage, Firestore, Database)

## 📂 Project Structure

- `lib/admin/`: Admin dashboard and management screens.
- `lib/faculty/`: Faculty workflows, grading, attendance, and OBE mapping.
- `lib/student/`: Student interfaces for academic tracking.
- `lib/components.dart`: Reusable UI components.
- `python/`: Flask backend for AI document analysis and grading.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.5.3 or higher)
- Python 3.8+
- Access to Firebase configuration

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/UsmanA-ai/Flutter-Projects.git
   cd Flutter-Projects/OBE-FYP
   ```

2. **Setup Flutter App:**
   ```bash
   flutter pub get
   flutter run
   ```

3. **Setup Python Backend:**
   ```bash
   cd python
   python -m venv venv
   # On Windows
   venv\Scripts\activate
   # On macOS/Linux
   # source venv/bin/activate
   pip install -r requirements.txt # (or install dependencies listed in app.py)
   python app.py
   ```

## 📄 License
This project is intended for educational or proprietary use. Please ensure you have the necessary permissions before distributing or modifying the source code.
