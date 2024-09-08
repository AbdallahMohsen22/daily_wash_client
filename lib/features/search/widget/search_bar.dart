import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/search/search_view_model.dart';
import 'package:on_express/features/search/widget/filter_widget.dart';

import '../../../cubits/app_cubit/app_cubit.dart';

// ignore: must_be_immutable
class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});
  SearchViewModel searchViewModel = SearchViewModel();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'search_with_name'.tr(),
            style: FontManager.getBoldStyle(
                fontSize: AppSize.sp18, color: ColorResources.black30),
            children: <InlineSpan>[
              const WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: SizedBox(
                  width: 8,
                ),
              ),
              TextSpan(
                text: 'store'.tr(),
                style: FontManager.getBoldStyle(
                  fontSize: AppSize.sp18,
                  color: ColorResources.primaryColor,
                ),
              ),
            ],
          ),
        ),
        const Gap(15),
        Row(
          children: [
            Expanded(
              child: Container(
                height: AppSize.h56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSize.w20,
                      vertical: AppSize.h8,
                    ),
                    filled: true,
                    fillColor: ColorResources.kFilterColor,
                    hintText: "search_here".tr(),
                    hintStyle: FontManager.getMediumStyle(
                      fontSize: AppSize.sp16,
                      color: ColorResources.lightGrey,
                    ),
                    prefixIcon: UnconstrainedBox(
                      child: CustomAssetImage(
                        imageUrl: ImageResources.fieldSearch,
                        height: AppSize.h25,
                        width: AppSize.w25,
                      ),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                  controller: AppCubit.get(context).searchController,
                  onChanged: (String? val){
                    AppCubit.get(context).getProviders();
                  },
                ),
              ),
            ),
            const Gap(15),
            GestureDetector(
              onTap: () {
                UIAlert.showFilterDialog(context,
                    child: FilterWidget(searchViewModel: searchViewModel),
                    filter: searchViewModel);
              },
              child: Container(
                height: AppSize.h56,
                width: AppSize.w56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorResources.primaryColor,
                ),
                child: Center(
                  child: CustomAssetImage(
                    imageUrl: ImageResources.filter,
                    height: AppSize.h26,
                    width: AppSize.w25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
