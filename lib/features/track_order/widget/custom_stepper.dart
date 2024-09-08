import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/features/requests/widget/request_status.dart';

import '../../../cubits/app_cubit/app_cubit.dart';

class CustomSetpper extends StatelessWidget {
  CustomSetpper({super.key,required this.status});

  int status;

  @override
  Widget build(BuildContext context) {
    List<FilterModel> orderStatus = AppCubit.get(context).orderStatus;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stepperTitl(orderStatus[0].title),
            const Gap(42),
            stepperTitl(orderStatus[1].title),
            const Gap(42),
            stepperTitl(orderStatus[2].title),
            const Gap(42),
            stepperTitl(orderStatus[3].title),
            const Gap(42),
            stepperTitl(orderStatus[4].title),
            const Gap(42),
          ],
        ),
        Column(
          children: [
            StepItem(
              color: status == 1 ?Colors.blue:Colors.green,
            ),
            CustomSettperLine(
              color: status == 1 ?Colors.grey:null,
            ),
            StepItem(
              color: status == 2 ?Colors.blue:status == 1?Colors.grey:Colors.green,
            ),
            CustomSettperLine(color: status > 2?null:Colors.grey,),
            StepItem(
              color: status == 3 ?Colors.blue:status == 1||status == 2?Colors.grey:Colors.green,
            ),
            CustomSettperLine(color: status > 3?null:Colors.grey,),

            StepItem(
              color: status == 4 ?Colors.blue:status == 1||status == 2||status == 3?Colors.grey:Colors.green,
            ),
            CustomSettperLine(color: status > 4?null:Colors.grey,),
            StepItem(
              color: status == 5 ?Colors.blue:Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomSettperLine extends StatelessWidget {
  CustomSettperLine({super.key, this.color});
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1.5,
      color: color ?? Colors.green,
    );
  }
}

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      height: 25,
      width: 25,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: const Center(
        child: Icon(
          Icons.check,
          color: ColorResources.white,
          size: 14,
        ),
      ),
    );
  }
}

Widget stepperTitl(String title) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: AppSize.w20),
    child: Text(
      title.tr(),
      style: FontManager.getSemiBold(
        fontSize: AppSize.sp16,
        color: ColorResources.black,
      ),
    ),
  );
}
