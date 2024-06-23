import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/posts/data/post_repo.dart';
import 'package:lms/features/posts/model/add_post_model.dart';
import 'package:lms/features/posts/model/like_model.dart';
import 'package:lms/features/posts/model/post_model.dart';
import 'package:lms/features/posts/model/update_post_model.dart';
import 'package:lms/features/students/data/student_repo.dart';
import 'package:lms/features/students/model/student_attendance.dart';

class PostController extends GetxController with GetTickerProviderStateMixin {
  final PostRepo postRepo;
  final StudentRepo studentRepo;
  PostController(this.postRepo, this.studentRepo);

  bool isCommentWeelPlane = false;
  bool isUpdatePost = false;
  RxBool isMoreLoading = false.obs;
  RxBool isLiked = false.obs;
  RxList<PostData> posts = <PostData>[].obs;
  RxString errorMessage = ''.obs;
  int currentPage = 1;
  bool hasMorePages = true;

  PostModel? postModel;
  RxBool isLoadingAddPost = false.obs;
  RxBool isLoadingGetPost = false.obs;
  RxBool isLoadingDeletePost = false.obs;

  var classList = <SelectedListItem>[].obs;
  Map<String, Map<String, List<Students>>> studentList =
      <String, Map<String, List<Students>>>{};

  RxList<String> selectedClass = <String>[].obs;
  var gradeToIdMap = <String, String>{}.obs;

  var intgradeToIdMap = <String, String>{}.obs;

  late TextEditingController descController;
  late TextEditingController classController;

  RxString selectedClassId = ''.obs;
  RxString selectedGradeId = ''.obs;
  var images = <String>[].obs;

