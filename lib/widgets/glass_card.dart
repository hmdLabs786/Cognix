import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;
  final double blur;
  final List<BoxShadow>? boxShadow;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 22.0,
    this.backgroundColor,
    this.backgroundGradient,
    this.borderColor,
    this.borderWidth = 1.0,
    this.onTap,
    this.blur = 14.0,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = BorderRadius.circular(borderRadius);
    final isDark = AppTheme.isDark(context);

    final effectiveBackground = backgroundColor ??
        (backgroundGradient == null ? AppTheme.getGlassSurface(context) : null);
    final effectiveBorderColor =
        borderColor ?? AppTheme.getGlassBorder(context);

    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: backgroundGradient == null ? effectiveBackground : null,
        gradient: backgroundGradient,
        borderRadius: effectiveBorderRadius,
        border: Border.all(
          color: effectiveBorderColor,
          width: borderWidth,
        ),
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: effectiveBorderRadius,
          onTap: onTap,
          splashColor: AppTheme.electricViolet.withValues(alpha: 0.15),
          highlightColor: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
          child: content,
        ),
      );
    }

    final defaultShadow = isDark
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ]
        : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: effectiveBorderRadius,
        boxShadow: boxShadow ?? defaultShadow,
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: content,
        ),
      ),
    );
  }
}
