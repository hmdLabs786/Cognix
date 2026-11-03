# Cognix — High-Performance Quiz Application

[![The Sky Gen Internship](https://img.shields.io/badge/The%20Sky%20Gen-Project%2003-6366F1?style=for-the-badge&logo=flutter)](https://theskygen.com/)
[![Flutter](https://img.shields.io/badge/Flutter-3.47.4-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13.3-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Design](https://img.shields.io/badge/Design-High--Performance%20%7C%20Material%203-10B981?style=for-the-badge)](https://m3.material.io/)
[![License](https://img.shields.io/badge/License-MIT-38BDF8?style=for-the-badge)](LICENSE)

**Cognix** is a fast, 60–120 FPS high-performance mobile quiz application built with Flutter for **The Sky Gen Beginner Project 03 ("Quiz App with Score Screen")**. Engineered with zero-jank hardware-accelerated components, **Cognix** delivers instant touch response, immediate answer validation, smooth state-driven screen navigation, and a clean modern aesthetic.

---

## 🎯 01 Project Objective

This project practises navigation between screens and holding state as the user moves through a flow. The questions are hard-coded, so there is no networking to worry about; the focus is on getting the logic and the screen transitions right.

---

## ✨ 02 Required Features

- [x] **Start Screen**: Displays the unique **Cognix** emblem, quiz title, subtitle, feature summary, and an elevated "Start Quiz" button.
- [x] **Ten Questions Stored Inside the App**: 10 curated general knowledge questions, each with 4 distinct options and exactly 1 verified correct answer.
- [x] **One Question per Screen**: Focused single-question display with a bottom action button.
- [x] **Activated Next Button**: The "Next Question" button remains strictly **disabled** (`onPressed: null`) until an option is selected.
- [x] **Answer Feedback**:
  - The chosen option instantly highlights in **Emerald Green** (`#10B981`) if correct.
  - Highlights in **Coral Red** (`#EF4444`) if incorrect while revealing the true correct answer.
  - Option tapping locks immediately upon selection to prevent multiple answers.
- [x] **Progress Indicator**: Shows "Question X of 10" with real-time percentage badge and smooth linear progress bar.
- [x] **Score Screen**: Displays final score (e.g. `8 / 10`), accuracy percentage, metric breakdown, and dynamic performance message:
  - $\ge 80\%$: *"Outstanding Achievement! You demonstrated exceptional mastery."*
  - $50\% - 79\%$: *"Good Effort! Solid performance across the board."*
  - $< 50\%$: *"Needs Practice! Keep learning and try again."*
- [x] **Restart Button**: Resets the entire quiz back to Question 1 with a cleared 0 score using clean navigation (`Navigator.pushAndRemoveUntil`).
- [x] **Consistent Design**: Unified palette (Slate & Indigo) and clean typography used consistently across all screens.

---

## ⚡ Zero-Lag Performance Architecture

Older iterations utilizing `BackdropFilter` and runtime blur shaders were stripped out. **Cognix** uses pure hardware-accelerated solid surfaces:
- **Instant Touch Response**: 180ms ease-out transitions for zero perceived latency.
- **Battery-Friendly Dark Theme**: `#0F172A` deep background with `#1E293B` cards.
- **No Frame Drops**: Tested and verified smooth 60–120 FPS on standard budget mobile chipsets.

---

## 🏗️ Folder Structure

```text
tsg_quiz_app/
├── android/                          # Android native build configurations
│   └── app/src/main/
│       ├── AndroidManifest.xml       # App label: "Cognix"
│       └── res/mipmap-*/             # Custom Cognix launcher icons
├── assets/
│   └── icon/app_icon.png             # Master 512x512 icon asset
├── lib/
│   ├── data/
│   │   └── quiz_data.dart            # Hardcoded 10-question dataset
│   ├── models/
│   │   └── question.dart             # Immutable Question domain model
│   ├── screens/
│   │   ├── start_screen.dart         # Intro screen with start button
│   │   ├── quiz_screen.dart          # 10-question interactive flow & progress
│   │   └── score_screen.dart         # Score evaluation & restart logic
│   ├── theme/
│   │   └── app_theme.dart            # Unified Slate/Indigo design system
│   ├── widgets/
│   │   └── option_card.dart          # Snappy, zero-jank option button
│   └── main.dart                     # App bootstrap routing to StartScreen
├── test/
│   └── widget_test.dart              # Automated widget & unit test suite
└── pubspec.yaml                      # Dependencies & metadata
```

---

## 🚀 Setup & Local Build Instructions

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.19+ (tested on Flutter 3.47.4)
- Java OpenJDK 17
- Android SDK (API 34+)

### Commands

1. **Clone the repository**:
   ```bash
   git clone https://github.com/hmdLabs786/LuminaQuiz.git
   cd LuminaQuiz
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run Static Analyzer**:
   ```bash
   flutter analyze
   ```
   *(Expected: `No issues found!`)*

4. **Run Automated Test Suite**:
   ```bash
   flutter test
   ```
   *(Expected: `All tests passed!`)*

5. **Run on Connected Device**:
   ```bash
   flutter run
   ```

6. **Assemble Production Release APK**:
   ```bash
   flutter build apk --release
   ```
   Output location:
   `build/app/outputs/flutter-apk/app-release.apk`

---

## 📦 Deliverables & Submission Checklist

- [x] **Release APK**: Built and verified (`build/app/outputs/flutter-apk/tsg-appdev-p03-habban_madani.apk`).
- [x] **Unique App Name**: **Cognix** with custom app icon.
- [x] **10 Questions**: Stored locally in `QuizData.questions`.
- [x] **Activated Next Button**: Strictly disabled until an option is picked.
- [x] **Visual Answer Feedback**: Emerald (correct) and Coral (incorrect) highlighting.
- [x] **Progress Tracking**: "Question X of 10" with matching linear indicator.
- [x] **Score & Feedback Screen**: Percentage accuracy and custom performance messaging.
- [x] **Restart Flow**: 100% state reset to Question 1 with 0 score.
- [x] **Documentation**: Clean README with architecture and build steps.

---

## 👨‍💻 Author
- **Developer**: Habban Madani
- **Internship**: The Sky Gen (Mobile App Development Track)
- **Project**: Beginner Project 03 — Quiz App with Score Screen
