import 'package:flutter/material.dart';

class SlidetoptoBottom extends StatefulWidget {
  int duration;
  Widget child;
  SlidetoptoBottom({required this.duration, required this.child});

  @override
  State<SlidetoptoBottom> createState() => _SlidetoptoBottomState();
}

class _SlidetoptoBottomState extends State<SlidetoptoBottom>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: Duration(
      milliseconds: widget.duration,
    ),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset(0, -1),
    end: Offset.zero,
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
