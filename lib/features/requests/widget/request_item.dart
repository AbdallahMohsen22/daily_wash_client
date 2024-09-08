import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/image_net.dart';
import 'package:on_express/features/requests/model/request_model.dart';
import 'package:on_express/features/requests/widget/delete_request_button.dart';
import 'package:on_express/features/requests/widget/track_delivery.dart';
import 'package:on_express/models/orders_model.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({
    super.key,
    required this.requestModel,
    required this.deleteRequest,
  });

  final OrderData requestModel;

  final VoidCallback deleteRequest;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * 0.15,
      margin: EdgeInsets.symmetric(vertical: AppSize.h15),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.w15,
        vertical: AppSize.h5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.h20),
        color: ColorResources.kfilledColor,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ImageNet(
              image: requestModel.providerPersonalPhoto??'',
              height: context.height * 0.11,
              width: AppSize.w110,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      requestModel.providerName??'no_name'.tr(),
                      style: FontManager.getMediumStyle(
                        fontSize: AppSize.sp18,
                        color: ColorResources.black,
                      ),
                    ),
                    if(requestModel.status == 1)
                    DeleteRequestButton(id: requestModel.id??'')
                  ],
                ),
                const Gap(5),
                if(requestModel.userAddress?[0].title?.isNotEmpty??false)
                LaundromateTtile(
                  imageUrl: ImageResources.location,
                  title: requestModel.userAddress?[0].title??'no_address'.tr(),
                  titleColor: ColorResources.black,
                ),
                Row(
                  children: [
                    // LaundromateTtile(
                    //   imageUrl: ImageResources.distance,
                    //   title: requestModel.distance,
                    //   titleColor: ColorResources.black,
                    // ),
                    // const Gap(15),

                  ],
                ),
                const Gap(5),
                TrackDelivery(requestModel: requestModel),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LaundromateTtile extends StatelessWidget {
  const LaundromateTtile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.titleColor,
  });

  final String imageUrl;
  final String title;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomAssetImage(
          imageUrl: imageUrl,
          height: AppSize.h12,
          width: AppSize.w12,
        ),
        const Gap(5),
        Expanded(
          child: Text(
            title,
            style: FontManager.getMediumStyle(
              fontSize: AppSize.sp14,
              color: titleColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
