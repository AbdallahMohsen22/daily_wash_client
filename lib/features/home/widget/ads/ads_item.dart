import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/image_net.dart';
import 'package:on_express/cubits/app_cubit/app_cubit.dart';
import 'package:on_express/features/contect_us/contactus_screen.dart';

import '../../../../models/ads_model.dart';

class AdsItem extends StatelessWidget {
  AdsItem({required this.ad});

  ImageAdvertisements ad;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<AppCubit>().tapOnAd(context,ad: ad);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.w10,
          vertical: AppSize.h15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              ColorResources.primaryColor,
              ColorResources.blue1,
              ColorResources.blue2
            ],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        ad.title??'',
                        textAlign: TextAlign.left,
                        style: FontManager.getBoldStyle(
                          fontSize: AppSize.sp20,
                          color: ColorResources.white,
                        ),
                      ),
                      CustomAssetImage(
                        imageUrl: ImageResources.ok,
                        height: AppSize.h20,
                        width: AppSize.w20,
                      )
                    ],
                  ),
                  Text(
                    ad.description??'',
                    maxLines: 2,
                    style: FontManager.getMediumStyle(
                      fontSize: AppSize.sp14,
                      color: ColorResources.white,
                    ),
                  ),
                  // const Gap(8),
                  // Row(
                  //   children: [
                  //     Container(
                  //       height: AppSize.h30,
                  //       width: AppSize.w30,
                  //       decoration: const BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: ColorResources.white,
                  //       ),
                  //       child: Center(
                  //         child: CustomAssetImage(
                  //           imageUrl: ImageResources.call,
                  //           height: AppSize.h15,
                  //           width: AppSize.w15,
                  //         ),
                  //       ),
                  //     ),
                  //     const Gap(3),
                  //     Text(
                  //       "+971 3522 493 1999",
                  //       style: FontManager.getBoldStyle(
                  //         fontSize: AppSize.sp14,
                  //         color: ColorResources.white,
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ImageNet(
                image: ad.backgroundImage??'',
                height: context.height * 0.15,
                width: context.width * 0.2,
              ),
            ),
            // CustomAssetImage(
            //   imageUrl: ImageResources.ads,
            //   height: context.height * 0.15,
            //   width: context.width * 0.2,
            // )
          ],
        ),
      ),
    );
  }
}
