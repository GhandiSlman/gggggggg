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

  RxBool isLoadingGetChild = false.obs;
  RxList<Children> myChildrenList = <Children>[].obs;

  Future<void> getMyChildren() async {
    isLoadingGetChild.value = true;
    final result = await parentRepo.getMyChildren(myChildren: MyChildren());
    isLoadingGetChild.value = false;
    if (result is DataSuccess) {
      myChildrenList.addAll(result.data!.data!.children!);
    } else if (result is DataFailed) {
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

  @override
  void onInit() {
    getMyChildren();
    super.onInit();
  }
}
