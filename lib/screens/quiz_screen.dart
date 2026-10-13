import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/question.dart';
import '../models/quiz_category.dart';
import '../theme/app_theme.dart';
import '../utils/ios_transition.dart';
import '../widgets/glass_card.dart';
import '../widgets/option_card.dart';
import 'score_screen.dart';

class QuizScreen extends StatefulWidget {
  final QuizCategory? category;

  const QuizScreen({
    super.key,
    this.category,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizCategory _category;
  late final List<Question> _questions;
  static const List<String> _optionLabels = ['A', 'B', 'C', 'D'];

  int _currentIndex = 0;
  int? _selectedOptionIndex;
  int _score = 0;
  bool _isAnswered = false;

  @override
  void initState() {
    super.initState();
    _category = widget.category ?? QuizData.categories.first;
    _questions = _category.questions.isNotEmpty
        ? _category.questions
        : QuizData.generalKnowledgeQuestions;
  }

  Question get _currentQuestion => _questions[_currentIndex];
  bool get _isLastQuestion => _currentIndex == _questions.length - 1;

  void _selectOption(int index) {
    if (_isAnswered) return;

    setState(() {
      _selectedOptionIndex = index;
      _isAnswered = true;
      if (index == _currentQuestion.correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _handleNextQuestion() {
    if (!_isAnswered) return;

    if (!_isLastQuestion) {
      setState(() {
        _currentIndex++;
        _selectedOptionIndex = null;
        _isAnswered = false;
      });
    } else {
      Navigator.of(context).pushReplacement(
        IosPageRoute(
          page: ScoreScreen(
            score: _score,
            totalQuestions: _questions.length,
            category: _category,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalQuestions = _questions.length;
    final progress = (_currentIndex + 1) / totalQuestions;
    final isDark = AppTheme.isDark(context);
    final textPrimary = AppTheme.getTextPrimary(context);
    final textSecondary = AppTheme.getTextSecondary(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.getBackgroundGradient(context),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom Glassmorphic App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                      color: textPrimary,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _category.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                          Text(
                            'Question ${_currentIndex + 1} of $totalQuestions',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Live Score Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTheme.electricViolet.withValues(alpha: 0.35),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.stars_rounded,
                            size: 16,
                            color: AppTheme.electricViolet,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Score: $_score',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : AppTheme.electricViolet,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Animated Progress Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 6,
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.black.withValues(alpha: 0.06),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeOutCubic,
                            width: constraints.maxWidth * progress,
                            decoration: BoxDecoration(
                              gradient: AppTheme.electricGradient,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.electricViolet.withValues(alpha: 0.5),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Question GlassCard
                      GlassCard(
                        borderRadius: 22,
                        padding: const EdgeInsets.all(22.0),
                        borderColor: isDark
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.black.withValues(alpha: 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _category.accentColor.withValues(
                                  alpha: isDark ? 0.2 : 0.12,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _category.title.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: _category.accentColor,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              _currentQuestion.questionText,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Options List
                      ...List.generate(
                        _currentQuestion.options.length,
                        (index) {
                          final isCorrect =
                              index == _currentQuestion.correctAnswerIndex;
                          final isSelected = _selectedOptionIndex == index;

                          return OptionCard(
                            optionLabel: _optionLabels[index],
                            optionText: _currentQuestion.options[index],
                            isSelected: isSelected,
                            isAnswered: _isAnswered,
                            isCorrect: isCorrect,
                            onTap: () => _selectOption(index),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Action Bar
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.25)
                      : Colors.white.withValues(alpha: 0.9),
                  border: Border(
                    top: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.08)
                          : Colors.black.withValues(alpha: 0.06),
                      width: 1,
                    ),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: _isAnswered ? AppTheme.electricGradient : null,
                      boxShadow: _isAnswered
                          ? [
                              BoxShadow(
                                color: AppTheme.electricViolet.withValues(alpha: 0.4),
                                blurRadius: 18,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isAnswered
                            ? Colors.transparent
                            : (isDark
                                ? Colors.white.withValues(alpha: 0.08)
                                : Colors.black.withValues(alpha: 0.05)),
                        shadowColor: Colors.transparent,
                        foregroundColor: _isAnswered
                            ? Colors.white
                            : textSecondary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                            color: _isAnswered
                                ? Colors.white.withValues(alpha: 0.3)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      onPressed: _isAnswered ? _handleNextQuestion : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isLastQuestion ? 'Finish Quiz' : 'Next Question',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _isLastQuestion
                                ? Icons.check_circle_outline_rounded
                                : Icons.arrow_forward_rounded,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
