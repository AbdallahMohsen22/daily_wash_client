import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';

class PickDeliveryService extends StatelessWidget {
  const PickDeliveryService({super.key, required this.storeDetailsViewModel});

  final StoreDetailsViewModel storeDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(storeDetailsViewModel.selectedServiceType != -1)
        Text(
          "pick_delivery_service".tr(),
          style: FontManager.getMediumStyle(
            fontSize: AppSize.sp14,
            color: ColorResources.black,
          ),
        ),
        const Gap(15),
        BlocBuilder<GenericCubit<int?>, GenericCubitState<int?>>(
          bloc: storeDetailsViewModel.deliveryTypeCubit,
          builder: (context, state) =>storeDetailsViewModel.selectedServiceType != -1 ? Wrap(
            //runSpacing: 10,
            spacing: 10,
            children: storeDetailsViewModel.selectedDeliveryService.map(
              (serive) {
                int index = storeDetailsViewModel.selectedDeliveryService
                    .indexOf(serive);

                return GestureDetector(
                  onTap: () => storeDetailsViewModel.setSelectedDelivery(index),
                  child: Image.asset(
                    storeDetailsViewModel.selectedDelivery == index
                        ? storeDetailsViewModel.selectedDeliveryService[index]
                        : storeDetailsViewModel
                            .unSelectedDeliveryService[index],
                    height: AppSize.h50,
                    width: context.width * 0.41,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ).toList(),
          ):SizedBox(),
        ),
      ],
    );
  }
}
