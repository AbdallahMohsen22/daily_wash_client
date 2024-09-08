import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/selected_widget.dart';
import 'package:on_express/features/search/search_view_model.dart';

import '../../../cubits/app_cubit/app_cubit.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({
    super.key,
    required this.searchViewModel,
  });
  final SearchViewModel searchViewModel;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BlocBuilder<GenericCubit<List<bool>?>,
          GenericCubitState<List<bool>?>>(
        bloc: widget.searchViewModel.filterCubit,
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.h10,
              horizontal: AppSize.w25,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.h15),
                color: ColorResources.white),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.searchViewModel.filterItems.map(
                      (e) {
                        int index =
                            widget.searchViewModel.filterItems.indexOf(e);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e,
                              style: FontManager.getMediumStyle(
                                fontSize: AppSize.sp16,
                                color: ColorResources.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.searchViewModel.setFilterSelected(
                                    widget.searchViewModel.selected, index);
                              },
                              child: SelectedWidget(
                                isSelected: widget
                                    .searchViewModel.filterSelected[index],
                              ),
                            )
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
                const Gap(15),
                CustomButton(
                  title: 'done'.tr(),
                  isSelected: true,
                  onTap: () {
                    if(widget.searchViewModel.filterSelected[1]){
                      AppCubit.get(context).getProviders(rate:'h');
                    }else{
                      AppCubit.get(context).getProviders();
                    }
                    Navigator.pop(context);
                  },
                ),
                const Gap(15),
              ],
            ),
          );
        },
      ),
    );
  }
}
