import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';

import '../../config/routes/app_route.dart';
import '../cache/init_screen_cahce.dart';
import '../utils/color_resources.dart';
import '../utils/font_manager.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.h40),
            child: CustomAssetImage(
              imageUrl: ImageResources.logo,
              height: AppSize.h80,
              width: AppSize.w80,
            ),
          ),
        ),
        Spacer(),
        GestureDetector(
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
        )
      ],
    );
  }
}
