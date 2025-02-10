// ignore: must_be_immutable
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/widget/base_app_bar.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/confirm_order/widget/confirm_dailog.dart';
import 'package:on_express/features/confirm_order/widget/selcted_date_time.dart';
import 'package:on_express/features/confirm_order/widget/selcted_payment.dart';
import 'package:on_express/features/confirm_order/widget/selected_address.dart';
import 'package:on_express/features/confirm_order/widget/selected_note.dart';
import 'package:on_express/features/confirm_order/widget/selected_service_type.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';
import 'package:on_express/features/store_details/widget/store_image.dart';
import 'package:on_express/features/store_details/widget/total_order.dart';

import '../../cubits/menu_cubit/menu_cubit.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({super.key, required this.storeDetailsViewModel});

  final StoreDetailsViewModel storeDetailsViewModel;
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          BaseAppBar(isBackExist: true),
        ],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StoreImage(),
              const Gap(20),
              SelectedSeriveType(
                storeDetailsViewModel: storeDetailsViewModel,
              ),
              const Gap(20),
              SelectedDateAndTime(
                storeDetailsViewModel: storeDetailsViewModel,
              ),
              const Gap(20),
              SelectedAddress(
                storeDetailsViewModel: storeDetailsViewModel,
              ),
              const Gap(20),
              const SelectedNote(),
              const Gap(20),
              SelctedPayment(
                storeDetailsViewModel: storeDetailsViewModel,
              ),
              const Gap(20),
              TotalOrderWidget(

                deliveryFee: storeDetailsViewModel.selectedServiceType == 0
                    ?storeDetailsViewModel.selectedDelivery == 0
                    ?MenuCubit.get(context).settingsModel?.data?.shippingChargers?.deliveryBig
                    :MenuCubit.get(context).settingsModel?.data?.shippingChargers?.deliverySmall
                    :storeDetailsViewModel.selectedDelivery == 0
                    ?MenuCubit.get(context).settingsModel?.data?.shippingChargers?.pickupBig
                    :MenuCubit.get(context).settingsModel?.data?.shippingChargers?.pickupSmall,
              ),
              const Gap(30),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  title: "Submit_request".tr(),
                  onTap: () {
                    UIAlert.showCustomDailog(
                      context,
                      child: const ConfirmDailog(),
                    );
                  },
                  isSelected: true,
                ),
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
