import 'package:flutter/material.dart';

class SlidebottomtoTop extends StatefulWidget {
  int duration;
  Widget child;
  SlidebottomtoTop({required this.duration, required this.child});

  @override
  State<SlidebottomtoTop> createState() => _SlidebottomtoTopState();
}

class _SlidebottomtoTopState extends State<SlidebottomtoTop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(
      milliseconds: widget.duration,
    ),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0, 0.3),
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
