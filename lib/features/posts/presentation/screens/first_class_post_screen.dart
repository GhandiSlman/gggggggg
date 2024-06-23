import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/features/posts/controller/post_controller.dart';
import 'package:lms/features/posts/presentation/widgets/post_card.dart';

class FirstClassPostScreen extends StatelessWidget {
  const FirstClassPostScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find();
    return Obx(() {
      // if (postController.posts.isEmpty) {
      //   return Center(child: Text('No posts available'));
      // }
      // if (postController.isLoading.value) {
      //   return Center(child: CircularProgressIndicator());
      // }
   
      //else{
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemCount: postController.posts.length,
          itemBuilder: (context, index) {
            final post = postController.posts[index];
            return PostCard(post: post);
          },
        ),
      );
      // }
    });
  }
}
