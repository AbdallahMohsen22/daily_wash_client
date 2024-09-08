import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/config/routes/app_route.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/chat/chat_page.dart';
import 'package:on_express/features/track_order/track_order_page.dart';

import '../../../models/orders_model.dart';

class TrackDelivery extends StatelessWidget {
  TrackDelivery({
    super.key,
    required this.requestModel
  });

  final OrderData requestModel;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => navigateTo(context, TrackOrderPage(requestModel: requestModel,)),
          child: Container(
            width: context.width * 0.25,
            height: AppSize.h24,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.primaryColor),
            child: Center(
              child: Text(
                "track_delivery".tr(),
                style: FontManager.getMediumStyle(
                  fontSize: AppSize.sp12,
                  color: ColorResources.white,
                ),
              ),
            ),
          ),
        ),
        const Gap(15),
        Text(
          '#${requestModel.itemNumber??'0'}'
        )
        // GestureDetector(
        //   onTap: () {
        //     UIAlert.showMaterialPage(context, child: const ChatPage());
        //   },
        //   child: Container(
        //     width: AppSize.w40,
        //     height: AppSize.h40,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: ColorResources.primaryColor.withOpacity(0.3),
        //     ),
        //     child: Center(
        //       child: CustomAssetImage(
        //         imageUrl: ImageResources.chat,
        //         height: AppSize.h25,
        //         width: AppSize.w25,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
