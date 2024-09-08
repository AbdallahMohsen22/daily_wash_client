import 'package:flutter/material.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:provider/provider.dart';

class MapBackButton extends StatelessWidget {
  const MapBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: AppSize.h60,
        width: AppSize.w60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.h15),
          color: ColorResources.white,
        ),
        child: Consumer<LanguageProvider>(
          builder: (_, language, __) => Icon(
            language.appLanguage == "en"
                ? Icons.arrow_back_ios_new
                : Icons.arrow_forward_ios,
            color: ColorResources.black,
            size: 24,
          ),
        ),
      ),
    );
  }
}
