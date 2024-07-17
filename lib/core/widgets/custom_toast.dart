import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lms/core/utils/app_color.dart';

class CustomToast {
  static void showToast({
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int toastDuration = 3,
    double fontSize = 16.0,
    bool isLongDuration = false,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: isLongDuration ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: toastDuration,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static void customErrorToast(String title) {
    CustomToast.showToast(
      message: title,
      backgroundColor: AppColor.redColor,
      fontSize: 15.sp,
      gravity: ToastGravity.BOTTOM,
      textColor: AppColor.whiteColor,
      toastDuration: 1,
    );
  }
}
