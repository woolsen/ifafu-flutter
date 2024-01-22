import 'package:flutter/material.dart';

class SlidePageRoute<T> extends PageRoute<T> {
  final Widget child;
  final Direction direction;

  @override
  final bool opaque;

  @override
  final String? barrierLabel;

  @override
  final Color? barrierColor;

  @override
  final bool maintainState;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  SlidePageRoute({
    required this.child,
    this.opaque = true,
    this.barrierLabel,
    this.barrierColor,
    this.direction = Direction.rightToLeft,
    this.maintainState = true,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return child;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final Animation<Offset> tween;
    switch (direction) {
      case Direction.leftToRight:
        tween = Tween(
          begin: const Offset(-1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation);
        break;
      case Direction.rightToLeft:
        tween = Tween(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation);
        break;
      case Direction.topToBottom:
        tween = Tween(
          begin: const Offset(0.0, -1.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation);
        break;
      case Direction.bottomToTop:
        tween = Tween(
          begin: const Offset(0.0, 1.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation);
        break;
    }
    return SlideTransition(position: tween, child: child);
  }
}

enum Direction { leftToRight, rightToLeft, topToBottom, bottomToTop }
