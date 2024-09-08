import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/features/home/home_view_model.dart';
import 'package:on_express/features/home/model/service_type_model.dart';

class PickServiceType extends StatelessWidget {
  const PickServiceType({
    super.key,
    required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

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
        const Gap(15),
        BlocBuilder<GenericCubit<int>, GenericCubitState<int>>(
          bloc: homeViewModel.serviceTypeCubit,
          builder: (context, state) => Wrap(
            //runSpacing: 10,
            spacing: 10,
            children: homeViewModel.serviceTypes.map((serive) {
              int index = homeViewModel.serviceTypes.indexOf(serive);

              return ServiceItem(
                serviceTypeModel: serive,
                onTap: () => homeViewModel.setSelectedService(index),
                isSelected: state.data == index ? true : false,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    super.key,
    required this.serviceTypeModel,
    required this.onTap,
    required this.isSelected,
  });

  final ServiceTypeModel serviceTypeModel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width * 0.41,
        height: AppSize.h95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.h15),
          color: ColorResources.grey,
          border: Border.all(
            width: isSelected ? 2 : 0,
            color:
                isSelected ? ColorResources.primaryColor : Colors.transparent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAssetImage(
              imageUrl: serviceTypeModel.imageUrl,
              height: AppSize.h50,
              width: context.width * 0.2,
            ),
            const Gap(5),
            Text(
              serviceTypeModel.title,
              style: FontManager.getSemiBold(
                fontSize: AppSize.sp12,
                color: ColorResources.black75,
              ),
            )
          ],
        ),
      ),
    );
  }
}
