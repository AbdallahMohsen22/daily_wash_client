import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';

class DriverStatus extends StatelessWidget {
  DriverStatus({super.key, this.duration});

  String? duration;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: AppSize.h80,
        margin: EdgeInsets.symmetric(horizontal: AppSize.w20),
        decoration: BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.circular(AppSize.h15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Driver is straight ahead to you in",
              style: FontManager.getMediumStyle(
                fontSize: AppSize.sp18,
                color: ColorResources.black,
              ),
            ),
            const Gap(5),
            Text(
              duration??"0 Min",
              style: FontManager.getMediumStyle(
                fontSize: AppSize.sp18,
                color: ColorResources.primaryColor,
              ),
            ),
          ],
        ));
  }
}
