import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<String>()
      ..add("opacity", 0.0.tweenTo(1.0), 500.milliseconds)
      ..add("translateY", (-30.0).tweenTo(0.0), 500.milliseconds, Curves.easeOut);

    return PlayAnimation<MultiTweenValues<String>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get<double>("opacity"),
        child: Transform.translate(
          offset: Offset(0, animation.get<double>("translateY")),
          child: child,
        ),
      ),
    );
  }
}
