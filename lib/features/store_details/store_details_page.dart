import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/constants/app_constants.dart';
import 'package:on_express/core/widget/base_app_bar.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/verification_phone_dialogs.dart';
import 'package:on_express/features/login/login_page.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';
import 'package:on_express/features/store_details/widget/coupon_notes_widget.dart';
import 'package:on_express/features/store_details/widget/payment_method.dart';
import 'package:on_express/features/store_details/widget/total_order.dart';
import 'package:on_express/features/store_details/widget/user_address_widget.dart';
import 'package:on_express/features/store_details/widget/date_time_widget.dart';
import 'package:on_express/features/store_details/widget/pic_store_service.dart';
import 'package:on_express/features/store_details/widget/pick_delivery_service.dart';
import 'package:on_express/features/store_details/widget/store_image.dart';
import 'package:on_express/models/providers_model.dart';

import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/app_cubit/app_states.dart';
import '../../cubits/menu_cubit/menu_cubit.dart';
import '../../cubits/menu_cubit/menu_states.dart';
import '../payment/data/repos/checkout_repo_impl.dart';
import '../payment/presentation/manager/cuibt/payment_cuibt.dart';
import '../payment/presentation/manager/cuibt/payment_state.dart';
import '../payment/presentation/views/widgets/custom_botton_bloc_consumer.dart';

// ignore: must_be_immutable
class StoreDetailsPage extends StatelessWidget {
  StoreDetailsPage({super.key, this.provider});

  ProviderData? provider;

  StoreDetailsViewModel storeDetailsViewModel = StoreDetailsViewModel();

  CouponAndNotes couponAndNotes = CouponAndNotes();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return BlocConsumer<AppCubit, AppStates>(

      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var total=storeDetailsViewModel.selectedServiceType == 0
            ?storeDetailsViewModel.selectedDelivery == 0
            ?MenuCubit.get(context).settingsModel?.data?.shippingChargers?.deliveryBig
            :MenuCubit.get(context).settingsModel?.data?.shippingChargers?.deliverySmall
            :storeDetailsViewModel.selectedDelivery == 0
            ?MenuCubit.get(context).settingsModel?.data?.shippingChargers?.pickupBig
            :MenuCubit.get(context).settingsModel?.data?.shippingChargers?.pickupSmall;

        return DefaultScaffold(
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [
              BaseAppBar(isBackExist: true),
            ],
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StoreImage(provider: provider),
                  const Gap(30),
                  PickStoreServiceType(
                    storeDetailsViewModel: storeDetailsViewModel,
                  ),
                  const Gap(10),
                  PickDeliveryService(
                    storeDetailsViewModel: storeDetailsViewModel,
                  ),
                  const Gap(30),
                  DateAndTimeWidget(
                    storeDetailsViewModel: storeDetailsViewModel,
                  ),
                  const Gap(20),
                  if(token!=null)
                  UserAddressWidget(
                    storeDetailsViewModel: storeDetailsViewModel,
                  ),
                  if(token!=null)
                  const Gap(20),
                  PaymentMethod(
                    storeDetailsViewModel: storeDetailsViewModel,
                  ),
                  const Gap(20),
                  couponAndNotes,
                    const Gap(20),
                  ConditionalBuilder(
                    condition: MenuCubit.get(context).settingsModel!=null,
                    fallback: (c)=>Center(child: CupertinoActivityIndicator(),),
                    builder: (c)=>
                        TotalOrderWidget(
                      deliveryFee: total,
                    ),

                  ),
                  // Text("Total amount====>>>${total}"),

                  const Gap(30),
                  Align(
                    alignment: Alignment.center,
                    child: ConditionalBuilder(
                      condition: state is! CreateOrderLoadingState,
                      fallback: (context)=>CupertinoActivityIndicator(),
                      builder: (context)=> CustomButton(
                        title: "Submit_request".tr(),
                        onTap: () {
                          if (token != null) {
                            if (MenuCubit.get(context).userModel?.data?.phoneNumber?.isNotEmpty ?? false) {
                              if (MenuCubit.get(context).userModel?.data?.status == 2) {
                                if (storeDetailsViewModel.selectPaymentMethod == 0) {
                                  // Show the payment options modal bottom sheet
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16)),
                                    builder: (context) {
                                      return BlocProvider(
                                          create: (context) => PaymentCubit(CheckoutRepoImpl()),
                                          child:  BlocConsumer<PaymentCubit, PaymentState>(
                                              listener: (context, state) {
                                                if (state is PaymentSuccess) {
                                                  // Navigator.of(context).pushReplacement(
                                                  //     MaterialPageRoute(builder: (context) => ThankYouView()));

                                                  storeDetailsViewModel.addRequest(
                                                    context: context,
                                                    storeDetailsViewModel: storeDetailsViewModel,
                                                    providerId: provider?.id ?? '',
                                                    couponCode: cubit.couponModel != null ? couponAndNotes.couponController.text : null,
                                                    additionalNotes: couponAndNotes.notesController.text.isNotEmpty ? couponAndNotes.notesController.text : null,
                                                  );
                                                  print("Total====>>>>");
                                                }
                                                if (state is PaymentFailure) {
                                                  Navigator.pop(context);

                                                  print("Error=====>>>${state.errMessage}");
                                                }
                                              },
                                              builder: (context, state){
                                                return CustomButtonBlocConsumer(total: total,);
                                              },

                                              )
                                      );
                                    },
                                  );
                                } else {
                                  // Handle cash submission directly
                                  storeDetailsViewModel.addRequest(
                                    context: context,
                                    storeDetailsViewModel: storeDetailsViewModel,
                                    providerId: provider?.id ?? '',
                                    couponCode: cubit.couponModel != null ? couponAndNotes.couponController.text : null,
                                    additionalNotes: couponAndNotes.notesController.text.isNotEmpty ? couponAndNotes.notesController.text : null,
                                  );
                                }
                              } else {
                                // User's phone number is not verified
                                showDialog(
                                    context: context,
                                    builder: (context) => VerifyPhoneDialog());
                              }
                            } else {
                              // User's phone number is empty
                              showDialog(
                                  context: context,
                                  builder: (context) => UpdatePhoneDialog());
                            }
                          } else {
                            // User is not logged in
                            navigateTo(context, LoginPage(fromLogin: false));
                          }
                        },
                        isSelected: true,
                      ),
                    ),
                  ),
                  const Gap(50),
                ],
              ),
            ),
          ),
        );
      },
    );
  },
);
  }
}
//051900004