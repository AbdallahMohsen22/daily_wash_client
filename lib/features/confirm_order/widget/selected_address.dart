import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/features/addresses/widget/address_item.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';

import '../../../cubits/menu_cubit/menu_cubit.dart';

class SelectedAddress extends StatelessWidget {
  const SelectedAddress({super.key, required this.storeDetailsViewModel});
  final StoreDetailsViewModel storeDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "address".tr(),
          style: FontManager.getSemiBold(
            fontSize: AppSize.sp16,
            color: ColorResources.black,
          ),
        ),
        const Gap(5),
        AddressItem(
            addressModel: MenuCubit.get(context).addressesModel!.data![0],
            isSelected: true,
            isEdit: true,
            isDefualt: true
        ),
      ],
    );
  }
}
