import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';

class SelectedDateAndTime extends StatelessWidget {
  const SelectedDateAndTime({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "date_and_time".tr(),
              style: FontManager.getSemiBold(
                fontSize: AppSize.sp16,
                color: ColorResources.black,
              ),
            ),
            Text(
              "Sun 17 Mar ",
              style: FontManager.getSemiBold(
                fontSize: AppSize.sp24,
                color: ColorResources.black,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: AppSize.h10,
          ),
          width: context.width * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.primaryColor),
          child: Center(
            child: Text(
              "09:00 AM",
              softWrap: true,
              style: FontManager.getMediumStyle(
                  fontSize: AppSize.sp14, color: ColorResources.white),
            ),
          ),
        ),
      ],
    );
  }
}
