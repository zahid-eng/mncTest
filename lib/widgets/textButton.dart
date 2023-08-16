import 'package:flutter/material.dart';
import 'package:mnctest/constant/constant.dart';

class CustomTextButton extends StatefulWidget {
  final String? title;
  Color? color;

  final void Function()? ontap;

  CustomTextButton({this.color, this.title, this.ontap});

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.ontap,
      child: Text(
        widget.title ?? "",
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: teal,
            decoration: TextDecoration.underline,
            decorationColor: teal),
      ),
    );
  }
}
