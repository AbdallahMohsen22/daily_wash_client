import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
    this.iconImage,
    this.socialIcon,
  });

  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  String? iconImage;
  String? socialIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: AppSize.h62,
        width: context.width * 0.75,
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.h15),
          color: isSelected ? ColorResources.primaryColor : null,
          border: Border.all(
            color:
                !isSelected ? ColorResources.primaryColor : Colors.transparent,
            width: isSelected ? 0 : 1.5,
          ),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (socialIcon != null) ...[
                CustomAssetImage(
                  imageUrl: socialIcon!,
                  height: AppSize.h26,
                  width: AppSize.w25,
                ),
                const Gap(10),
              ],
              Text(
                title,
                style: FontManager.getBoldStyle(
                  fontSize: AppSize.sp16,
                  color: isSelected
                      ? ColorResources.white
                      : ColorResources.primaryColor,
                ),
              ),
              if (iconImage != null) ...[
                const Gap(10),
                CustomAssetImage(
                  imageUrl: iconImage!,
                  height: AppSize.h26,
                  width: AppSize.w25,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
