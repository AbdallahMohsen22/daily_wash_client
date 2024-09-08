import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';

class ActiveNotificationWidget extends StatefulWidget {
  const ActiveNotificationWidget({super.key});

  @override
  State<ActiveNotificationWidget> createState() =>
      _ActiveNotificationWidgetState();
}

class _ActiveNotificationWidgetState extends State<ActiveNotificationWidget> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "notifications".tr(),
          style: FontManager.getMediumStyle(
            fontSize: AppSize.sp18,
            color: ColorResources.kArrowColor,
          ),
        ),
        CupertinoSwitch(
          value: _switchValue,
          activeColor: ColorResources.primaryColor,
          onChanged: (value) {
            setState(() {
              _switchValue = value;
            });
          },
        ),
      ],
    );
  }
}
