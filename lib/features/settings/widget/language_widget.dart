import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/settings/widget/change_language_widget.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key, required this.languageProvider});
  final LanguageProvider languageProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Language".tr(),
          style: FontManager.getMediumStyle(
            fontSize: AppSize.sp18,
            color: ColorResources.kArrowColor,
          ),
        ),
        GestureDetector(
          onTap: () => UIAlert.buildCustomBottomSheet(
            context,
            ChangeLanguageWidget(
              languageProvider: languageProvider,
            ),
          ),
          child: Row(
            children: [
              Text(
                languageProvider.appLanguage == "en" ? "English" : "العربية",
                style: FontManager.getMediumStyle(
                  fontSize: AppSize.sp18,
                  color: ColorResources.kArrowColor,
                ),
              ),
              const Gap(5),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorResources.kArrowColor,
                size: 18,
              )
            ],
          ),
        )
      ],
    );
  }
}
