import 'package:flutter/material.dart';

/// Smooth iOS-style slide and gentle fade transition
class IosPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  IosPageRoute({
    required this.page,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutQuart,
              reverseCurve: Curves.easeInQuart,
            );

            // Subtle slide from right (offset: 0.25 to 0.0)
            final slideAnimation = Tween<Offset>(
              begin: const Offset(0.3, 0.0),
              end: Offset.zero,
            ).animate(curvedAnimation);

            // Gentle fade in
            final fadeAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(0.0, 0.85, curve: Curves.easeOut),
              ),
            );

            return SlideTransition(
              position: slideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        );
}
