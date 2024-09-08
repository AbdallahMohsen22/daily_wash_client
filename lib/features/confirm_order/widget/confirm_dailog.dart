import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/config/routes/app_route.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/custom_button.dart';

class ConfirmDailog extends StatelessWidget {
  const ConfirmDailog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: AppSize.h15, horizontal: AppSize.w20),
        margin: EdgeInsets.symmetric(horizontal: AppSize.w20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAssetImage(
                imageUrl: ImageResources.confirm,
                height: context.height * 0.2,
                width: context.width * 0.6),
            const Gap(10),
            Text(
              "request_submitted_Successfully".tr(),
              textAlign: TextAlign.center,
              style: FontManager.getBoldStyle(
                fontSize: AppSize.sp14,
                color: ColorResources.darkGrey6,
              ),
            ),
            const Gap(20),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                title: "go_To_Homepage".tr(),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.navigationPage,
                    (route) => false,
                  );
                },
                isSelected: true,
              ),
            ),
            const Gap(20),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                title: "track_order".tr(),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.trackOrderPage,
                    (route) => false,
                  );
                },
                isSelected: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
