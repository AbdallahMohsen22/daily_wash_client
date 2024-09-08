import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({
    super.key,
    required this.isRegister,
    required this.onTap,
  });

  final bool isRegister;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isRegister ? "already_have_account".tr() : "have_account".tr(),
          style: FontManager.getRegularStyle(
              fontSize: AppSize.sp14, color: ColorResources.black),
        ),
        const Gap(4),
        GestureDetector(
          onTap: onTap,
          child: Text(
            isRegister ? "sign_in".tr() : "register_now".tr(),
            style: FontManager.getRegularStyle(
                fontSize: AppSize.sp14, color: ColorResources.primaryColor),
          ),
        )
      ],
    );
  }
}
