import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/parent/data/parent_repo.dart';
import 'package:lms/features/parent/model/my_children.dart';

class ParentController extends GetxController {
  ParentRepo parentRepo;
  ParentController(this.parentRepo);

  @override
  void onInit() {
    print("hello from on init");
    getMyChildren();
    super.onInit();
  }

  RxBool isLoadingGetChild = false.obs;

  MyChildren? myChildren;

  Future<void> getMyChildren() async {
    print("zzzzzzzzz");
    isLoadingGetChild.value = true;
    final result = await parentRepo.getMyChildren();
    print(" prrrrrrrrrrr:    ${result.data}");
    if (result is DataSuccess) {
      myChildren = result.data;
      isLoadingGetChild.value = false;
    } else if (result is DataFailed) {
      isLoadingGetChild.value = false;

      CustomToast.showToast(
        message: 'Failed to load data',
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColor.whiteColor,
        toastDuration: 1,
      );
    }
  }
}
