import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_divider.dart';

import '../../../cubits/app_cubit/app_cubit.dart';
import '../../../cubits/app_cubit/app_states.dart';
import '../../../models/providers_model.dart';
import '../store_details_page.dart';

class TotalOrderWidget extends StatefulWidget {
  TotalOrderWidget({super.key, this.deliveryFee,  this.laundryFee, this.provider, this.isDeliveryFee});
  bool? isDeliveryFee= false;
  int? deliveryFee;
  int? laundryFee;
  ProviderData? provider;

  @override
  State<TotalOrderWidget> createState() => _TotalOrderWidgetState();
}

class _TotalOrderWidgetState extends State<TotalOrderWidget> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = AppCubit.get(context);
    final double transactionFees = (widget.laundryFee ?? 0) * ((widget.provider?.transactionFees ?? 0) / 100);
    final String total =
   "${cubit.couponModel != null
        ?cubit.couponModel!.data!.discountType==1
        ?widget.deliveryFee! - (widget.deliveryFee!/cubit.couponModel!.data!.discountValue!) + widget.laundryFee! + transactionFees + widget.provider!.taxes!
        :widget.deliveryFee! - cubit.couponModel!.data!.discountValue! + widget.laundryFee! + transactionFees + widget.provider!.taxes!
        :widget.deliveryFee! + widget.laundryFee! + transactionFees + widget.provider!.taxes!} AED";

    List<Clothing>? clothes =
    widget.provider!.serviceDetails!.clothes;
    List<Car>? cars= widget.provider!.serviceDetails!.cars;
    List<House>? houses= widget.provider!.serviceDetails!.house;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(cubit.couponModel!=null)
          AmountItem(
          title: "discount".tr(),
          value:'${cubit.couponModel!.data!.discountValue} ${cubit.couponModel!.data!.discountType==1 ? '%':'AED'}',
          isTotal: false,
        ),
        const Gap(10),
        clothes!=null ? AmountItem(
          title: "delivery_fee".tr(),
          value: "${widget.deliveryFee ??0 } AED",
          isTotal: false,
        ):Container(),
        const Gap(10),
        AmountItem(
          title:clothes!=null ? "laundry_fee".tr():cars!=null ?'vehicle_cleaning_fees'.tr():'cleaning_fees'.tr(),
          value: "${widget.laundryFee??0} AED",
          isTotal: false,
        ),
        const Gap(10),
        AmountItem(
          title: "transaction_fee".tr(),
          value: "${widget.provider?.transactionFees ??0} %",
          isTotal: false,
        ),
        const Gap(10),
        AmountItem(
          title: "tax".tr(),
          value: "${widget.provider?.taxes ??0}  AED",
          isTotal: false,
        ),
        const Gap(10),
        const CustomDivider(),
        const Gap(10),

        AmountItem(
          title: "total_order".tr(),
          value: total,
          isTotal: true,
        ),
      ],
    );
  },
);
  }
}

class AmountItem extends StatelessWidget {
  const AmountItem({
    super.key,
    required this.title,
    required this.value,
    required this.isTotal,
  });

  final String title;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isTotal
              ? FontManager.getBoldStyle(
                  fontSize: AppSize.sp20,
                  color: ColorResources.black,
                )
              : FontManager.getSemiBold(
                  fontSize: AppSize.sp16,
                  color: ColorResources.black,
                ),
        ),
        Text(
          value,
          style: isTotal
              ? FontManager.getSemiBold(
                  fontSize: AppSize.sp20,
                  color: ColorResources.primaryColor,
                )
              : FontManager.getMediumStyle(
                  fontSize: AppSize.sp14,
                  color: ColorResources.darkGrey2,
                ),
        ),
      ],
    );
  }
}
