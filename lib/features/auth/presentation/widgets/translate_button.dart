import 'package:flutter/material.dart';
import 'package:lms/core/utils/app_color.dart';

class TranslateButton extends StatefulWidget {
  const TranslateButton({super.key});

  @override
  State<TranslateButton> createState() => _TranslateButtonState();
}

class _TranslateButtonState extends State<TranslateButton> {
  @override
  Widget build(BuildContext context) {
    bool val = false;
    return Switch(
        activeColor: AppColor.primaryColor,
        hoverColor: AppColor.primaryColor,
        value: val,
        onChanged: (bool value) {
          setState(() {
            val = value;
          });
        });
  }
}