  RxInt currentIndexCarousel = 0.obs;
  late TabController controller;
  RxList<Tab> myTabs = <Tab>[].obs;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 0);
    controller.addListener(_handleTabChange);
    descController = TextEditingController();
    classController = TextEditingController();
    getClasses();
  }

  void updateSelectedClass(String className) {
    selectedClass.value = [className];
    myTabs.clear();
    if (studentList.containsKey(className)) {
      studentList[className]!.forEach((subjectName, students) {
        myTabs.add(Tab(text: subjectName));
      });
    }
  }

  var selectedDropdownValue = RxnString();

  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];

  void selectValue(String value) {
    selectedDropdownValue.value = value;
  }

  var imagePath = <String>[].obs;
  var imageSize = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    try {
      if (pickedFile != null) {
        imagePath.add(pickedFile.path);
        images.add(pickedFile.path);
      } else {
 CustomToast.showToast(
        message:"You don't choose an image.".tr,
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

  Future<void> like(PostData post) async {
    posts.refresh();
    bool isCurrentlyLiked = post.isFavorite ?? false;
    post.isFavorite = !isCurrentlyLiked;
    post.likesCount = (post.likesCount ?? 0) + (isCurrentlyLiked ? -1 : 1);
    posts.refresh();
    final DataState result =
        await postRepo.like(addCommentModel: LikeModel(), postId: post.id!);

    if (result is! DataSuccess<LikeModel>) {
      post.isFavorite = isCurrentlyLiked;
      post.likesCount = (post.likesCount ?? 0) + (isCurrentlyLiked ? 1 : -1);
      posts.refresh();
      CustomToast.showToast(
        message: errorMessage.value,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  Future<void> updatePost(int postId) async {
    isLoadingAddPost.value = true;
    var addPostModel = UpdatePostData(
      description: descController.text,
      gradeId: selectedGradeId.value,
      id: postId,
    );
    final DataState result =
        await postRepo.updatePost(updatePostData: addPostModel, id: postId);

    if (result is DataSuccess<UpdatePostData>) {
      descController.clear();
      images.clear();
      isLoadingAddPost.value = false;
      CustomToast.showToast(
        message: 'Post updated successfully',
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else {
      isLoadingAddPost.value = false;
      CustomToast.showToast(
        message: 'Failed to update post',
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  Future<void> addPost() async {
    isLoadingAddPost.value = true;
    var addPostModel = Homework(
      description: descController.text,
      gradeId: selectedClassId.value,
      images: images.toList(),
    );
    final DataState result = await postRepo.addPost(
      addPostModel: addPostModel,
    );

    if (result is DataSuccess<Homework>) {
      descController.clear();
      images.clear();
      isLoadingAddPost.value = false;
      CustomToast.showToast(
        message: 'Post added successfully',
        backgroundColor: AppColor.greenColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else {
      isLoadingAddPost.value = false;
      CustomToast.showToast(
        message: 'Failed to add post',
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  Future<void> getClasses() async {
    final DataState result = await studentRepo.getClasses(StudentAttendance());
    if (result is DataSuccess<StudentAttendance>) {
      var attendance = result.data!;
      classList.clear();
      studentList.clear();
      myTabs.clear();
      gradeToIdMap.clear();
      intgradeToIdMap.clear();

      for (var res in attendance.result!) {
        for (var grade in res.grades!) {
          classList.add(SelectedListItem(
              name: box.read('langCode') == 'ar'
                  ? grade.name!.ar!
                  : grade.name!.en!));
          gradeToIdMap[box.read('langCode') == 'ar'
              ? grade.name!.ar!
              : grade.name!.en!] = grade.id.toString();
          intgradeToIdMap[box.read('langCode') == 'ar'
              ? grade.name!.ar!
              : grade.name!.en!] = grade.id.toString();
          studentList[box.read('langCode') == 'ar'
              ? grade.name!.ar!
              : grade.name!.en!] = {};
          myTabs.add(Tab(
              text: box.read('langCode') == 'ar'
                  ? grade.name!.ar!
                  : grade.name!.en!));
        }
      }
      controller = TabController(vsync: this, length: myTabs.length);
      controller.addListener(_handleTabChange);
      if (myTabs.isNotEmpty) {
        int initialGradeId = int.parse(gradeToIdMap[myTabs[0].text]!);
        getPostsByGradeId(initialGradeId);
      }
      // update();
    } else {
      CustomToast.showToast(
        message: errorMessage.value,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  void updateSelectedSectionId(String classId) {
    selectedClassId.value = classId;
  }

  void updateSelectedGradeId(String gradeId) {
    selectedGradeId.value = gradeId;
  }

  void _handleTabChange() {
    if (!controller.indexIsChanging) {
      int selectedGradeId =
          int.parse(gradeToIdMap[myTabs[controller.index].text]!);
      getPostsByGradeId(selectedGradeId);
    }
  }

  Future<void> deletePost(int postId) async {
    isLoadingDeletePost.value = true;
    final result = await postRepo.deletePost(postId: postId);
    if (result is DataSuccess<PostModel>) {
      isLoadingDeletePost.value = false;
      posts.removeWhere((post) => post.id == postId);
      CustomToast.showToast(
        message: 'Post deleted successfully'.tr,
        backgroundColor: AppColor.green2Color,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    } else if (result is DataFailed<PostModel>) {
      isLoadingDeletePost.value = false;
      CustomToast.showToast(
        message: 'Failed to delete post'.tr,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  Future<void> getPostsByGradeId(int gradeId) async {
    currentPage = 1;
    hasMorePages = true;
    posts.clear();
    // isLoadingGetPost.value = true;

    final response = await postRepo.getPosts(
        page: currentPage, postModel: PostModel(), gradeId: gradeId);
    isLoadingGetPost.value = false;
    if (response is DataSuccess<PostModel>) {
      if (response.data!.data!.data!.isEmpty) {
        hasMorePages = false;
      } else {
        posts.addAll(response.data!.data!.data!);
      }
      // isLoadingGetPost.value = false;
      isMoreLoading.value = false;
    } else if (response is DataFailed) {
      errorMessage.value = response.errorMessage!;
      //  isLoadingGetPost.value = false;
      isMoreLoading.value = false;
      CustomToast.showToast(
        message: errorMessage.value,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }

  void loadNextPage() {
    if (hasMorePages && !isMoreLoading.value) {
      isMoreLoading.value = true;
      currentPage++;
      int initialGradeId = int.parse(gradeToIdMap[myTabs[0].text]!);
      fetchMorePosts(initialGradeId);
    }
  }

  Future<void> fetchMorePosts(int gradeId) async {
    final response = await postRepo.getPosts(
        page: currentPage, postModel: PostModel(), gradeId: gradeId);

    if (response is DataSuccess<PostModel>) {
      if (response.data!.data!.data!.isEmpty) {
        hasMorePages = false;
      } else {
        posts.addAll(response.data!.data!.data!);
      }
      isMoreLoading.value = false;
    } else if (response is DataFailed) {
      errorMessage.value = response.errorMessage!;
      isMoreLoading.value = false;
      CustomToast.showToast(
        message: errorMessage.value,
        backgroundColor: AppColor.redColor,
        fontSize: 15.sp,
        gravity: ToastGravity.BOTTOM,
        isLongDuration: false,
        textColor: AppColor.whiteColor,
      );
    }
  }
}
