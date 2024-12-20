import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/image_net.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/home/widget/subscription_users.dart';
import 'package:on_express/features/store_details/store_details_page.dart';
import 'package:on_express/models/providers_model.dart';
import '../../../core/constants/app_constants.dart';
import '../../../cubits/app_cubit/app_cubit.dart';
import '../../../cubits/app_cubit/app_states.dart';

class LaundromatItem extends StatelessWidget {
  LaundromatItem({super.key,this.provider});

  ProviderData? provider;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
    provider?.distance='500km';

    return GestureDetector(
      onTap: () {
        AppCubit.get(context).orderLatLng = null;
        AppCubit.get(context).currentAddressIndex = -1;
        AppCubit.get(context).couponModel = null;
        AppCubit.get(context).addressController.text = '';
        UIAlert.showMaterialPage(context, child: StoreDetailsPage(provider: provider,));
      },
      child: Container(
        width: context.width,
        height: context.height * 0.15,
        margin: EdgeInsets.symmetric(vertical: AppSize.h15),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.w15,
          vertical: AppSize.h5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.h20),
          color: ColorResources.kfilledColor,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageNet(
                image:provider?.personalPhoto??'',
                height: context.height * 0.11,
                width: AppSize.w110,
                fit: BoxFit.cover,
              ),
            ),

            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          provider?.name??'no_name'.tr(),
                          style: FontManager.getMediumStyle(
                            fontSize: AppSize.sp18,
                            color: ColorResources.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if(token!=null)
                      ConditionalBuilder(
                        condition: AppCubit.get(context).favLoadingId != provider?.id,
                        fallback: (c)=>CupertinoActivityIndicator(),
                        builder: (c)=> InkWell(
                          onTap: (){
                            AppCubit.get(context).changeFav(context, provider?.id??'');
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomAssetImage(
                              imageUrl: AppCubit.get(context).favorites[provider?.id]??false ?ImageResources.favourite:ImageResources.favourites,
                              height: AppSize.h18,
                              width: AppSize.w18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      if(provider?.distance!=null)
                      LaundromateTtile(
                        imageUrl: ImageResources.distance,
                        title: provider!.distance!,
                        titleColor: ColorResources.black,
                      ),
                      if(provider?.distance!=null)
                        const Gap(15),
                      LaundromateTtile(
                        imageUrl: ImageResources.location,
                        title: provider?.address??'no_address'.tr(),
                        titleColor: ColorResources.black,
                      ),
                    ],
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: ColorResources.darkYellow,
                        size: 12,
                      ),
                      const Gap(3),
                      Text(
                        '${provider?.totalRate??0}',
                        style: FontManager.getSemiBold(
                          fontSize: AppSize.sp14,
                          color: ColorResources.black,
                        ),
                      ),
                      const Gap(15),
                      const Expanded(child: SubscriptionUsers()),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  },
);
  }
}

class LaundromateTtile extends StatelessWidget {
  const LaundromateTtile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.titleColor,
  });

  final String imageUrl;
  final String title;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomAssetImage(
            imageUrl: imageUrl,
            height: AppSize.h12,
            width: AppSize.w12,
          ),
          const Gap(3),
          Expanded(
            child: Text(
              title,
              style: FontManager.getMediumStyle(
                fontSize: AppSize.sp14,
                color: titleColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
