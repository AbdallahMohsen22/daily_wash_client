import 'package:flutter/material.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppSize.w20),
      child: Text(
        title,
        style: FontManager.getMediumStyle(
          fontSize: AppSize.sp16,
          color: ColorResources.kFormTitleColor,
        ),
      ),
    );
  }
}
