import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final double? height;
  final double? width;
  final String? Function(String?)? validator;
  final Icon? icon;
  bool? secureTextentry = false;

  TextInput(
      {this.height,
      this.width,
      this.controller,
      this.hintText,
      this.icon,
      this.secureTextentry,
      this.validator});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.teal)),
        child: TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.secureTextentry ?? false,
          decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: widget.icon,
              border: InputBorder.none),
        ));
  }
}
