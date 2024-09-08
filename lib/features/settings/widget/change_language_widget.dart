import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/features/bottom_navigation_bar/navigation_page.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({super.key, required this.languageProvider});

  final LanguageProvider languageProvider;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "select_language".tr(),
            style: FontManager.getBoldStyle(
              fontSize: AppSize.sp20,
              color: ColorResources.black,
            ),
          ),
          const Gap(30),
          Column(
            children: [
              CustomButton(
                title: 'العربية',
                isSelected: true,
                onTap: () {

                  languageProvider
                      .changeLanguage(const Locale("ar"), context)
                      .then(
                        (value) =>navigateAndFinish(context, NavigationPage()),
                      );
                },
              ),
              const Gap(20),
              CustomButton(
                title: 'English',
                isSelected: true,
                onTap: () {
                  languageProvider
                      .changeLanguage(const Locale("en"), context)
                      .then(
                        (value) => navigateAndFinish(context, NavigationPage()),
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
