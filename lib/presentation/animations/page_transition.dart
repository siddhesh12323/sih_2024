import 'package:flutter/material.dart';

class CustomPageTransitionsBuilder<T> extends PageTransitionsBuilder {
  @override
  // ignore: avoid_shadowing_type_parameters
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == '/') {
      // No animation for the initial route
      return child;
    }

    // Slide from right to left transition
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
