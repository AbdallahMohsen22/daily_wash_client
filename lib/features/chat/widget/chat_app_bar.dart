import 'package:flutter/material.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: AppSize.h120,
        centerTitle: true,
        backgroundColor: ColorResources.white,
        titleSpacing: 20,
        title: Text(
          "Name Of Store",
          style: FontManager.getSemiBold(
            fontSize: AppSize.sp20,
            color: ColorResources.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 10, left: 10),
            child: CustomAssetImage(
              imageUrl: ImageResources.notification,
              height: AppSize.h22,
              width: AppSize.w22,
            ),
          ),
        ],
        leadingWidth: AppSize.w40,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: ColorResources.black,
              size: 24,
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
