import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsg_quiz_app/data/quiz_data.dart';
import 'package:tsg_quiz_app/main.dart';
import 'package:tsg_quiz_app/screens/quiz_screen.dart';
import 'package:tsg_quiz_app/screens/score_screen.dart';
import 'package:tsg_quiz_app/theme/app_theme.dart';
import 'package:tsg_quiz_app/widgets/option_card.dart';

void main() {
  test('QuizData contains exactly 10 questions with 4 options and valid answer index', () {
    final questions = QuizData.questions;
    expect(questions.length, 10);

    for (final question in questions) {
      expect(question.questionText.isNotEmpty, true);
      expect(question.options.length, 4);
      expect(question.correctAnswerIndex, inInclusiveRange(0, 3));
      expect(
        question.correctAnswer,
        question.options[question.correctAnswerIndex],
      );
    }
  });

  testWidgets('StartScreen renders Cognix title, info card, and navigates to QuizScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const CognixApp());

    expect(find.text('Cognix'), findsOneWidget);
    expect(find.text('General Knowledge Challenge'), findsOneWidget);
    expect(find.text('10 Questions'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);

    // Tap Start Quiz
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();

    // Verify QuizScreen is now displayed
    expect(find.byType(QuizScreen), findsOneWidget);
    expect(find.text('Question 1 of 10'), findsOneWidget);
    expect(find.byType(OptionCard), findsNWidgets(4));
  });

  testWidgets('QuizScreen next button remains disabled until option is selected', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        home: const QuizScreen(),
      ),
    );

    final nextButtonFinder = find.widgetWithText(ElevatedButton, 'Next Question');
    expect(nextButtonFinder, findsOneWidget);

    ElevatedButton buttonWidget = tester.widget<ElevatedButton>(nextButtonFinder);
    expect(buttonWidget.onPressed, isNull);

    // Select the first option
    final firstOption = find.byType(OptionCard).first;
    await tester.tap(firstOption);
    await tester.pumpAndSettle();

    // Next Question button must now be enabled
    buttonWidget = tester.widget<ElevatedButton>(nextButtonFinder);
    expect(buttonWidget.onPressed, isNotNull);

    // Tap Next Question to move to Question 2
    await tester.tap(nextButtonFinder);
    await tester.pumpAndSettle();

    expect(find.text('Question 2 of 10'), findsOneWidget);
  });

  testWidgets('ScoreScreen renders score, accuracy, and performance message correctly', (WidgetTester tester) async {
    // Test high score (8 / 10)
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        home: const ScoreScreen(score: 8, totalQuestions: 10),
      ),
    );

    expect(find.text('Outstanding Achievement!'), findsOneWidget);
    expect(find.text('MASTER'), findsOneWidget);
    expect(find.text('8'), findsWidgets);
    expect(find.text(' / 10'), findsOneWidget);
    expect(find.text('80% Accuracy'), findsOneWidget);
    expect(find.text('Restart Quiz'), findsOneWidget);
    expect(find.text('Back to Home'), findsOneWidget);

    // Test mid score (6 / 10)
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        home: const ScoreScreen(score: 6, totalQuestions: 10),
      ),
    );

    expect(find.text('Good Effort!'), findsOneWidget);
    expect(find.text('PASSED'), findsOneWidget);
    expect(find.text('60% Accuracy'), findsOneWidget);

    // Test low score (4 / 10)
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        home: const ScoreScreen(score: 4, totalQuestions: 10),
      ),
    );

    expect(find.text('Needs Practice!'), findsOneWidget);
    expect(find.text('KEEP TRYING'), findsOneWidget);
    expect(find.text('40% Accuracy'), findsOneWidget);
  });

  testWidgets('ScoreScreen Restart Quiz resets to Question 1 with cleared score', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.theme,
        home: const ScoreScreen(score: 7, totalQuestions: 10),
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

  testWidgets('Full quiz playthrough from Question 1 to 10 navigates to ScoreScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const CognixApp());

    // Start Quiz
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();

    // Answer all 10 questions
    for (int i = 0; i < 10; i++) {
      expect(find.text('Question ${i + 1} of 10'), findsOneWidget);

      // Tap first option
      await tester.tap(find.byType(OptionCard).first);
      await tester.pumpAndSettle();

      // Tap Next / Finish button
      final actionButton = find.widgetWithText(
        ElevatedButton,
        i == 9 ? 'Finish Quiz' : 'Next Question',
      );
      await tester.tap(actionButton);
      await tester.pumpAndSettle();
    }

    // Verify ScoreScreen is displayed
    expect(find.byType(ScoreScreen), findsOneWidget);
    expect(find.text('FINAL SCORE'), findsOneWidget);
  });
}
