import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsg_quiz_app/data/quiz_data.dart';
import 'package:tsg_quiz_app/screens/home_screen.dart';
import 'package:tsg_quiz_app/screens/quiz_screen.dart';
import 'package:tsg_quiz_app/screens/score_screen.dart';
import 'package:tsg_quiz_app/screens/splash_screen.dart';
import 'package:tsg_quiz_app/theme/app_theme.dart';
import 'package:tsg_quiz_app/theme/theme_controller.dart';
import 'package:tsg_quiz_app/widgets/option_card.dart';

void main() {
  test('QuizData contains 3 categories with exactly 10 questions each', () {
    final categories = QuizData.categories;
    expect(categories.length, 3);

    for (final category in categories) {
      expect(category.title.isNotEmpty, true);
      expect(category.questions.length, 10);

      for (final question in category.questions) {
        expect(question.questionText.isNotEmpty, true);
        expect(question.options.length, 4);
        expect(question.correctAnswerIndex, inInclusiveRange(0, 3));
        expect(
          question.correctAnswer,
          question.options[question.correctAnswerIndex],
        );
      }
    }
  });

  testWidgets('SplashScreen renders LuminaQuiz branding and elements', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const SplashScreen(autoNavigate: false),
      ),
    );

    expect(find.text('LuminaQuiz'), findsOneWidget);
    expect(find.text('ELEVATE YOUR INTELLECT'), findsOneWidget);
  });

  testWidgets('HomeScreen renders without overflow even on a narrow 320px screen', (WidgetTester tester) async {
    // Set a very narrow viewport size (320x640) like small Android devices
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );

    expect(find.text('LuminaQuiz'), findsOneWidget);
    expect(find.text('5 Days'), findsOneWidget);
    expect(find.text('Explore Quizzes'), findsOneWidget);
    expect(find.text('General Knowledge'), findsOneWidget);

    // Scroll down in ListView to verify remaining categories render without overflow
    await tester.scrollUntilVisible(
      find.text('Tech & Flutter'),
      200.0,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Tech & Flutter'), findsOneWidget);
  });

  testWidgets('ThemeController toggles between dark and light themes smoothly', (WidgetTester tester) async {
    ThemeController.instance.setThemeMode(ThemeMode.dark);
    expect(ThemeController.instance.isDarkMode, true);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeController.instance.themeMode,
        home: const HomeScreen(),
      ),
    );

    // Tap theme toggle button (moon/sun icon)
    final themeToggleFinder = find.byIcon(Icons.light_mode_rounded);
    expect(themeToggleFinder, findsOneWidget);

    await tester.tap(themeToggleFinder);
    await tester.pumpAndSettle();

    expect(ThemeController.instance.isDarkMode, false);
    expect(ThemeController.instance.themeMode, ThemeMode.light);
  });

  testWidgets('Selecting category on HomeScreen navigates to QuizScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const HomeScreen(),
      ),
    );

    await tester.tap(find.text('General Knowledge'));
    await tester.pumpAndSettle();

    expect(find.byType(QuizScreen), findsOneWidget);
    expect(find.text('Question 1 of 10'), findsOneWidget);
    expect(find.byType(OptionCard), findsNWidgets(4));
  });

  testWidgets('Option selection in QuizScreen enables Next Question button', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const QuizScreen(),
      ),
    );

    final nextButtonFinder = find.widgetWithText(ElevatedButton, 'Next Question');
    expect(nextButtonFinder, findsOneWidget);

    ElevatedButton buttonWidget = tester.widget<ElevatedButton>(nextButtonFinder);
    expect(buttonWidget.onPressed, isNull);

    // Tap first option
    final firstOptionFinder = find.byType(OptionCard).first;
    await tester.tap(firstOptionFinder);
    await tester.pumpAndSettle();

    // Next button should be enabled
    buttonWidget = tester.widget<ElevatedButton>(nextButtonFinder);
    expect(buttonWidget.onPressed, isNotNull);

    // Advance to Question 2
    await tester.tap(nextButtonFinder);
    await tester.pumpAndSettle();

    expect(find.text('Question 2 of 10'), findsOneWidget);
  });

  testWidgets('ScoreScreen renders score, accuracy, and performance tiers correctly in both themes', (WidgetTester tester) async {
    // 90%+ Tier in Dark mode
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const ScoreScreen(score: 9, totalQuestions: 10),
      ),
    );

    expect(find.text('Outstanding Performance!'), findsOneWidget);
    expect(find.text('MASTER'), findsOneWidget);
    expect(find.text('9'), findsWidgets);
    expect(find.text(' / 10'), findsOneWidget);
    expect(find.text('90% Accuracy'), findsOneWidget);
    expect(find.text('Restart Quiz'), findsOneWidget);
    expect(find.text('Explore More Quizzes'), findsOneWidget);

    // 60% - 89% Tier in Light mode
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const ScoreScreen(score: 7, totalQuestions: 10),
      ),
    );

    expect(find.text('Good Job!'), findsOneWidget);
    expect(find.text('PASSED'), findsOneWidget);
    expect(find.text('70% Accuracy'), findsOneWidget);

    // < 60% Tier
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const ScoreScreen(score: 4, totalQuestions: 10),
      ),
    );

    expect(find.text('Needs Practice!'), findsOneWidget);
    expect(find.text('KEEP TRYING'), findsOneWidget);
    expect(find.text('40% Accuracy'), findsOneWidget);
  });

  testWidgets('ScoreScreen Restart Quiz resets to Question 1', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const ScoreScreen(score: 8, totalQuestions: 10),
      ),
    );

    final restartFinder = find.text('Restart Quiz');
    await tester.ensureVisible(restartFinder);
    await tester.tap(restartFinder);
    await tester.pumpAndSettle();

    expect(find.byType(QuizScreen), findsOneWidget);
    expect(find.text('Question 1 of 10'), findsOneWidget);
    expect(find.text('Score: 0'), findsOneWidget);
  });

  testWidgets('ScoreScreen Explore More Quizzes navigates to HomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: const ScoreScreen(score: 8, totalQuestions: 10),
      ),
    );

    final exploreFinder = find.text('Explore More Quizzes');
    await tester.ensureVisible(exploreFinder);
    await tester.tap(exploreFinder);
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Explore Quizzes'), findsOneWidget);
  });
}
