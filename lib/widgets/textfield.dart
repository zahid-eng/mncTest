import 'package:flutter/material.dart';
import 'package:mnctest/constant/constant.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: teal)),
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.secureTextentry ?? false,
            decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: widget.icon,
                border: InputBorder.none),
          )),
    );
  }
}
