import 'package:get/get.dart';
import 'package:lms/features/parent/model/my_children.dart';
import 'package:lms/features/parent/presentation/screens/sons_screen.dart.dart';

class SonArcheivementController extends GetxController {
  SonModel? son;
  @override
  void onInit() {
    son = Get.arguments;
    super.onInit();
  }
}
