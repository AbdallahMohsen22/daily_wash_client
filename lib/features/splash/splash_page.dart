import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_express/config/routes/app_route.dart';
import 'package:on_express/core/cache/init_screen_cahce.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';

import '../../cubits/app_cubit/app_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int? initScreen;
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getCurrentLocation(context);

    Future.delayed(
      const Duration(seconds: 5),
      () async {
        final Locale appLocale = Localizations.localeOf(context);
        context.setLocale(appLocale);
        initScreen = await InitScreenPrefs.getOnce();
        if (context.mounted) {
          checkExistUser();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageResources.background),
                fit: BoxFit.cover)),
        child: Center(
          child: CustomAssetImage(
            imageUrl: ImageResources.logo,
            height: context.height * 0.2,
            width: context.width * 0.6,
          ),
        ),
      ),
    );
  }

  void checkExistUser() {
    if (initScreen == 1) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.onboardingPage, (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.navigationPage,
        (route) => false,
      );
    }
  }
}
