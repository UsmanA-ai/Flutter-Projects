# ClinikScan AI - Disease Diagnostics 🧠🔬

ClinikScan AI is a premium, production-ready medical diagnostics platform built with Flutter and powered by state-of-the-art AI models. It specializes in the early detection and analysis of Brain Tumors (from MRI scans) and Skin Cancer (using the HAM10000 dataset categories).

## ✨ Key Features
- **Global Neuron Background**: An interactive, mouse-tracking neural network animation that persists across all screens.
- **Dual AI Diagnostics**:
  - **Brain Tumor Detection**: Analyzes MRI scans for Glioma, Meningioma, and Pituitary tumors.
  - **Skin Cancer Detection**: Identifies 7 types of skin lesions (MEL, BCC, AKIEC, BKL, DF, NV, VASC).
- **Real-Time AI Insights**: Powered by **Llama 3.1** via Groq, providing empathetic, human-friendly medical explanations for every scan.
- **AI Medical Assistant**: A built-in real-time chatbot for follow-up questions about diagnostic results.
- **Cloud Infrastructure**: 
  - **Supabase Auth**: Secure Email & Google login.
  - **Supabase Storage**: High-speed image hosting for scans.
  - **Analysis History**: Persistent history tracking for every user scan.

## 🛠️ Tech Stack
- **Frontend**: Flutter (Web Optimized)
- **Backend**: Supabase (Auth, DB, Storage)
- **AI Inference**: TFJS-TFLite (Browser-side)
- **AI Insights**: Groq Cloud (Llama 3.1 LLM)
- **Styling**: Modern Glassmorphism & Custom Neuron Animations

## 🚀 Getting Started

### 1. Supabase Setup
- Create a new project on [Supabase](https://supabase.com/).
- Create a storage bucket named `analysis-images` and set it to **Public**.
- Run the following SQL in the Editor to create the history table:
```sql
CREATE TABLE analysis_history (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id),
    model_type TEXT,
    result_label TEXT,
    confidence FLOAT,
    image_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### 2. API Keys
- Add your Supabase URL and Anon Key in `lib/main.dart`.
- Get a free Groq API key from [Groq Console](https://console.groq.com/).
- Add the key to `lib/api_keys.dart`.

### 3. Run the App
```bash
flutter pub get
flutter run -d chrome
```

## 🛡️ Security
This app uses **Row Level Security (RLS)** in Supabase to ensure that users can only view their own diagnostic history, protecting sensitive medical data.

---
Developed with ❤️ by Usman
