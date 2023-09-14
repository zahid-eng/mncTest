import 'package:flutter/material.dart';

class TextFieldVerticalAnimationDemo extends StatefulWidget {
  @override
  _TextFieldVerticalAnimationDemoState createState() =>
      _TextFieldVerticalAnimationDemoState();
}

class _TextFieldVerticalAnimationDemoState
    extends State<TextFieldVerticalAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: 50.0, end: 200.0).animate(controller);
    // Start the animation automatically when the widget is built
    controller.fling();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vertical TextField Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Container(
              height: animation.value,
              width: 250,
              child: Stack(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
