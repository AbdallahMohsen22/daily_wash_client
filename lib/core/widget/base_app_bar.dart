import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:on_express/config/routes/app_route.dart';
import 'package:on_express/core/constants/app_constants.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:provider/provider.dart';

import '../../features/store_details/store_details_page.dart';

// ignore: must_be_immutable
class BaseAppBar extends StatelessWidget {
  BaseAppBar(
      {super.key,
      required this.isBackExist ,
      this.title,
      this.notification,
      this.backPressed,
      this.haveLogo = true,
      this.havePadding=false
      });

  final bool isBackExist;
  bool haveLogo;
  Widget? title;
  Widget? notification;
  VoidCallback? backPressed;
  bool? havePadding;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      primary: true,
      expandedHeight: AppSize.h100,
      pinned: true,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      backgroundColor: ColorResources.white,
      title: title,
      elevation: 0,
      actions: [
        notification == null
            ? token != null
                ? GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.notificationPage,
                    ),
                    child: Padding(
                      padding:havePadding! ?EdgeInsets.symmetric(horizontal: 16.w): const EdgeInsets.only(bottom: 10.0),
                      child: CustomAssetImage(
                        imageUrl: ImageResources.notification,
                        height: AppSize.h22,
                        width: AppSize.w22,
                      ),
                    ),
                  )
                : SizedBox()
            : notification!
      ],
      leadingWidth: isBackExist ? AppSize.w100 : context.width * 0.4,

      leading: isBackExist
          ? Consumer<LanguageProvider>(
            builder: (_, language, __) => Padding(
              padding:havePadding! ?EdgeInsets.symmetric(horizontal: 26.w): const EdgeInsets.all(8),

              child: SizedBox(
                width: 150.w,
                child: RotatedBox(
                  quarterTurns: language.appLanguage == "ar" ? 2 : 0,
                  child: IconButton(
                    onPressed: backPressed ?? () {
                      Navigator.pop(context);
                    } ,
                    icon: Icon(
                      language.appLanguage == "ar"
                          ? Icons.arrow_forward_ios_outlined
                          : Icons.arrow_back_ios_outlined,
                      color: ColorResources.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          )
          : haveLogo
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAssetImage(
                      imageUrl: ImageResources.logo,
                      height: AppSize.h48,
                      width: AppSize.w48,
                    ),
                    const Gap(5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConstants.appName,
                          style: FontManager.getBoldStyle(
                            fontSize: AppSize.sp18,
                            color: ColorResources.black45,
                          ),
                        ),
                        Text(
                          "Delivery_Service".tr(),
                          style: FontManager.getRegularStyle(
                            fontSize: AppSize.sp12,
                            color: ColorResources.lightGrey,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : null,
    );
  }
}
