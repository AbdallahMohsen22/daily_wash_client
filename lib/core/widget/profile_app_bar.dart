import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:provider/provider.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          child: Consumer<LanguageProvider>(
            builder: (_, language, __) => RotatedBox(
              quarterTurns: language.appLanguage == "ar" ? 2 : 0,
              child: Icon(
                language.appLanguage == "ar"
                    ?Icons.arrow_forward_ios_outlined
                    :Icons.arrow_back_ios_outlined,
                color: ColorResources.black,
                size: 24,
              ),
            ),
          ),
        ),
        const Gap(10),
        Text(
          title,
          style: FontManager.getSemiBold(
            fontSize: AppSize.sp20,
            color: ColorResources.black,
          ),
        )
      ],
    );
  }
}
