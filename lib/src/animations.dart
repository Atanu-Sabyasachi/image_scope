import 'package:flutter/material.dart';

class ImageScopeAnimations {
  static Widget fadeTransition(
      {required Widget child, required Animation<double> animation}) {
    return FadeTransition(opacity: animation, child: child);
  }

  static Widget slideTransition({
    required Widget child,
    required Animation<double> animation,
    Offset begin = const Offset(0.0, 1.0),
    Offset end = Offset.zero,
  }) {
    return SlideTransition(
      position: Tween<Offset>(begin: begin, end: end).animate(animation),
      child: child,
    );
  }
}
