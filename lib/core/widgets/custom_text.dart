import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLine;
  final TextOverflow? overflow;
  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.maxLine,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      maxLines: maxLine ?? 1,
      text,
      minFontSize: 0,
      style: TextStyle(
        overflow: overflow,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
