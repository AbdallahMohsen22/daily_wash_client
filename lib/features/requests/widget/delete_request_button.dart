import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/widget/ui.dart';

class DeleteRequestButton extends StatelessWidget {
  const DeleteRequestButton({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UIAlert.showCupertinoAlertDialog(
          context,
          id: id,
          title: "delete_request".tr(),
        );
      },
      child: Container(
        height: AppSize.h22,
        width: AppSize.w22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 0.5, color: ColorResources.kErrorColor),
        ),
        child: Center(
          child: Icon(
            Icons.close,
            color: ColorResources.kErrorColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
