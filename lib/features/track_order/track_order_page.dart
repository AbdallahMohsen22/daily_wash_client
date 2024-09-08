import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/widget/base_app_bar.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/image_net.dart';
import 'package:on_express/core/widget/image_zoom.dart';
import 'package:on_express/features/store_details/widget/store_image.dart';
import 'package:on_express/features/track_order/track_map_page.dart';
import 'package:on_express/features/track_order/widget/custom_stepper.dart';
import 'package:on_express/features/track_order/widget/oder_serive.dart';
import 'package:on_express/features/track_order/widget/track_date_time.dart';
import 'package:on_express/features/track_order/widget/track_notes.dart';
import 'package:on_express/models/providers_model.dart';

import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/app_cubit/app_states.dart';
import '../../models/orders_model.dart';
import '../home/widget/review_restaurant_dialog.dart';

// ignore: must_be_immutable
class TrackOrderPage extends StatelessWidget {
  TrackOrderPage({super.key, required this.requestModel});

  final OrderData requestModel;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return DefaultScaffold(
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [
              BaseAppBar(
                isBackExist: true,
              ),
            ],
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSetpper(status:requestModel.status??1),
                  if(requestModel.status == 2 || requestModel.status == 4
                      || requestModel.status == 3)
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                        title: "track_now".tr(),
                        onTap: () async{
                          if(requestModel.status == 2){
                            await cubit.getDirection(
                              originLatLng: LatLng(
                                  double.parse(requestModel.deliveryManLatitude??''),
                                double.parse(requestModel.deliveryManLongitude??''),
                              ),
                              destinationLatLng: LatLng(
                                  double.parse(requestModel.userLatitude??''),
                                double.parse(requestModel.userLongitude??''),
                              ),
                            );
                            navigateTo(context, TrackMapPage(
                              currentLatLng: LatLng(
                                double.parse(requestModel.deliveryManLatitude??''),
                                double.parse(requestModel.deliveryManLongitude??''),
                              ),
                              requestModel: requestModel,
                            ));
                          }
                          if(requestModel.status == 3){
                            await cubit.getDirection(
                              originLatLng: LatLng(
                                double.parse(requestModel.deliveryManLatitude??''),
                                double.parse(requestModel.deliveryManLongitude??''),
                              ),
                              destinationLatLng: LatLng(
                                double.parse(requestModel.providerLatitude??''),
                                double.parse(requestModel.providerLongitude??''),
                              ),
                            );
                            navigateTo(context, TrackMapPage(
                              currentLatLng: LatLng(
                                double.parse(requestModel.deliveryManLatitude??''),
                                double.parse(requestModel.deliveryManLongitude??''),
                              ),
                              requestModel: requestModel,
                            ));
                          }
                          if(requestModel.status == 4){
                            await cubit.getDirection(
                              originLatLng: LatLng(
                                double.parse(requestModel.deliveryManLatitude??''),
                                double.parse(requestModel.deliveryManLongitude??''),
                              ),
                              destinationLatLng: LatLng(
                                double.parse(requestModel.userLatitude??''),
                                double.parse(requestModel.userLongitude??''),
                              ),
                            );
                            navigateTo(context, TrackMapPage(
                              currentLatLng: LatLng(
                                double.parse(requestModel.deliveryManLatitude??''),
                                double.parse(requestModel.deliveryManLongitude??''),
                              ),
                              requestModel: requestModel,
                            ));
                          }
                        },
                        isSelected: true),
                  ),
                  if(requestModel.status == 5)
                    Center(
                      child: CustomButton(
                          title: 'review'.tr(),
                          onTap: (){
                            showDialog(context: context, builder:(context)=>
                                ReviewStoreDialog(orderData: requestModel,));
                          },
                          isSelected: true),
                    ),
                  const Gap(20),
                  StoreImage(
                    orderStatus: cubit.orderStatus[requestModel.status! -1].title,
                    provider: ProviderData(
                      personalPhoto: requestModel.providerPersonalPhoto??'',
                      name: requestModel.providerName,
                    ),
                  ),
                  const Gap(20),
                  TrackPickService(serviceType: requestModel.serviceType??1),
                  const Gap(20),
                  TrackDateAndTimeWidget(
                    date: requestModel.orderedDate??'',
                    orderedReceivingDate: requestModel.orderedReceivingDate,
                  ),
                  const Gap(20),
                  if(requestModel.orderedReceivingReceipt!=null)
                    if(requestModel.orderedReceivingReceipt!.isNotEmpty)
                    InkWell(
                      onTap: ()=>navigateTo(context, ImageZoom(requestModel.orderedReceivingReceipt!)),
                      child: Center(child: ImageNet(
                        image: requestModel.orderedReceivingReceipt!,
                        height: 200,
                        width: 200,
                      )),
                    ),
                  if(requestModel.orderedReceivingReceipt!=null)
                    if(requestModel.orderedReceivingReceipt!.isNotEmpty)
                      const Gap(20),
                  if(requestModel.additionalNotes!=null)
                  TrackNotes(note: requestModel.additionalNotes!),
                  const Gap(35),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
