import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lms/core/data/data_state.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_toast.dart';
import 'package:lms/features/comments/data/comment_repo.dart';
import 'package:lms/features/comments/model/add_comment_model.dart';
import 'package:lms/features/comments/model/get_comment_model.dart';

class CommentController extends GetxController {
  final CommentRepo commentRepo;
  CommentController(this.commentRepo);
  
  final formKey = GlobalKey<FormState>();
  RxList<Comments> commentsList = <Comments>[].obs;
  RxList<Comments> commentWeekPlaneList = <Comments>[].obs;

  RxBool isTyping = false.obs;
  RxBool isLoadingComment = false.obs;
  RxBool isAddingComment = false.obs;
  late TextEditingController comment;
  late TextEditingController commentWeekPlane;
  ScrollController scrollController = ScrollController();

  Future<void> addComment(int postId) async {
    var newComment = Comments(
      comment: comment.text,
    );
    commentsList.add(newComment);
    comment.clear();
     scrollToBottom(); 

    var addCommentModel = AddCommentData(
      comment: newComment.comment,
      dailyUpdatePostId: postId,
    );

    isAddingComment.value = true;

    final DataState result = await commentRepo.addComment(
      addCommentModel: addCommentModel,
      postId: postId,
    );

    isAddingComment.value = false;

    if (result is DataSuccess) {
    } else {
      commentsList.remove(newComment);
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

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> addCommentWeekPlane(int weekPlaneId) async {
    var newComment = Comments(
      comment: commentWeekPlane.text,
    );
    commentWeekPlaneList.add(newComment);
    commentWeekPlane.clear();
     scrollToBottom(); 

    var addCommentWeelPlaneModel = AddCommentWeekPlane(
      comment: newComment.comment,
      weekPlanId: weekPlaneId,
    );

    isAddingComment.value = true;

    final DataState result = await commentRepo.addCommentWeekPlane(
      addCommentWeekPlane: addCommentWeelPlaneModel,
      weekPlaneId: weekPlaneId,
    );

    isAddingComment.value = false;

    if (result is DataSuccess) {
    } else if (result is DataFailed) {
      commentWeekPlaneList.remove(newComment);
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

  Future<void> getComment(int postId) async {
    isLoadingComment.value = true;
    commentsList.clear();
    final DataState result = await commentRepo.getComment(
        comments: GetCommentModel(), postId: postId);
    isLoadingComment.value = false;
    if (result is DataSuccess<GetCommentModel>) {
      commentsList.addAll(result.data!.result!.comments!);
    } else if (result is DataFailed<GetCommentModel>) {
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

  Future<void> getCommentsForWeekPlan(int weekPlanId) async {
    isLoadingComment.value = true;
    commentWeekPlaneList.clear();
    final DataState result = await commentRepo.getCommentWeekPlane(
        weekPlaneId: weekPlanId, getCommentWeekPlane: GetCommentWeekPlane());
    isLoadingComment.value = false;
    if (result is DataSuccess) {
      commentWeekPlaneList.addAll(result.data!.result!.comments!);
    } else if (result is DataFailed<GetCommentWeekPlane>) {
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

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null) {
      if (arguments['postId'] != null) {
        int postId = arguments['postId'];
        getComment(postId);
      } else if (arguments['weekPlaneId'] != null) {
        int weekPlaneId = arguments['weekPlaneId'];
        getCommentsForWeekPlan(weekPlaneId);
      }
    }
    comment = TextEditingController();
    commentWeekPlane = TextEditingController();
  }
}
