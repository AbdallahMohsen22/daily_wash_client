import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/image_net.dart';
import 'package:on_express/features/track_order/track_view_model.dart';
import 'package:on_express/features/track_order/widget/driver_status.dart';
import 'package:on_express/features/track_order/widget/map_back_button.dart';
import 'package:on_express/features/track_order/widget/socail_call_icon.dart';

import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/app_cubit/app_states.dart';
import '../../models/orders_model.dart';

// ignore: must_be_immutable
class TrackMapPage extends StatelessWidget {
  TrackMapPage({Key? key,required this.requestModel,required this.currentLatLng}) : super(key: key);

  final OrderData requestModel;
  final LatLng currentLatLng;


  TrackViewModel trackViewModel = TrackViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: currentLatLng, zoom: 14),
            zoomControlsEnabled: false,
            polylines: {
              if(cubit.directions != null)
                Polyline(
                    width: 5,
                    color: Colors.amber,
                    polylineId: const PolylineId('polyLine'),
                    points: cubit.directions!.polylinePoints.map((e) =>
                        LatLng(e.latitude, e.longitude)).toList()
                ),
            },
            markers: {
              if(cubit.origin != null)cubit.origin!,
              if(cubit.distance != null)cubit.distance!,
            },
          ),
          const Positioned(top: 60, left: 20, child: MapBackButton()),
          Positioned(top: 150, left: 0, right: 0, child: DriverStatus(
            duration: cubit.directions?.totalDuration,
          )),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              height: context.height * 0.3,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(50),
                topEnd: Radius.circular(50),
              )),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  Container(
                    color: ColorResources.primaryColor,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(148)),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSize.w35, vertical: AppSize.h15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cubit.directions?.totalDistance??"0 KM",
                                style: FontManager.getExtraBoldStyle(
                                    fontSize: AppSize.sp30,
                                    color: ColorResources.primaryColor2),
                              ),
                              Text(
                                cubit.directions?.totalDuration??"0 Min",
                                style: FontManager.getRegularStyle(
                                    fontSize: AppSize.sp14,
                                    color: ColorResources.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.h30),
                                    child: ImageNet(
                                      image: requestModel.providerPersonalPhoto??'',
                                      fit: BoxFit.cover,
                                      height: AppSize.h60,
                                      width: AppSize.w60,
                                    ),
                                  ),
                                  const Gap(8),
                                  Text(
                                      requestModel.deliveryManName??'no_name'.tr(),
                                      maxLines: 1,
                                      style: FontManager.getBoldStyle(
                                          fontSize: AppSize.sp18,
                                          color: ColorResources.black)),
                                ],
                              ),
                              Container(
                                height: AppSize.h60,
                                width: AppSize.w60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ColorResources.primaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: CustomAssetImage(
                                    imageUrl: ImageResources.carIcon,
                                    height: AppSize.h40,
                                    width: AppSize.w40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialCallIcon(
                                imageUrl: ImageResources.phoneCall,
                                onTap: () =>
                                    trackViewModel.launchPhoneDialer(context,requestModel.deliveryManPhone??''),
                              ),
                              const Gap(10),
                              SocialCallIcon(
                                imageUrl: ImageResources.whatsapp,
                                onTap: () => trackViewModel.whatsapp(context,requestModel.deliveryManPhone??''),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}
