import 'package:get/get.dart';

class CalendarController extends GetxController {
  DateTime selectedDate = DateTime.now();
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDate = selectedDay;
    update();  
  }
}
