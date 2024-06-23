// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lms/core/utils/app_color.dart';

enum PickerType { date, time, dateTime }

void pickDate(BuildContext context, TextEditingController dateController, PickerType pickerType) async {
  if (pickerType == PickerType.date || pickerType == PickerType.dateTime) {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColor.primaryColor,
                  ),
                  dialogBackgroundColor: AppColor.whiteColor,
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: AppColor.primaryColor),
                    ),
                  )),
              child: child!);
        });

    if (pickedDate != null) {
      if (pickerType == PickerType.date) {
        dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        return;
      }

      TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
                data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColor.primaryColor,
                    ),
                    dialogBackgroundColor: AppColor.whiteColor,
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(color: AppColor.primaryColor)),
                    )),
                child: child!);
          });

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        dateController.text = DateFormat('yyyy-MM-dd HH:mm:ss').format(fullDateTime);
      }
    }
  } else if (pickerType == PickerType.time) {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColor.primaryColor,
                  ),
                  dialogBackgroundColor: AppColor.whiteColor,
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(color: AppColor.primaryColor)),
                  )),
              child: child!);
        });

    if (pickedTime != null) {
      final now = DateTime.now();
      final DateTime fullDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      dateController.text = DateFormat('HH:mm:ss').format(fullDateTime);
    }
  }
}
