import 'package:flutter/material.dart';
import 'package:lms/core/utils/app_color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(
      color: AppColor.primaryColor,
    ));
  }
}
