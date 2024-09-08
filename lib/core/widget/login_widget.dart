import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/features/login/login_page.dart';

import '../utils/app_size.dart';
import '../utils/color_resources.dart';
import '../utils/font_manager.dart';
import '../utils/image_resources.dart';
import 'custom_asset_image.dart';
import 'custom_button.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppSize.w20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAssetImage(
            imageUrl: ImageResources.logout2,
            fit: BoxFit.contain,
            height: context.height * 0.15,
            width: context.width * 0.5,
          ),
          const Gap(15),
          CustomButton(
            title: 'sign_in'.tr(),
            onTap: (){
              navigateTo(context, LoginPage());
            },
            isSelected: true,
          ),
        ],
      ),
    );
  }
}
