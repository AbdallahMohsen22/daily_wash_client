import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
  });
  final String imageUrl;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              CustomAssetImage(
                imageUrl: imageUrl,
                height: AppSize.h30,
                width: AppSize.w30,
              ),
              const Gap(10),
              Text(
                title,
                style: FontManager.getMediumStyle(
                  fontSize: AppSize.sp16,
                  color: ColorResources.black,
                ),
              )
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: ColorResources.kArrowColor,
          size: 18,
        ),
      ],
    );
  }
}
