import 'package:flutter/material.dart';
import 'package:mnctest/constant/constant.dart';

class CustomButton extends StatefulWidget {
  final String? title;
  Color? color;

  final void Function()? ontap;

  CustomButton({this.color, this.title, this.ontap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: widget.ontap,
        child: Text(
          widget.title ?? "",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50), backgroundColor: widget.color),
      ),
    );
  }
}
