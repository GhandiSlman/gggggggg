import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/core/router/app_router.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_text.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(AppRouter.chatDetails);
      },
      child: ListTile(
        tileColor: AppColor.whiteColor,
        leading: ClipRRect(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.whiteColor,
              ),
              child: Image.asset('assets/person.png',fit: BoxFit.fill,)),
        ),
        title: CustomText(
          text: 'Ghandi Alslman',
          color: AppColor.primaryColor,
        ),
        subtitle: CustomText(
          text: 'before 5 min',
          color: AppColor.greyColor2,
        ),
        trailing:  CircleAvatar(
          backgroundColor: AppColor.primaryColor,
          child: Center(child: CustomText(text: '10',color: AppColor.whiteColor,),),
        ),
      ),
    );
  }
}
