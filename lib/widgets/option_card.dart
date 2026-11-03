import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OptionCard extends StatelessWidget {
  final String optionText;
  final String optionLabel; // 'A', 'B', 'C', 'D'
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
    Color backgroundColor = AppTheme.surface;
    Color borderColor = AppTheme.border;
    Color labelBackground = AppTheme.surfaceElevated;
    Color labelTextColor = AppTheme.textSecondary;
    Color textColor = AppTheme.textPrimary;
    Widget? trailingIcon;

    if (isAnswered) {
      if (isCorrect) {
        // Highlight correct option in Emerald Green
        backgroundColor = AppTheme.successSurface;
        borderColor = AppTheme.success;
        labelBackground = AppTheme.success;
        labelTextColor = Colors.white;
        textColor = Colors.white;
        trailingIcon = const Icon(
          Icons.check_circle_rounded,
          color: AppTheme.success,
          size: 22,
        );
      } else if (isSelected && !isCorrect) {
        // Highlight chosen wrong option in Red
        backgroundColor = AppTheme.errorSurface;
        borderColor = AppTheme.error;
        labelBackground = AppTheme.error;
        labelTextColor = Colors.white;
        textColor = Colors.white;
        trailingIcon = const Icon(
          Icons.cancel_rounded,
          color: AppTheme.error,
          size: 22,
        );
      } else {
        // Unselected option after answer
        backgroundColor = AppTheme.surface.withValues(alpha: 0.5);
        borderColor = AppTheme.border.withValues(alpha: 0.4);
        textColor = AppTheme.textMuted;
        labelTextColor = AppTheme.textMuted;
      }
    } else if (isSelected) {
      backgroundColor = AppTheme.primary.withValues(alpha: 0.15);
      borderColor = AppTheme.primary;
      labelBackground = AppTheme.primary;
      labelTextColor = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: isAnswered ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: AppTheme.primary.withValues(alpha: 0.15),
          highlightColor: AppTheme.primary.withValues(alpha: 0.08),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor,
                width: isSelected || (isAnswered && isCorrect) ? 2.0 : 1.2,
              ),
            ),
            child: Row(
              children: [
                // Option indicator badge (A, B, C, D)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: labelBackground,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    optionLabel,
                    style: TextStyle(
                      fontSize: 14,
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
                      color: textColor,
                      height: 1.35,
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
    );
  }
}
