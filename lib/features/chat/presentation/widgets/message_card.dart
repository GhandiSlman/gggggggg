import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/utils/app_consts.dart';
import 'package:lms/core/widgets/custom_text.dart';
import 'package:lms/features/chat/models/conversation_model.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: (message.isSender
                      ? message.isSending
                          ? Color.alphaBlend(
                              Colors.grey.withOpacity(0.8),
                              AppColor.primaryColor,
                            )
                          : AppColor.primaryColor
                      : AppColor.whiteColor),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(10.r),
                    topEnd: Radius.circular(10.r),
                    bottomEnd:
                        message.isSender ? Radius.zero : Radius.circular(10.r),
                    bottomStart:
                        !message.isSender ? Radius.zero : Radius.circular(10.r),
                  )),
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: message.message == null
                    ? CachedNetworkImage(
                        height: 200,
                        width: 200,
                        imageUrl: imageBaseUrl + message.image.toString(),
                        placeholder: (context, url) => const Padding(
                          padding: EdgeInsets.all(70),
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, s) => const Padding(
                            padding: EdgeInsets.all(70),
                            child: CircularProgressIndicator()),
                      )
                    : CustomText(
                        text: message.message!,
                        color: message.isSender ? Colors.white : Colors.black87,
                        //  size: 15,
                      ),
              )),
        ),
      ],
    );
  }
}
