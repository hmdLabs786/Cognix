import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'quiz_screen.dart';
import 'start_screen.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ScoreScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  double get _percentage =>
      totalQuestions > 0 ? (score / totalQuestions) * 100 : 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentageInt = _percentage.toInt();
    final incorrectCount = totalQuestions - score;

    final String headline;
    final String subtitle;
    final Color tierColor;
    final IconData tierIcon;
    final String badgeLabel;

    if (_percentage >= 80) {
      headline = 'Outstanding Achievement!';
      subtitle = 'Exceptional performance! You mastered this challenge.';
      tierColor = AppTheme.success;
      tierIcon = Icons.emoji_events_rounded;
      badgeLabel = 'MASTER';
    } else if (_percentage >= 50) {
      headline = 'Good Effort!';
      subtitle = 'Well done! You have a solid grasp of general knowledge.';
      tierColor = AppTheme.primaryLight;
      tierIcon = Icons.workspace_premium_rounded;
      badgeLabel = 'PASSED';
    } else {
      headline = 'Needs Practice!';
      subtitle = 'Keep learning! Review the facts and try again.';
      tierColor = const Color(0xFFF59E0B); // Amber
      tierIcon = Icons.fitness_center_rounded;
      badgeLabel = 'KEEP TRYING';
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Achievement Badge Icon
                Center(
                  child: Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      color: tierColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: tierColor.withValues(alpha: 0.35),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      tierIcon,
                      size: 44,
                      color: tierColor,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Performance Tier Pill
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: tierColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: tierColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      badgeLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: tierColor,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Headline
                Text(
                  headline,
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),

                // Subtitle
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),

                // Clean Score Summary Card
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.border, width: 1.2),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'FINAL SCORE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '$score',
                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w900,
                              color: tierColor,
                              height: 1.0,
                            ),
                          ),
                          Text(
                            ' / $totalQuestions',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$percentageInt% Accuracy',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Divider(height: 1, color: AppTheme.border),
                      ),

                      // Correct vs Incorrect Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildMetric(
                              label: 'Correct',
                              value: '$score',
                              color: AppTheme.success,
                              icon: Icons.check_circle_outline_rounded,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 40,
                            color: AppTheme.border,
                          ),
                          Expanded(
                            child: _buildMetric(
                              label: 'Incorrect',
                              value: '$incorrectCount',
                              color: AppTheme.error,
                              icon: Icons.highlight_off_rounded,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Restart Quiz Button
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh_rounded, size: 22),
                  label: const Text(
                    'Restart Quiz',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                      (route) => route.isFirst,
                    );
                  },
                ),
                const SizedBox(height: 12),

                // Back to Home Button
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textPrimary,
                    side: const BorderSide(color: AppTheme.border, width: 1.2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.home_rounded, size: 20),
                  label: const Text(
                    'Back to Home',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const StartScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetric({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}
