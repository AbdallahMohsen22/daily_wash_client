import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';

class SelectedSeriveType extends StatelessWidget {
  const SelectedSeriveType({
    super.key,
    required this.storeDetailsViewModel,
  });

  final StoreDetailsViewModel storeDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "service_type".tr(),
              style: FontManager.getSemiBold(
                fontSize: AppSize.sp16,
                color: ColorResources.black,
              ),
            ),
            Text(
              storeDetailsViewModel
                  .serviceTypes[storeDetailsViewModel.selectedServiceType]
                  .title,
              style: FontManager.getSemiBold(
                fontSize: AppSize.sp24,
                color: ColorResources.black,
              ),
            ),
          ],
        ),
        CustomAssetImage(
          imageUrl: storeDetailsViewModel
              .serviceTypes[storeDetailsViewModel.selectedServiceType].imageUrl,
          height: AppSize.h60,
          width: AppSize.w60,
        )
      ],
    );
  }
}
