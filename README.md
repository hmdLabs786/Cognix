# LuminaQuiz — Glassmorphic Quiz App

[![The Sky Gen Internship](https://img.shields.io/badge/The%20Sky%20Gen-Project%2003-6366F1?style=for-the-badge&logo=flutter)](https://theskygen.com/)
[![Flutter](https://img.shields.io/badge/Flutter-3.47.4-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13.3-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Design](https://img.shields.io/badge/Design-Glassmorphism%20%7C%20Material%203-818CF8?style=for-the-badge)](https://m3.material.io/)
[![License](https://img.shields.io/badge/License-MIT-34D399?style=for-the-badge)](LICENSE)

An iOS-grade, glassmorphic quiz application built from scratch with Flutter for **The Sky Gen Beginner Project 03 ("Quiz App with Score Screen")**. **LuminaQuiz** showcases frosted glass surfaces, vibrant neon feedback, custom physics-based particle celebrations, multi-category trivia decks, and dynamic Light & Dark mode support.

---

## 📱 App Highlights & Visual Experience

- **Deep Frosted Aesthetics**: Layered `BackdropFilter` glass cards with subtle borders, ambient backdrop orbs, and soft drop shadows.
- **Dual Theme Support**: Real-time Light & Dark mode toggle preserving readability and contrast across all elements.
- **Zero API / Database Dependencies**: 100% offline, standalone execution with strongly typed local data models.
- **Predictable State Management**: Immutable questions, bounds-checked answer validation, and zero state leakage upon quiz restart.

---

## ⚡ Features Matrix

| Feature | Description |
| :--- | :--- |
| **Animated Splash Screen** | Glowing scale/fade brand pulse with the Lumina spark emblem, auto-routing to the Home Hub. |
| **Multi-Deck Home Hub** | Rich landing hub displaying user greeting, streak badge (`🔥 5 Days`), daily expedition challenge, and theme switcher. |
| **3 Trivia Realms (30 Questions)** | Hardcoded decks: **General Knowledge**, **Science & Cosmos**, and **Tech & Flutter** (10 questions each). |
| **Smooth iOS Page Transitions** | Custom `IosPageRoute` using `Curves.easeOutQuart` and gentle cross-fade transitions. |
| **Animated Progress Bar** | Smoothly tweened linear progress indicator with live "Question X of 10" and XP score badges. |
| **Interactive Glass Option Cards** | 250ms color transitions with **Neon Emerald** (`#34D399`) for correct answers and **Coral Crimson** (`#F87171`) for incorrect choices. |
| **Tap Locking** | Instantly disables further taps on options once a selection is registered to maintain quiz integrity. |
| **Canvas Celebration Burst** | Custom particle confetti cascade (`CustomPainter`) triggered automatically when score $\ge 60\%$. |
| **Dynamic Performance Tiers** | Custom evaluation badges: **MASTER** ($\ge 90\%$), **PASSED** ($60\%-89\%$), and **KEEP TRYING** ($< 60\%$). |
| **100% Clean Restart Flow** | Route stack reset via `Navigator.pushAndRemoveUntil`, guaranteeing zero state residue on restart. |

---

## 🏗️ Architecture & Project Directory Structure

```text
tsg_quiz_app/
├── android/                          # Android native build files & manifest
│   └── app/src/main/
│       ├── AndroidManifest.xml       # App label: "LuminaQuiz"
│       └── res/mipmap-*/             # Custom LuminaQuiz launcher icons
├── assets/
│   └── icon/                         # Master high-res app icon (512x512)
├── lib/
│   ├── data/
│   │   └── quiz_data.dart            # 3 Hardcoded categories & 30 validated questions
│   ├── models/
│   │   ├── question.dart             # Immutable Question model with answer assertions
│   │   └── quiz_category.dart        # QuizCategory model with metadata & deck binding
│   ├── screens/
│   │   ├── splash_screen.dart        # Animated branding pulse & auto-navigation
│   │   ├── home_screen.dart          # Multi-quiz hub, streak pill, and theme toggle
│   │   ├── quiz_screen.dart          # 10-question quiz loop with progress & answer locking
│   │   └── score_screen.dart         # Metric breakdown & canvas confetti celebration
│   ├── theme/
│   │   ├── app_theme.dart            # Material 3 Light & Dark frosted design system
│   │   └── theme_controller.dart     # Reactive ThemeMode singleton notifier
│   ├── utils/
│   │   └── ios_transition.dart       # iOS slide & fade page route builder
│   ├── widgets/
│   │   ├── glass_card.dart           # Reusable frosted glass component
│   │   └── option_card.dart          # Interactive glass choice button with neon glow
│   └── main.dart                     # App bootstrap listening to ThemeController
├── test/
│   └── widget_test.dart              # Automated tests (overflow, themes, quiz flow, reset)
└── pubspec.yaml                      # Project dependencies & assets configuration
```

---

## 🚀 Setup & Local Execution

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.47+ recommended)
- Java OpenJDK 17
- Android SDK (API 34+) or connected mobile device / emulator

### Step-by-Step Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/tsg-appdev-p03-habban_madani.git
   cd tsg-appdev-p03-habban_madani/tsg_quiz_app
   ```

2. **Install project dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run Static Analysis & Unit Tests**:
   ```bash
   # Verify zero analyzer warnings or errors
   flutter analyze

   # Run automated test suite
   flutter test
   ```

4. **Launch Application in Debug Mode**:
   ```bash
   flutter run
   ```

5. **Generate Production Release APK**:
   ```bash
   flutter build apk --release
   ```
   The generated APK will be located at:
   `build/app/outputs/flutter-apk/app-release.apk`

---

## 📸 Screenshots Guide (Submission Deliverables)

Capture 4 clear screenshots representing the application's lifecycle:

1. **Screen 1 — Home Hub (`home_screen.png`)**:
   - Shows the greeting, streak pill (`5 Days`), theme switcher, Daily Expedition banner, and categories list.
2. **Screen 2 — Question View (`question_screen.png`)**:
   - Shows active Question with category badge, progress bar, score pill, and 4 unselected glass options.
3. **Screen 3 — Instant Answer Feedback (`feedback_screen.png`)**:
   - Shows an answered question highlighting **Neon Emerald** for correct answers (or **Coral Crimson** for incorrect) and active "Next Question" button.
4. **Screen 4 — Score & Celebration Screen (`score_screen.png`)**:
   - Shows final score gauge, accuracy percentage, performance tier badge, and animated celebration particles.

---

## 🎥 Screen Recording Instructions (45–60 Seconds)

Prepare a screen recording showcasing:
1. **Launch**: Splash screen animation transitioning smoothly into Home Screen.
2. **Theme Switch**: Tapping the sun/moon button toggling between Light and Dark mode.
3. **Category Selection**: Tapping a quiz category (e.g., *General Knowledge* or *Science & Cosmos*).
4. **Quiz Playthrough**: Answering through the 10 questions demonstrating:
   - Live progress indicator updates.
   - Immediate feedback colors on option selection.
   - Disabled "Next" button until an option is tapped.
5. **Completion & Celebration**:
   - Landing on the Score Screen with canvas particle confetti animation.
   - Viewing score breakdown (Correct vs Incorrect).
6. **Restart / Home**:
   - Tapping "Restart Quiz" (verifying question 1 loads with 0 score) or "Explore More Quizzes" (returning to Home Hub).

---

## ✅ Submission Checklist

- [x] Flutter project structure initialized with clean architecture.
- [x] Question model with strictly 4 options and 0-based answer index.
- [x] 10+ hardcoded questions per deck (30 total questions across 3 categories).
- [x] Zero API/Database dependencies; 100% reliable local state management.
- [x] Material 3 Glassmorphic visual system with custom app icon.
- [x] Dynamic Light & Dark mode support.
- [x] Verified zero RenderFlex layout overflows on small devices ($\le 320\text{px}$).
- [x] 100% automated test suite passing (`flutter test`).
- [x] Zero static analyzer warnings (`flutter analyze`).
- [x] Production Release APK compiled (`build/app/outputs/flutter-apk/tsg-appdev-p03-habban_madani.apk`).
- [x] Public repository ready for submission.
- [x] Google Drive upload permissions confirmed as **"Anyone with the link can view"**.

---

## 👨‍💻 Author & Acknowledgements
- **Author**: Habban Madani
- **Program**: The Sky Gen Internship (App Development Track)
- **Project**: Beginner Project 03 — Quiz App with Score Screen
