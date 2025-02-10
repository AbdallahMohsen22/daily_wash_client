import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/selected_widget.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';

import '../../payment/presentation/views/widgets/my_cart_view_body.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    super.key,
    required this.storeDetailsViewModel,
  });
  final StoreDetailsViewModel storeDetailsViewModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "select_payment_method".tr(),
            style: FontManager.getMediumStyle(
              fontSize: AppSize.sp18,
              color: ColorResources.kFormTitleColor,
            ),
          ),
          const Gap(5),
          BlocBuilder<GenericCubit<int?>, GenericCubitState<int?>>(
            bloc: storeDetailsViewModel.paymentMethodCubit,
            builder: (context, state) {
              return Column(
                children: [
                  ///visa old
                  // GestureDetector(
                  //   onTap: (){
                  //     //UIAlert.showAlert(context,message: 'payment_method_not_available'.tr());
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyCartViewBody()));
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: AppSize.h60,
                  //     margin: EdgeInsets.symmetric(vertical: AppSize.h15),
                  //     padding: EdgeInsets.symmetric(horizontal: AppSize.w20),
                  //     decoration: BoxDecoration(
                  //       color: ColorResources.lightGrey4.withOpacity(0.4),
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         CustomAssetImage(
                  //           imageUrl: storeDetailsViewModel.paymentMethods[0],
                  //           fit: BoxFit.contain,
                  //           height: AppSize.h40,
                  //           width: AppSize.w40,
                  //         ),
                  //         CustomAssetImage(
                  //           imageUrl: storeDetailsViewModel.paymentMethods[1],
                  //           fit: BoxFit.contain,
                  //           height: AppSize.h40,
                  //           width: AppSize.w40,
                  //         ),
                  //         CustomAssetImage(
                  //           imageUrl: storeDetailsViewModel.paymentMethods[2],
                  //           fit: BoxFit.contain,
                  //           height: AppSize.h40,
                  //           width: AppSize.w40,
                  //         ),
                  //         SelectedWidget(isSelected: false)
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  ///visa new (comment now )
                  PaymentItem(
                    paymentMethod: storeDetailsViewModel.paymentMethods.first,
                    isSelected: storeDetailsViewModel.selectPaymentMethod
                        == storeDetailsViewModel.paymentMethods.indexOf(storeDetailsViewModel.paymentMethods.first),
                    onTap: () {
                      storeDetailsViewModel.setSelectedPaymentMethod(
                          storeDetailsViewModel.paymentMethods.indexOf(storeDetailsViewModel.paymentMethods.first)
                      );
                    },
                    noPaymentImage:false,
                  ),

                  ///cash
                  // PaymentItem(
                  //   paymentMethod: storeDetailsViewModel.paymentMethods.last,
                  //   isSelected: storeDetailsViewModel.selectPaymentMethod
                  //       == storeDetailsViewModel.paymentMethods.indexOf(storeDetailsViewModel.paymentMethods.last),
                  //   onTap: () {
                  //     storeDetailsViewModel.setSelectedPaymentMethod(
                  //         storeDetailsViewModel.paymentMethods.indexOf(storeDetailsViewModel.paymentMethods.last)
                  //     );
                  //   },
                  //   noPaymentImage:true,
                  // )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class PaymentItem extends StatelessWidget {
  const PaymentItem({
    super.key,
    required this.paymentMethod,
    required this.isSelected,
    required this.onTap,
    required this.noPaymentImage,
  });

  final String paymentMethod;
  final bool isSelected;
  final VoidCallback onTap;
  final bool noPaymentImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: AppSize.h60,
        margin: EdgeInsets.symmetric(vertical: AppSize.h15),
        padding: EdgeInsets.symmetric(horizontal: AppSize.w20),
        decoration: BoxDecoration(
          color: ColorResources.lightGrey4.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            noPaymentImage
                ? Text(
                    paymentMethod,
                    style: FontManager.getMediumStyle(
                      fontSize: AppSize.sp16,
                      color: ColorResources.black,
                    ),
                  )
                : CustomAssetImage(
                    imageUrl: paymentMethod,
                    fit: BoxFit.contain,
                    height: AppSize.h40,
                    width: AppSize.w40,
                  ),
            SelectedWidget(isSelected: isSelected)
          ],
        ),
      ),
    );
  }
}
