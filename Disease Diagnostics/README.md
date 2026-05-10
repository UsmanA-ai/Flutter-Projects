# Disease Diagnostics Web App 🔬

A cutting-edge, Flutter Web-based artificial intelligence application designed for rapid diagnostic classification. This platform utilizes pre-trained Deep Learning models to provide instant preliminary analysis of medical imagery directly in the browser.

## Features ✨
- **🧠 Brain Tumor Detection**: Analyzes MRI scans to detect and classify Meningioma, Glioma, and Pituitary tumors.
- **⚕️ Skin Cancer Detection**: Evaluates dermatological images to identify Melanoma and Basal Cell Carcinomas.
- **🌐 Web-Native AI Inference**: Uses TensorFlow.js (`tfjs`) bridged securely via Dart `js_interop` to run heavy TFLite models natively within the browser, requiring no backend server.
- **🎨 Premium UI/UX**: Features a modern, responsive Glassmorphism design system tailored with dynamic animations, scrollable layouts, and sleek system fonts.
- **🔒 Secure Authentication Flow**: Includes built-in login and signup portals with seamless smart routing back to your selected diagnostic tool.

## Technology Stack
- **Framework**: Flutter (Web explicitly targeted)
- **Machine Learning**: TensorFlow Lite / TensorFlow.js
- **Styling**: Vanilla Flutter Material 3 with Custom Dark Gradients & Backdrop Blur Filters
- **Web Bridge**: Dart JS Interop

## How to Run Locally 💻

1. Clone the repository and navigate to this folder.
2. Ensure you have the Flutter SDK installed and web support enabled.
3. Install the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the project specifically on Chrome (required for JS Interop testing):
   ```bash
   flutter run -d chrome
   ```

## Deployment 🚀
This project is fully optimized for continuous deployment platforms like **Vercel** or **GitHub Pages**.

To build the optimized production web bundle manually:
```bash
flutter build web --release
```
