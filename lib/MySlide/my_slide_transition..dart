import 'package:flutter/material.dart';

class MySlideTransition extends StatefulWidget {
  int duration;
  Widget child;
  MySlideTransition({required this.duration, required this.child});

  @override
  State<MySlideTransition> createState() => _MySlideTransitionState();
}

class _MySlideTransitionState extends State<MySlideTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(
      milliseconds: widget.duration,
    ),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(-0.5, 0.0),
    end: Offset(0.01, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCubic,
  ));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.duration)).then((value) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      transformHitTests: true,
      child: widget.child,
    );
  }
}
