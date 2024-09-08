import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/default_scaffold.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({
    super.key,
    required this.imageUrl,
    required this.button,
  });

  final String imageUrl;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      child: Padding(
        padding: EdgeInsets.only(left: AppSize.w20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAssetImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              height: context.height * 0.15,
              width: context.width * 0.5,
            ),
            const Gap(15),
            button,
            const Gap(10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "cancel".tr(),
                style: FontManager.getMediumStyle(
                  fontSize: AppSize.sp18,
                  color: ColorResources.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
