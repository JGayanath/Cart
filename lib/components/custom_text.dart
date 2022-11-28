
import 'package:flutter/material.dart';

class Custom_Text extends StatelessWidget {
  Custom_Text({
    required this.text,
    this.color=Colors.black,
    required this.fontSize,
    this.fontWeight=FontWeight.normal,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${text}",
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}