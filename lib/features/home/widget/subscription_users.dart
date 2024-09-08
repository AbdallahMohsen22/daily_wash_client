import 'package:flutter/material.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:provider/provider.dart';

class SubscriptionUsers extends StatelessWidget {
  const SubscriptionUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (_, language, __) => Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: language.appLanguage == "ar" ? 40 : 25,
              child: Container(
                height: 30.0,
                width: 30.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageResources.user),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: language.appLanguage == "ar" ? 60 : 50.0,
              child: Container(
                height: 30.0,
                width: 30.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageResources.user2),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: language.appLanguage == "ar" ? 20 : 75.0,
              child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: ColorResources.darkYellow,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "+8",
                      style: FontManager.getBoldStyle(
                          fontSize: AppSize.sp12, color: ColorResources.white),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
