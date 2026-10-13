import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OptionCard extends StatelessWidget {
  final String optionText;
  final String optionLabel; // e.g., 'A', 'B', 'C', 'D'
  final bool isSelected;
  final bool isAnswered;
  final bool isCorrect;
  final VoidCallback? onTap;

  const OptionCard({
    super.key,
    required this.optionText,
    required this.optionLabel,
    required this.isSelected,
    required this.isAnswered,
    required this.isCorrect,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppTheme.isDark(context);
    final textPrimary = AppTheme.getTextPrimary(context);
    final textSecondary = AppTheme.getTextSecondary(context);

    Color backgroundColor = isDark
        ? Colors.white.withValues(alpha: 0.07)
        : Colors.white.withValues(alpha: 0.85);
    Color borderColor = isDark
        ? Colors.white.withValues(alpha: 0.16)
        : Colors.black.withValues(alpha: 0.09);
    Color labelBackgroundColor = isDark
        ? Colors.white.withValues(alpha: 0.10)
        : Colors.black.withValues(alpha: 0.06);
    Color labelTextColor = textPrimary;
    Color contentTextColor = textPrimary;
    List<BoxShadow>? boxShadow = isDark
        ? null
        : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ];
    Widget? trailingIcon;

    if (isAnswered) {
      if (isCorrect) {
        backgroundColor = isDark
            ? AppTheme.neonEmerald.withValues(alpha: 0.18)
            : const Color(0xFFECFDF5);
        borderColor = AppTheme.neonEmerald;
        labelBackgroundColor = AppTheme.neonEmerald;
        labelTextColor = isDark ? Colors.black : Colors.white;
        contentTextColor = isDark ? Colors.white : const Color(0xFF065F46);
        boxShadow = [
          BoxShadow(
            color: AppTheme.neonEmerald.withValues(alpha: isDark ? 0.35 : 0.25),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ];
        trailingIcon = const Icon(
          Icons.check_circle_rounded,
          color: AppTheme.neonEmerald,
          size: 24,
        );
      } else if (isSelected && !isCorrect) {
        backgroundColor = isDark
            ? AppTheme.coralCrimson.withValues(alpha: 0.18)
            : const Color(0xFFFEF2F2);
        borderColor = AppTheme.coralCrimson;
        labelBackgroundColor = AppTheme.coralCrimson;
        labelTextColor = Colors.white;
        contentTextColor = isDark ? Colors.white : const Color(0xFF991B1B);
        boxShadow = [
          BoxShadow(
            color: AppTheme.coralCrimson.withValues(alpha: isDark ? 0.35 : 0.25),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ];
        trailingIcon = const Icon(
          Icons.cancel_rounded,
          color: AppTheme.coralCrimson,
          size: 24,
        );
      } else {
        // Other non-picked options
        backgroundColor = isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.white.withValues(alpha: 0.45);
        borderColor = isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.black.withValues(alpha: 0.05);
        contentTextColor = textSecondary;
      }
    } else if (isSelected) {
      backgroundColor = AppTheme.electricViolet.withValues(
        alpha: isDark ? 0.20 : 0.12,
      );
      borderColor = AppTheme.electricViolet;
      labelBackgroundColor = AppTheme.electricViolet;
      labelTextColor = Colors.white;
      contentTextColor = textPrimary;
      boxShadow = [
        BoxShadow(
          color: AppTheme.electricViolet.withValues(alpha: isDark ? 0.3 : 0.2),
          blurRadius: 12,
        ),
      ];
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isAnswered ? null : onTap,
              borderRadius: BorderRadius.circular(18),
              splashColor: AppTheme.electricViolet.withValues(alpha: 0.15),
              highlightColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: borderColor,
                    width: isSelected || (isAnswered && isCorrect) ? 1.8 : 1.2,
                  ),
                  boxShadow: boxShadow,
                ),
                child: Row(
                  children: [
                    // Option badge A, B, C, D
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: labelBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        optionLabel,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: labelTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Option text
                    Expanded(
                      child: Text(
                        optionText,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isSelected || (isAnswered && isCorrect)
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: contentTextColor,
                        ),
                      ),
                    ),
                    if (trailingIcon != null) ...[
                      const SizedBox(width: 8),
                      trailingIcon,
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
