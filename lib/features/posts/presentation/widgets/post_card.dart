import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/utils/app_images.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/features/posts/controller/post_controller.dart';
import 'package:lms/features/posts/model/post_model.dart';
import 'package:lms/features/posts/presentation/widgets/carousel_slider_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostCard extends StatelessWidget {
  final PostData post;

  const PostCard({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    return Container(
      height: 380.h,
      width: double.infinity,
      color: AppColor.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(AppImages.teacherImage),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 200.w,
                        child: FittedBox(
                          child: CustomText(
                            text: '${'Teacher'.tr} ${post.teacher?.name ?? ''}',
                            color: AppColor.primaryColor,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      50.horizontalSpace,
                      box.read('userType') == 'teacher'
                          ? IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Obx(() => postController
                                            .isLoadingDeletePost.value
                                        ? const LoadingWidget()
                                        : SimpleDialog(
                                            children: [
                                              ListTile(
                                                title: CustomText(
                                                    text: 'Update'.tr),
                                                leading: SvgPicture.asset(
                                                    AppImages.updateImage),
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppRouter.addPostScreen,
                                                      arguments: {
                                                        'postId': post.id,
                                                        'isUpdate': postController
                                                                .isUpdatePost ==
                                                            false,
                                                        'desCon': postController
                                                                .descController
                                                                .text =
                                                            post.description!,
                                                      });
                                                },
                                              ),
                                              ListTile(
                                                title: CustomText(
                                                    text: 'Delete'.tr),
                                                leading: SvgPicture.asset(
                                                    AppImages.delete2Image),
                                                onTap: () {
                                                  print(post.id!);
                                                  postController
                                                      .deletePost(post.id!)
                                                      .then((value) =>
                                                          Get.back());
                                                },
                                              ),
                                            ],
                                          ));
                                  },
                                );
                              },
                              icon: const Icon(Icons.more_horiz))
                          : const SizedBox()
                    ],
                  ),
                  SizedBox(
                    width: 70.w,
                    child: FittedBox(
                      child: CustomText(
                        text:
                            '${'before'.tr} ${postController.formatDate(post.createdAt!)}',
                        color: AppColor.greyColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          10.verticalSpace,
          CustomText(
            text: post.description ?? '',
            color: AppColor.greyColor,
            fontSize: 15.sp,
          ),
          10.verticalSpace,
          SizedBox(
            width: double.infinity,
            height: 230.h,
            child: CarouselSliderItems(
              concatenatedImages: post.images ?? '',
            ),
          ),
          //.verticalSpace,
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          postController.like(post);
                        },
                        icon: post.isFavorite!
                            ? Icon(Icons.favorite, color: AppColor.redColor)
                            : Icon(Icons.favorite_border,
                                color: AppColor.redColor)),
                    FittedBox(
                      child: CustomText(
                        text: '${post.likesCount} ${'Likes'.tr}',
                      ),
                    )
                  ],
                ),
              ),
              post.images!.split(',').length > 1
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 35.w),
                        child: Obx(
                          () {
                            final controller = Get.find<PostController>();
                            final count = post.images!.split(',').length;
                            return AnimatedSmoothIndicator(
                              activeIndex:
                                  controller.currentIndexCarousel.value,
                              count: count > 1 ? count : 1,
                              effect: ExpandingDotsEffect(
                                dotColor: AppColor.blackColor,
                                dotHeight: 5.h,
                                dotWidth: 5.w,
                                activeDotColor: AppColor.primaryColor,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : 120.horizontalSpace,
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRouter.commentScreen, arguments: {
                      'postId': post.id,
                      'isCommentWeekPlane':
                          postController.isCommentWeelPlane == false
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: FittedBox(
                          child: CustomText(
                            text: '${post.commentsCount} ${'comments'.tr}',
                          ),
                        ),
                      ),
                      SvgPicture.asset(AppImages.commentImage),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
