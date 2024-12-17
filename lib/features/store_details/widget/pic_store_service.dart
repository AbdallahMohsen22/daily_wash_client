import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/features/home/widget/pic_service_type.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';

class PickStoreServiceType extends StatelessWidget {
  const PickStoreServiceType({
    super.key,
    required this.storeDetailsViewModel,
  });

  final StoreDetailsViewModel storeDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "pick_service_type".tr(),
          style: FontManager.getMediumStyle(
            fontSize: AppSize.sp14,
            color: ColorResources.black,
          ),
        ),
        const Gap(50),
        BlocBuilder<GenericCubit<int?>, GenericCubitState<int?>>(
          bloc: storeDetailsViewModel.serviceTypeCubit,
          builder: (context, state) => Wrap(
            //runSpacing: 10,
            spacing: 10,
            children: storeDetailsViewModel.serviceTypes.map((serive) {
              int index = storeDetailsViewModel.serviceTypes.indexOf(serive);

              return ServiceItem(
                serviceTypeModel: serive,
                onTap: () => storeDetailsViewModel.setSelectedService(index,context),
                isSelected: storeDetailsViewModel.selectedServiceType == index
                    ? true
                    : false,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
