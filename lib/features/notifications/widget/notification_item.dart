import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem({required this.notificationModel});

  NotificationData notificationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: context.height * 0.15,
      margin: EdgeInsets.symmetric(vertical: AppSize.h12),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.w15,
        vertical: AppSize.h20,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.h15),
          color: ColorResources.lightGrey5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            notificationModel.title??'Notification Title',
            style: FontManager.getMediumStyle(
              fontSize: AppSize.sp16,
              color: ColorResources.black,
            ),
          ),
          Text(
            notificationModel.body??"Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing",
            style: FontManager.getMediumStyle(
              fontSize: AppSize.sp12,
              color: ColorResources.black75,
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     // ClipRRect(
          //     //   borderRadius: BorderRadius.circular(AppSize.h30),
          //     //   child: CustomAssetImage(
          //     //     imageUrl: ImageResources.laundromat,
          //     //     fit: BoxFit.cover,
          //     //     height: AppSize.h60,
          //     //     width: AppSize.w60,
          //     //   ),
          //     // ),
          //     const Gap(15),
          //   ],
          // )
        ],
      ),
    );
  }
}
