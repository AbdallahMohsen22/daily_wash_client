import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';

import '../../../cubits/app_cubit/app_cubit.dart';


class FilterModel{
  String title;
  int? status;
  FilterModel({required this.title,this.status});
}

class RequestStatus extends StatefulWidget {
  const RequestStatus({
    super.key,
  });

  @override
  State<RequestStatus> createState() => _QoustionItemState();
}

class _QoustionItemState extends State<RequestStatus> {
  double _height = AppSize.h50;
  bool _isExpanded = false;

  List<FilterModel> filters = [
    FilterModel(title: 'all'.tr()),
    FilterModel(title: 'new'.tr(), status: 1),
    FilterModel(title: 'assigned_to_delivery'.tr(), status: 2),
    FilterModel(title: 'Received'.tr(), status: 3),
    FilterModel(title: 'delivered_to_laundry'.tr(), status: 4),
    FilterModel(title: 'finished'.tr(), status: 5),
  ];

  Future<bool> _showList() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return InkWell(
      onTap: () {
        if (!_isExpanded) {
          setState(() {
            _height = context.height * 0.25;
            _isExpanded = true;
          });
        } else {
          setState(() {
            _height = AppSize.h50;
            _isExpanded = false;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: context.width * 0.5,
        height: _height,
        margin: EdgeInsets.only(bottom: AppSize.h30),
        padding: EdgeInsets.symmetric(horizontal: AppSize.w15),
        decoration: BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.circular(AppSize.h15),
          border: Border.all(color: ColorResources.primaryColor, width: 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cubit.filter?.title ?? 'filter'.tr(),
                      style: FontManager.getSemiBold(
                        fontSize: AppSize.sp16,
                        color: ColorResources.black,
                      ),
                    ),
                    !_isExpanded
                        ? Icon(
                            Icons.arrow_drop_down,
                            color: ColorResources.primaryColor,
                          )
                        : Icon(
                            Icons.arrow_drop_up,
                            color: ColorResources.primaryColor,
                          ),
                  ],
                ),
              ),
              _isExpanded
                  ? FutureBuilder(
                      future: _showList(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }
                        return ListView.separated(
                          padding: EdgeInsets.symmetric(vertical:AppSize.h10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (c,i)=>ConditionalBuilder(
                              condition: cubit.filter != filters[i],
                              fallback: (c)=>SizedBox(),
                              builder: (c)=> const Gap(3)),
                          itemCount: filters.length,
                          itemBuilder: (context, index) => ConditionalBuilder(
                            condition: cubit.filter != filters [index],
                            fallback: (c)=>SizedBox(),
                            builder: (c)=> GestureDetector(
                              onTap: () {
                                setState(() {
                                  cubit.filter = filters[index];
                                  _height = AppSize.h60;
                                  _isExpanded = false;
                                });
                                cubit.getOrders();
                              },
                              child: Text(
                                filters[index].title,
                                textAlign: TextAlign.start,
                                style: FontManager.getSemiBold(
                                  fontSize: AppSize.sp18,
                                  color: ColorResources.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
