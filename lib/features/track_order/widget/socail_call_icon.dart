import 'package:flutter/material.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';

class SocialCallIcon extends StatelessWidget {
  const SocialCallIcon({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  final String imageUrl;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSize.h60,
        width: AppSize.w60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ColorResources.primaryColor,
            width: 1,
          ),
        ),
        child: Center(
          child: CustomAssetImage(
            imageUrl: imageUrl,
            height: AppSize.h30,
            width: AppSize.w30,
          ),
        ),
      ),
    );
  }
}
