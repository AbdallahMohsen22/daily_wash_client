import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/features/store_details/widget/date_time_items.dart';

class TrackDateAndTimeWidget extends StatefulWidget {
  TrackDateAndTimeWidget({super.key,required this.date, this.orderedReceivingDate});

  final String date;
  String? orderedReceivingDate;

  @override
  State<TrackDateAndTimeWidget> createState() => _DateAndTimeWidgetState();
}

class _DateAndTimeWidgetState extends State<TrackDateAndTimeWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "date_and_time".tr(),
          style: FontManager.getBoldStyle(
            fontSize: AppSize.sp18,
            color: ColorResources.kFormTitleColor,
          ),
        ),
        const Gap(15),
        Text(
          widget.date,
          softWrap: true,
          style: FontManager.getMediumStyle(
            fontSize: AppSize.sp16,
            color: ColorResources.black75,
          ),
        ),
        if(widget.orderedReceivingDate!=null)
          const Gap(15),
        if(widget.orderedReceivingDate!=null)
        Text(
          "ordered_receiving_date".tr(),
          style: FontManager.getBoldStyle(
            fontSize: AppSize.sp18,
            color: ColorResources.kFormTitleColor,
          ),
        ),
        if(widget.orderedReceivingDate!=null)
          const Gap(15),
        if(widget.orderedReceivingDate!=null)
          Text(
            widget.orderedReceivingDate!,
          softWrap: true,
          style: FontManager.getMediumStyle(
            fontSize: AppSize.sp16,
            color: ColorResources.black75,
          ),
        ),
      ],
    );
  }
}
