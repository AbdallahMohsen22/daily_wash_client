import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';

class DateItem extends StatelessWidget {
  DateItem({
    super.key,
    required this.isSelected,
    required this.index,
    required this.onTap,
    required this.isCurrentMonth,
  });

  final bool isSelected;
  final int index;
  final VoidCallback onTap;
  final bool isCurrentMonth;
  int finalCurrentDay = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    //print(DateTime.now().hour);
    String dayName = DateFormat('EEE','en').format(DateTime(DateTime.now().year,DateTime.now().month,index+1));
    String month = DateFormat('MMM','en').format(DateTime(DateTime.now().year,DateTime.now().month));
    return GestureDetector(
      onTap: index < finalCurrentDay &&isCurrentMonth?null:onTap,
      child: Container(
        width: AppSize.w60,
        margin: EdgeInsets.symmetric(horizontal: AppSize.w10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:index < finalCurrentDay&&isCurrentMonth?Colors.grey: isSelected
              ? ColorResources.primaryColor
              : ColorResources.primaryColor.withOpacity(0.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dayName,
              softWrap: true,
              style: FontManager.getMediumStyle(
                fontSize: AppSize.sp12,
                color:
                index < finalCurrentDay&&isCurrentMonth?Colors.white: isSelected ? ColorResources.white : ColorResources.black75,
              ),
            ),
            Text(
              "$index",
              softWrap: true,
              style: FontManager.getMediumStyle(
                fontSize: AppSize.sp18,
                color: index < finalCurrentDay&&isCurrentMonth?Colors.white:isSelected
                    ? ColorResources.white
                    : ColorResources.primaryColor,
              ),
            ),
            Text(
              month,
              softWrap: true,
              style: FontManager.getMediumStyle(
                fontSize: AppSize.sp14,
                color: index < finalCurrentDay&&isCurrentMonth?Colors.white:isSelected ? ColorResources.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeItem extends StatelessWidget {
  const TimeItem({
    super.key,
    required this.isSelected,
    required this.time,
    required this.onTap,
  });

  final bool isSelected;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(
            vertical: AppSize.h10,
          ),
          width: context.width * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? ColorResources.primaryColor
                : ColorResources.primaryColor.withOpacity(0.3),
          ),
          child: Center(
            child: Text(
              time,
              softWrap: true,
              style: FontManager.getMediumStyle(
                fontSize: isSelected ? AppSize.sp16 : AppSize.sp14,
                color:
                    isSelected ? ColorResources.white : ColorResources.black75,
              ),
            ),
          )),
    );
  }
}
