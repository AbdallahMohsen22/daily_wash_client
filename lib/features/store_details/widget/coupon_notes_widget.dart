import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_feild.dart';

import '../../../cubits/app_cubit/app_cubit.dart';
import '../../../cubits/app_cubit/app_states.dart';

class CouponAndNotes extends StatefulWidget {
  CouponAndNotes({super.key});

  TextEditingController notesController = TextEditingController();
  TextEditingController couponController = TextEditingController();


  @override
  State<CouponAndNotes> createState() => _CouponAndNotesState();
}

class _CouponAndNotesState extends State<CouponAndNotes> {
  GlobalKey<FormState> formKey = GlobalKey();
  final FocusNode couponFocusNode = FocusNode();
  final FocusNode notesFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'have_coupon'.tr(),
                  style: FontManager.getMediumStyle(
                    fontSize: AppSize.sp16,
                    color: ColorResources.kFormTitleColor,
                  ),
                ),
                const Gap(10),
                ConditionalBuilder(
                  condition: AppCubit.get(context).couponModel ==null,
                  fallback: (c)=>Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${'your_coupon_code_is'.tr()} ${widget.couponController.text}'
                        ),
                      ),
                      TextButton(
                          onPressed: (){
                            AppCubit.get(context).couponModel = null;
                            widget.couponController.text = '';
                            AppCubit.get(context).emitState();
                          },
                          child: Text('remove'.tr()),
                      )
                    ],
                  ),
                  builder: (c)=> CustomField(
                      filled: true,
                      inputType: TextInputType.text,
                      focusNode: couponFocusNode,
                      nextFocus: notesFocusNode,
                      hint: "enter_discount_coupon".tr(),
                      controller: widget.couponController,
                      suffix: Align(
                        widthFactor: 1.5,
                        heightFactor: 1.0,
                        child: ConditionalBuilder(
                          condition: state is! GetCouponLoadingState,
                          fallback: (c)=>CupertinoActivityIndicator(),
                          builder: (c)=> InkWell(
                            onTap: (){
                              if(widget.couponController.text.isNotEmpty){
                                AppCubit.get(context).getCoupon(context, widget.couponController.text.trim());
                              }
                            },
                            child: Text(
                              "Apply".tr(),
                              style: FontManager.getMediumStyle(
                                fontSize: AppSize.sp16,
                                color: ColorResources.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      validator: (valeu) {
                        return null;
                      }),
                ),
                const Gap(20),
                Text(
                  'add_your_notes'.tr(),
                  style: FontManager.getMediumStyle(
                    fontSize: AppSize.sp16,
                    color: ColorResources.kFormTitleColor,
                  ),
                ),
                const Gap(10),
                CustomField(
                    filled: true,
                    maxLines: 6,
                    inputType: TextInputType.text,
                    focusNode: notesFocusNode,
                    hint: "write_your_notes".tr(),
                    controller: widget.notesController,
                    validator: (valeu) {
                      return null;
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
