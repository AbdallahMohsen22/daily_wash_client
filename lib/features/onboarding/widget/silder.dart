import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:on_express/config/routes/app_route.dart';
import 'package:on_express/core/cache/init_screen_cahce.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({
    super.key,
    required this.image,
    required this.description,
    required this.title,
  });

  final String image;
  final String description;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(15),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.navigationPage,
                (route) => false,
              );
              InitScreenPrefs.once(2);
            },
            child: Text(
              "skip".tr(),
              style: FontManager.getSemiBold(
                fontSize: 18.sp,
                color: ColorResources.black20,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(20),
            CustomAssetImage(
              imageUrl: image,
              height: context.height * 0.4,
              width: context.width,
            ),
            const Gap(20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: FontManager.getBoldStyle(
                fontSize: AppSize.sp30,
                color: ColorResources.primaryColor,
              ),
            ),
            const Gap(10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: FontManager.getMediumStyle(
                fontSize: AppSize.sp14,
                color: ColorResources.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
