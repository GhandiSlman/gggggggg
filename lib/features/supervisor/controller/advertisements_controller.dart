import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/supervisor/data/advertisements_repo.dart';
import 'package:lms/features/supervisor/model/advertisements_model.dart';

class AdvertisementsController extends GetxController
    with GetTickerProviderStateMixin {
  final AdvertisementsRepo _advertisementsRepo;
  AdvertisementsController(this._advertisementsRepo);

  RxList<AdvertisementsData> advertisementsList = <AdvertisementsData>[].obs;
  late final TextEditingController descController;
  late final TextEditingController titleController;
  RxBool isLoadingAddUpdateAd = false.obs;

  RxInt currentIndexCarousel = 0.obs;

  var images = <String>[].obs;
  var imagePath = <String>[].obs;

  RxList<Tab> myTabs = <Tab>[
    Tab(
      text: 'Advertisements'.tr,
    ),
    Tab(
      text: 'My advertisements'.tr,
    ),
  ].obs;

  late TabController controller;

  Future<void> getAdvertisements() async {
    print(box.read('token'));
    final DataState result = await _advertisementsRepo.getAdvertisements(
        advertisements: Advertisements());
    if (result is DataSuccess<Advertisements>) {
      advertisementsList.addAll(result.data!.advertisements!);
      print('Advertisements List: $advertisementsList');
    } else if (result is DataFailed) {
      CustomToast.showToast(
        message: result.errorMessage!,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    try {
      if (pickedFile != null) {
        imagePath.add(pickedFile.path);
        images.add(pickedFile.path);
      } else {
        CustomToast.showToast(
          message: "You didn't choose an image.".tr,
          backgroundColor: AppColor.redColor,
          fontSize: 15.sp,
          gravity: ToastGravity.BOTTOM,
          isLongDuration: false,
          textColor: AppColor.whiteColor,
        );
      }
    } catch (e) {
      CustomToast.showToast(
        message: 'Error $e'.tr,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  @override
  void onInit() {
    descController = TextEditingController();
    titleController = TextEditingController();
    controller = TabController(vsync: this, length: 2);
    getAdvertisements();
    super.onInit();
  }
}
