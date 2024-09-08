import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/features/home/model/service_type_model.dart';
import 'package:on_express/features/home/widget/pic_service_type.dart';

// ignore: must_be_immutable
class TrackPickService extends StatelessWidget {
  TrackPickService({
    super.key,
    required this.serviceType
  });

  final int serviceType;
  List<ServiceTypeModel> serviceTypes = [
    ServiceTypeModel(
      title: "pickup".tr(),
      imageUrl: ImageResources.pickup,
    ),
    ServiceTypeModel(
      title: "delivery".tr(),
      imageUrl: ImageResources.delivery,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "selection_service".tr(),
            style: FontManager.getMediumStyle(
              fontSize: AppSize.sp14,
              color: ColorResources.black,
            ),
          ),
          const Gap(15),
          Center(
            child: ServiceItem(
              serviceTypeModel: serviceTypes[serviceType-1],
              onTap: () {},
              isSelected: true,
            ),
          ),
        ],
      ),
    );
  }
}
