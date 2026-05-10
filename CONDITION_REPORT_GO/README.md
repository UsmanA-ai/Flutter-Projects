# Condition Report Go

**Condition Report Go** is a comprehensive Flutter-based mobile application designed to streamline the process of creating, managing, and sharing property condition reports. It is built to assist property managers, landlords, and inspectors in documenting the state of a property accurately and efficiently.

## 🚀 Features

- **Authentication & Security:** Secure user login and registration powered by Firebase Authentication.
- **Detailed Property Assessments:**
  - **General Details:** Capture broad information about the report and the assessment.
  - **Property Details:** Document specific characteristics of the property.
  - **Occupancy Details:** Record current tenant and occupancy status.
- **Element Tracking:** Add, edit, and evaluate individual property elements (e.g., doors, windows, flooring) using the robust `add_new_element` module.
- **Photo Management:** 
  - Integrated `image_picker` for seamless photo capture.
  - Dedicated modules for **Photo Stream** and tracking **Outstanding Photos** to ensure thorough documentation.
- **Document & PDF Handling:** 
  - Generate comprehensive PDF condition reports.
  - View and manage related documents directly within the app (`documents_screen`).
  - Supports printing and sharing of generated reports.
- **Cloud Synchronization:** 
  - Dual-database architecture utilizing both **Firebase** (Firestore, Storage) and **Supabase** for robust data management and media storage.

## 🛠️ Technology Stack

- **Framework:** Flutter (Dart)
- **State Management:** Provider (`provider`)
- **Backend Services:**
  - **Firebase:** Core, Auth, Firestore, Storage, App Check
  - **Supabase:** Used for supplementary database and cloud functions.
- **UI & Typography:** Custom designs utilizing `google_fonts`, `flutter_svg`, and `cupertino_icons`.
- **Media & File Handling:** `image_picker`, `file_picker`, `path_provider`, `open_file`, and `image` processing.
- **PDF Generation:** `pdf` and `printing` packages to generate professional condition reports.

## 📂 Project Structure

- `lib/models/`: Contains data models such as `property_details_model`, `occupancy_model`, `image_detail`, and `general_details_model`.
- `lib/Screens/`: UI views for distinct functionalities including Condition Reports, General Details, Occupancy, Property Details, Photo Stream, and Document generation.
- `lib/MainScreens/`: Core navigational and dashboard screens (`assesments.dart`, `actions.dart`).
- `lib/services/`: Services handling interactions with external APIs, particularly `firestore_services.dart` and `supabase_services.dart`.
- `lib/provider/`: State management logic controlling app-wide state.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.5.4 or higher)
- Dart SDK
- Access to Firebase and Supabase project configurations (ensure `.env` or configuration files are properly set up).

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/UsmanA-ai/Flutter-Projects.git
   cd Flutter-Projects/CONDITION_REPORT_GO
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

## 📄 License

This project is intended for internal or proprietary use. Please ensure you have the necessary permissions before distributing or modifying the source code.
