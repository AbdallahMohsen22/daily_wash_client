import 'package:flutter/material.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';

import '../utils/image_resources.dart';

// ignore: must_be_immutable
class DefaultScaffold extends StatelessWidget {
  DefaultScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.titleAppbar = '',
    this.haveArrow = true,
    this.haveNotification = true,
    this.havePadding = true,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.haveBackground = false,
    this.backGround,
  });

  Widget child;
  Widget? bottomSheet;
  Widget? bottomNavigationBar;
  AppBar? appBar;
  String titleAppbar;
  bool haveArrow;
  bool haveNotification;
  bool havePadding;
  bool haveBackground;
  String? backGround;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar,
      body: Stack(
        children: [

          //if(!haveBackground)
            Container(
            color: ColorResources.primaryColor,
          ),
          if(haveBackground)
            Stack(
              children: [

                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadiusDirectional.only(topEnd: Radius.circular(148)),
                      image: DecorationImage(
                          image:AssetImage(backGround!= null?backGround!:ImageResources.background),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                // backGround !=null?Container(
                //   height: context.height,
                //   width: context.width,
                //   color: Colors.white.withOpacity(.1),
                // ):Container(),
              ],
            ),
          if(!haveBackground)
            Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadiusDirectional.only(topEnd: Radius.circular(148)),
            ),
          ),
          
          SafeArea(
              bottom: false,
              child: Padding(
                padding: havePadding?EdgeInsets.only(
                    left: AppSize.w30, right: AppSize.w30, top: AppSize.h45):EdgeInsets.zero,
                child: child,
              )),
        ],
      ),
      bottomSheet: bottomSheet,
    );
  }
}
