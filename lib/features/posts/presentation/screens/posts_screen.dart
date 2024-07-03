import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_app_bar.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/core/widgets/loading_widget.dart';
import 'package:lms/core/widgets/shimmer.dart';
import 'package:lms/core/widgets/shimmer_post.dart';
import 'package:lms/features/posts/controller/post_controller.dart';
import 'package:lms/features/posts/presentation/widgets/post_card.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find();
    return Scaffold(
        floatingActionButton: box.read('userType') == 'teacher'
            ? FloatingActionButton(
                onPressed: () {
                  Get.toNamed(AppRouter.addPostScreen, arguments: {
                    'isUpdate': postController.isUpdatePost == true
                  });
                },
                backgroundColor: AppColor.primaryColor,
                child: Icon(
                  Icons.add,
                  color: AppColor.whiteColor,
                ),
              )
            : const SizedBox(),
        backgroundColor: AppColor.scaffoldColor,
        appBar: CustomAppBar(
          title: 'Posts'.tr,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: Obx(() {
              return postController.myTabs.isNotEmpty
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: postController.isLoadingGetClasses.value
                          ? ShimmerWidget(height: 50.h)
                          : TabBar(
                              isScrollable: true,
                              indicatorColor: AppColor.primaryColor,
                              labelColor: AppColor.primaryColor,
                              controller: postController.controller,
                              tabs: postController.myTabs,
                              tabAlignment: TabAlignment.start,
                            ),
                    )
                  : Container();
            }),
          ),
        ),
        body: Obx(() {
          return postController.isLoadingGetClasses.value
              ? const ShimmerPostCard()
              : postController.myTabs.isNotEmpty
                  ? TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: postController.controller,
                      children: postController.myTabs.map((Tab tab) {
                        return Obx(() {
                          return postController.isLoadingGetPost.value
                              ? ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(10.h),
                                      child: const ShimmerPostCard(),
                                    );
                                  },
                                )
                              : postController.posts.isEmpty
                                  ? Center(
                                      child: CustomText(
                                        text: 'No posts available',
                                        color: AppColor.primaryColor,
                                        fontSize: 20.sp,
                                      ),
                                    )
                                  : NotificationListener<ScrollNotification>(
                                      onNotification:
                                          (ScrollNotification scrollInfo) {
                                        if (!postController
                                                .isMoreLoading.value &&
                                            scrollInfo.metrics.pixels ==
                                                scrollInfo
                                                    .metrics.maxScrollExtent) {
                                          postController.loadNextPage();
                                        }
                                        return false;
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 10.h),
                                          itemCount: postController
                                                  .isMoreLoading.value
                                              ? postController.posts.length
                                              : postController.posts.length + 1,
                                          itemBuilder: (context, index) {
                                            if (index ==
                                                postController.posts.length) {
                                              return postController
                                                      .isMoreLoading.value
                                                  ? const LoadingWidget()
                                                  : const SizedBox();
                                            }
                                            final post =
                                                postController.posts[index];
                                            return PostCard(post: post);
                                          },
                                        ),
                                      ),
                                    );
                        });
                      }).toList(),
                    )
                  : const ShimmerPostCard();
        }));
  }
}
