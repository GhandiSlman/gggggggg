import 'package:flutter/material.dart';
import 'package:lms/core/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Border? border;
  final Function() onTap;
  final Color? textColor;
  final double? width;

  const CustomButton(
      {super.key,
      required this.text,
      this.width,
      this.color,
      this.border,
      required this.onTap,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: mq.height * .06,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: CustomText(
          text: text,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor,
        )),
      ),
    );
  }
}
