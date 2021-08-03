import 'package:flutter/material.dart';

class FadeTopDown extends StatelessWidget {
  final Widget child;

  const FadeTopDown({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(seconds: 1),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder:
          (BuildContext context, double value, Widget? tweenAnimationChild) {
        return Opacity(
          opacity: value,
          child: Padding(
              padding: EdgeInsets.only(top: value * 20),
              child: tweenAnimationChild),
        );
      },
      child: child,
    );
  }
}
