import 'dart:math';
import 'package:flutter/material.dart';
import '../models/quiz_category.dart';
import '../theme/app_theme.dart';
import '../utils/ios_transition.dart';
import '../widgets/glass_card.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';

class ScoreScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;
  final QuizCategory? category;

  const ScoreScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    this.category,
  });

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _celebrationController;
  late final List<_ConfettiParticle> _particles;
  final Random _random = Random();

  double get _percentage =>
      widget.totalQuestions > 0 ? (widget.score / widget.totalQuestions) * 100 : 0;

  bool get _isCelebration => _percentage >= 60;

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _particles = List.generate(60, (index) => _createParticle());

    if (_isCelebration) {
      _celebrationController.forward();
    }
  }

  _ConfettiParticle _createParticle() {
    final colors = [
      AppTheme.electricViolet,
      AppTheme.neonEmerald,
      AppTheme.amberGold,
      const Color(0xFF38BDF8),
      const Color(0xFFF472B6),
    ];
    final angle = _random.nextDouble() * 2 * pi;
    final speed = 120 + _random.nextDouble() * 280;

    return _ConfettiParticle(
      color: colors[_random.nextInt(colors.length)],
      startX: 0.5,
      startY: 0.35,
      velocityX: cos(angle) * speed,
      velocityY: sin(angle) * speed - 150,
      size: 5 + _random.nextDouble() * 6,
      rotation: _random.nextDouble() * 2 * pi,
      rotationSpeed: (_random.nextDouble() - 0.5) * 8,
    );
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentageInt = _percentage.toInt();
    final incorrectCount = widget.totalQuestions - widget.score;
    final isDark = AppTheme.isDark(context);
    final textPrimary = AppTheme.getTextPrimary(context);
    final textSecondary = AppTheme.getTextSecondary(context);

    final String headline;
    final String subtitle;
    final Color tierColor;
    final IconData tierIcon;
    final String badgeLabel;

    if (_percentage >= 90) {
      headline = 'Outstanding Performance!';
      subtitle = 'Master level! You have conquered this realm.';
      tierColor = AppTheme.neonEmerald;
      tierIcon = Icons.emoji_events_rounded;
      badgeLabel = 'MASTER';
    } else if (_percentage >= 60) {
      headline = 'Good Job!';
      subtitle = 'Well done! You have a solid grasp of the concepts.';
      tierColor = AppTheme.electricViolet;
      tierIcon = Icons.workspace_premium_rounded;
      badgeLabel = 'PASSED';
    } else {
      headline = 'Needs Practice!';
      subtitle = 'Keep exploring! Knowledge expands with practice.';
      tierColor = AppTheme.amberGold;
      tierIcon = Icons.fitness_center_rounded;
      badgeLabel = 'KEEP TRYING';
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.getBackgroundGradient(context),
        ),
        child: Stack(
          children: [
            // Ambient glow
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: MediaQuery.of(context).size.width * 0.15,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tierColor.withValues(alpha: isDark ? 0.12 : 0.08),
                  boxShadow: [
                    BoxShadow(
                      color: tierColor.withValues(alpha: isDark ? 0.18 : 0.10),
                      blurRadius: 100,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 24.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Tier Icon
                      Center(
                        child: Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: tierColor.withValues(
                              alpha: isDark ? 0.18 : 0.12,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: tierColor.withValues(
                                alpha: isDark ? 0.4 : 0.3,
                              ),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: tierColor.withValues(
                                  alpha: isDark ? 0.35 : 0.2,
                                ),
                                blurRadius: 24,
                              ),
                            ],
                          ),
                          child: Icon(
                            tierIcon,
                            size: 46,
                            color: tierColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Badge Label
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: tierColor.withValues(
                              alpha: isDark ? 0.18 : 0.12,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: tierColor.withValues(
                                alpha: isDark ? 0.35 : 0.25,
                              ),
                            ),
                          ),
                          child: Text(
                            badgeLabel,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: tierColor,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Headline
                      Text(
                        headline,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: textPrimary,
                          letterSpacing: -0.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Prominent Glass Score Card
                      GlassCard(
                        borderRadius: 24,
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Text(
                              'FINAL SCORE',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                                color: textSecondary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '${widget.score}',
                                  style: TextStyle(
                                    fontSize: 54,
                                    fontWeight: FontWeight.w900,
                                    color: tierColor,
                                    height: 1.0,
                                  ),
                                ),
                                Text(
                                  ' / ${widget.totalQuestions}',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '$percentageInt% Accuracy',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Divider(
                              height: 1,
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.08),
                            ),
                            const SizedBox(height: 18),

                            // Statistics breakdown
                            Row(
                              children: [
                                Expanded(
                                  child: _buildMetric(
                                    label: 'Correct',
                                    value: '${widget.score}',
                                    color: AppTheme.neonEmerald,
                                    icon: Icons.check_circle_outline_rounded,
                                    textSecondary: textSecondary,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.1)
                                      : Colors.black.withValues(alpha: 0.08),
                                ),
                                Expanded(
                                  child: _buildMetric(
                                    label: 'Incorrect',
                                    value: '$incorrectCount',
                                    color: AppTheme.coralCrimson,
                                    icon: Icons.highlight_off_rounded,
                                    textSecondary: textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Restart Quiz Button
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: AppTheme.electricGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.electricViolet.withValues(alpha: 0.4),
                              blurRadius: 18,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
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
                              IosPageRoute(
                                page: QuizScreen(category: widget.category),
                              ),
                              (route) => route.isFirst,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Explore More Quizzes / Back to Home Button
                      GlassCard(
                        borderRadius: 18,
                        padding: EdgeInsets.zero,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              IosPageRoute(page: const HomeScreen()),
                              (route) => false,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.explore_rounded,
                                  size: 20,
                                  color: textPrimary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Explore More Quizzes',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Animated Confetti Celebration Overlay
            if (_isCelebration)
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _celebrationController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: _ConfettiPainter(
                          particles: _particles,
                          progress: _celebrationController.value,
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
    required Color textSecondary,
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
          style: TextStyle(
            fontSize: 12,
            color: textSecondary,
          ),
        ),
      ],
    );
  }
}

class _ConfettiParticle {
  final Color color;
  final double startX;
  final double startY;
  final double velocityX;
  final double velocityY;
  final double size;
  final double rotation;
  final double rotationSpeed;

  _ConfettiParticle({
    required this.color,
    required this.startX,
    required this.startY,
    required this.velocityX,
    required this.velocityY,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({
    required this.particles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0 || progress == 1) return;

    final paint = Paint()..style = PaintingStyle.fill;
    final gravity = 400 * progress * progress;

    for (final p in particles) {
      final x = size.width * p.startX + p.velocityX * progress * 0.8;
      final y = size.height * p.startY + p.velocityY * progress * 0.8 + gravity;

      final opacity = (1.0 - progress).clamp(0.0, 1.0);
      paint.color = p.color.withValues(alpha: opacity);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rotation + p.rotationSpeed * progress);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.6),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
