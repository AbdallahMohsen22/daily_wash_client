import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/image_net.dart';

import '../../../models/providers_model.dart';

// ignore: must_be_immutable
class StoreImage extends StatelessWidget {
  StoreImage({super.key, this.orderStatus,this.provider});
  String? orderStatus;
  ProviderData? provider;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.0.w),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ImageNet(
              image: provider?.personalPhoto??'',
              height: context.height * 0.25,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 8,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider?.name??'no_name'.tr(),
                  style: FontManager.getBoldStyle(
                    fontSize: AppSize.sp22,
                    color: ColorResources.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if(provider?.totalRate!=null)
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: provider?.totalRate?.toDouble()??0,
                      minRating: 1,
                      ignoreGestures: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 12,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    const Gap(5),
                    Text(
                      "${provider?.totalRate?.toDouble()??0}",
                      style: FontManager.getSemiBold(
                        fontSize: AppSize.sp16,
                        color: ColorResources.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          if (orderStatus != null) ...[
            Positioned(
                bottom: 20,
                right: 10,
                child: Text(
                  orderStatus!.tr(),
                  style: FontManager.getBoldStyle(
                    fontSize: AppSize.sp12,
                    color: ColorResources.primaryColor,
                  ),
                ))
          ]
        ],
      ),
    );
  }
}
