import 'package:flutter/material.dart';

class MyFadeAnimation extends StatefulWidget {
  int duration;
  Widget child;
  MyFadeAnimation({required this.duration, required this.child});

  @override
  State<MyFadeAnimation> createState() => _MyFadeAnimationState();
}

class _MyFadeAnimationState extends State<MyFadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));
  // ..repeat(reverse: true);
  late Animation<double> animation =
      CurvedAnimation(parent: animationController, curve: Curves.easeIn);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.duration)).then((value) {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animation, alwaysIncludeSemantics: false, child: widget.child);
  }
}
