import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';
import 'package:on_express/features/store_details/widget/payment_method.dart';

class SelctedPayment extends StatelessWidget {
  const SelctedPayment({super.key, required this.storeDetailsViewModel});
  final StoreDetailsViewModel storeDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment_Method".tr(),
          style: FontManager.getSemiBold(
            fontSize: AppSize.sp16,
            color: ColorResources.black,
          ),
        ),
        const Gap(10),
        PaymentItem(
          paymentMethod: storeDetailsViewModel
              .paymentMethods[storeDetailsViewModel.selectPaymentMethod],
          isSelected: true,
          onTap: () {},
          noPaymentImage:
              storeDetailsViewModel.selectPaymentMethod == 3 ? true : false,
        )
      ],
    );
  }
}
