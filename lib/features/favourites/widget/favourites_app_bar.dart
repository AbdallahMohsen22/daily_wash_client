import 'package:flutter/material.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';

class FavouritesAppBar extends StatelessWidget {
  const FavouritesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      //false
      pinned: false,
      expandedHeight: AppSize.h95,
      toolbarHeight: AppSize.h95,
      centerTitle: true,
      backgroundColor: ColorResources.white,
      leadingWidth: AppSize.w20,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: ColorResources.black,
          size: 24,
        ),
      ),
    );
  }
}
