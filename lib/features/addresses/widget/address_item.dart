import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/features/addresses/add_address_page.dart';
import 'package:on_express/core/widget/selected_widget.dart';
import 'package:on_express/models/addresses_model.dart';

import '../../../cubits/menu_cubit/menu_cubit.dart';

// ignore: must_be_immutable
class AddressItem extends StatelessWidget {
  AddressItem({
    super.key,
    required this.addressModel,
    required this.isSelected,
    this.isEdit,
    this.isDefualt,
  });

  final AddressesData addressModel;
  final bool isSelected;
  bool? isEdit;
  bool? isDefualt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.height * 0.15,
      padding: EdgeInsets.all(AppSize.h12),
      margin: EdgeInsets.symmetric(vertical: AppSize.h15),
      decoration: BoxDecoration(
        color: ColorResources.lightGrey4.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: ColorResources.lightGrey3,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                addressModel.title?.tr()??'',
                style: FontManager.getSemiBold(
                  fontSize: AppSize.sp20,
                  color: ColorResources.black,
                ),
              ),
              Row(
                children: [
                  isDefualt == null
                      ? Text(
                          "default_address".tr(),
                          style: FontManager.getRegularStyle(
                            fontSize: AppSize.sp10,
                            color: ColorResources.black45,
                          ),
                        )
                      : const SizedBox(),
                  const Gap(5),
                  InkWell(
                    onTap: (){
                      MenuCubit.get(context).setDefaultAddresses(addressModel.id??'');
                    },
                      child: SelectedWidget(isSelected: isSelected))
                ],
              ),
            ],
          ),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LocationWidget(addressModel: addressModel),
              isEdit == null
                  ? InkWell(
                onTap: (){
                  navigateTo(context, AddNewAddressPage(data: addressModel));
                },
                    child: CustomAssetImage(
                        imageUrl: ImageResources.edit2,
                        height: AppSize.h26,
                        width: AppSize.w25,
                      ),
                  )
                  : const SizedBox()
            ],
          ),
          Wrap(
            spacing: 7,
            children: [
              if(addressModel.addressInformation?.buildingName!=null)
              addressTypeText('${'building_name'.tr()}:${addressModel.addressInformation?.buildingName}'),
              if(addressModel.addressInformation?.floorNumber!=null)
                addressTypeText('${'floor_number'.tr()}:${addressModel.addressInformation?.floorNumber}'),
              if(addressModel.addressInformation?.apartmentNumber!=null)
                addressTypeText('${addressModel.title == 'apartment'?'apartment_number'.tr():addressModel.title == 'house'?'house_number'.tr():'office_number'.tr()}:${addressModel.addressInformation?.apartmentNumber}'),
              if(addressModel.addressInformation?.distinguishedLandmark!=null)
                addressTypeText('${'notes'.tr()}:${addressModel.addressInformation?.distinguishedLandmark}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget addressTypeText(String text){
    return AutoSizeText(text,maxLines: 1,maxFontSize: 14,style: TextStyle(fontSize: 10),);
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    required this.addressModel,
  });

  final AddressesData addressModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomAssetImage(
          imageUrl: ImageResources.location,
          height: AppSize.h20,
          color: ColorResources.kYellowColor,
          width: AppSize.w20,
        ),
        const Gap(3),
        Text(
          '26985 Brighton..',
          style: FontManager.getMediumStyle(
            fontSize: AppSize.sp14,
            color: ColorResources.primaryColor,
          ),
        )
      ],
    );
  }
}
