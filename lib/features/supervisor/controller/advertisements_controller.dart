import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/supervisor/data/advertisements_repo.dart';
import 'package:lms/features/supervisor/model/add_advertisements_model.dart';
import 'package:lms/features/supervisor/model/advertisements_model.dart';
import 'package:lms/features/supervisor/model/update_ad_model.dart';

class AdvertisementsController extends GetxController
    with GetTickerProviderStateMixin {
  final AdvertisementsRepo _advertisementsRepo;
  AdvertisementsController(this._advertisementsRepo);

  RxList<AdvertisementsData> advertisementsList = <AdvertisementsData>[].obs;
  RxList<AdvertisementsData> myAdvertisementsList = <AdvertisementsData>[].obs;
  
  late final TextEditingController descControllerAr;
  late final TextEditingController descControllerEn;
  RxBool isLoadingAddUpdateAd = false.obs;
  RxBool isLoadingGetAd = false.obs;
  RxBool isLoadingGetMyAd = false.obs;
  RxBool isLoadingDelete = false.obs;
  
  RxInt currentIndexCarousel = 0.obs;

  bool isUpdate = false;

  RxBool isAdvertisement = true.obs;

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

  @override
  void onInit() {
    descControllerAr = TextEditingController();
    descControllerEn = TextEditingController();
    controller = TabController(vsync: this, length: 2);
    controller.addListener(() {
      if (controller.index == 1) {
        getMyAdvertisements();
      } else if (controller.index == 0) {
        getAdvertisements();
      }
    });
    getAdvertisements();
    super.onInit();
  }

  Future<void> getAdvertisements() async {
    isLoadingGetAd.value = true;
    final DataState result = await _advertisementsRepo.getAdvertisements(
        advertisements: Advertisements());
    isLoadingGetAd.value = false;
    advertisementsList.clear();
    if (result is DataSuccess) {
      for (var ad in result.data!.advertisements!) {
        if (ad.createdAt != null) {
          final DateTime dateTime = DateTime.parse(ad.createdAt!);
          ad.createdAt = DateFormat('yyyy-MM-dd').format(dateTime);
        }
        advertisementsList.add(ad);
      }
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

  

  Future<void> getMyAdvertisements() async {
    isLoadingGetMyAd.value = true;
    final DataState result = await _advertisementsRepo.getMyAdvertisements(
        advertisements: Advertisements());
    isLoadingGetMyAd.value = false;
    myAdvertisementsList.clear();
    if (result is DataSuccess) {
      for (var ad in result.data!.advertisements!) {
        if (ad.createdAt != null) {
          final DateTime dateTime = DateTime.parse(ad.createdAt!);
          ad.createdAt = DateFormat('yyyy-MM-dd').format(dateTime);
        }
        myAdvertisementsList.add(ad);
      }
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

  Future<void> addAd() async {
    isLoadingAddUpdateAd.value = true;
    var addAdModel = AddAdvertisementModel(
      descriptionAr: descControllerAr.text,
      descriptionEn: descControllerEn.text,
      images: images.toList(),
      type: isAdvertisement.value ? 'advertisement' : 'news',
    );
    final DataState result = await _advertisementsRepo.addAdvertisement(
        addAdvertisementModel: addAdModel);
    isLoadingAddUpdateAd.value = false;
    if (result is DataSuccess) {
      CustomToast.showToast(
        message: 'Ad added successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
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

  Future<void> updateAd(String id) async {
    isLoadingAddUpdateAd.value = true;
    var updateAdModel = UpdateAdvertisementModel(
      descriptionAr: descControllerAr.text,
      descriptionEn: descControllerEn.text,
      id: id,
    );
    final DataState result = await _advertisementsRepo.updateAdvertisement(
        updateAdvertisementModel: updateAdModel);
    isLoadingAddUpdateAd.value = false;
    if (result is DataSuccess) {
      CustomToast.showToast(
        message: 'Ad updated successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
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

  Future<void> deleteAd(int id) async {
    isLoadingDelete.value = true;
    final DataState result =
        await _advertisementsRepo.deleteAdvertisement(id: id);
    isLoadingDelete.value = false;

    if (result is DataSuccess) {
      myAdvertisementsList.removeWhere((ad) => ad.id == id);
      CustomToast.showToast(
        message: 'Ad deleted successfully'.tr,
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
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
}
