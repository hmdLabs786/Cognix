import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/quiz_category.dart';
import '../theme/app_theme.dart';
import '../theme/theme_controller.dart';
import '../utils/ios_transition.dart';
import '../widgets/glass_card.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories = QuizData.categories;
    final isDark = AppTheme.isDark(context);
    final textPrimary = AppTheme.getTextPrimary(context);
    final textSecondary = AppTheme.getTextSecondary(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.getBackgroundGradient(context),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            children: [
              // Header: Greeting, Streak Badge & Theme Switcher
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Greeting & Title (Expanded to prevent any overflow)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back, Explorer ✨',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'LuminaQuiz',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                            color: textPrimary,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Actions: Streak Pill + Theme Toggle
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Streak Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.amber.withValues(alpha: 0.4),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withValues(alpha: 0.15),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_fire_department_rounded,
                              size: 16,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '5 Days',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Theme Toggle Button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => ThemeController.instance.toggleTheme(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.black.withValues(alpha: 0.05),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.15)
                                    : Colors.black.withValues(alpha: 0.1),
                              ),
                            ),
                            child: Icon(
                              isDark
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              size: 18,
                              color: isDark
                                  ? Colors.amber
                                  : AppTheme.electricViolet,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Hero Banner Card
              GlassCard(
                borderRadius: 24,
                padding: const EdgeInsets.all(20),
                backgroundGradient: isDark
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0x38818CF8),
                          Color(0x14A855F7),
                        ],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0x22818CF8),
                          Color(0x12A855F7),
                        ],
                      ),
                borderColor: AppTheme.electricViolet.withValues(
                  alpha: isDark ? 0.4 : 0.3,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.electricViolet.withValues(
                                alpha: isDark ? 0.25 : 0.15,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'DAILY EXPEDITION',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                color: AppTheme.electricViolet,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'General Knowledge Challenge',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Earn +50 XP and elevate your global rank today.',
                            style: TextStyle(
                              fontSize: 13,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          IosPageRoute(
                            page: QuizScreen(category: categories.first),
                          ),
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: AppTheme.electricGradient,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.electricViolet.withValues(alpha: 0.45),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              // Categories Section Title
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Explore Quizzes',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${categories.length} Categories',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Category Cards
              ...categories.map(
                (category) => _buildCategoryCard(context, category, textPrimary, textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    QuizCategory category,
    Color textPrimary,
    Color textSecondary,
  ) {
    final isDark = AppTheme.isDark(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: GlassCard(
        borderRadius: 22,
        padding: const EdgeInsets.all(16.0),
        onTap: () {
          Navigator.of(context).push(
            IosPageRoute(
              page: QuizScreen(category: category),
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Category Icon with glow
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: category.accentColor.withValues(
                  alpha: isDark ? 0.18 : 0.12,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: category.accentColor.withValues(
                    alpha: isDark ? 0.4 : 0.3,
                  ),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: category.accentColor.withValues(alpha: 0.2),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Icon(
                category.icon,
                size: 26,
                color: category.accentColor,
              ),
            ),
            const SizedBox(width: 14),

            // Category Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Tags using Wrap to guarantee zero overflow
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      // Difficulty tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.12)
                                : Colors.black.withValues(alpha: 0.08),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          category.difficulty,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: category.accentColor,
                          ),
                        ),
                      ),

                      // Questions count tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.12)
                                : Colors.black.withValues(alpha: 0.08),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '${category.questionCount} Questions',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Chevron
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.35)
                  : Colors.black.withValues(alpha: 0.25),
            ),
          ],
        ),
      ),
    );
  }
}
