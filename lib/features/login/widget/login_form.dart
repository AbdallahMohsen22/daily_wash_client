import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/color_resources.dart';
import '../../../core/utils/form_validation.dart';
import '../../../core/utils/image_resources.dart';
import '../../../core/widget/custom_asset_image.dart';
import '../../../core/widget/custom_feild.dart';
import '../../../core/widget/form_title.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    required this.phoneController,required this.formKey,required this.password
  });

  TextEditingController phoneController;
  TextEditingController password;
  GlobalKey<FormState> formKey;


  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {


  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode password = FocusNode();
  @override
  void dispose() {
    super.dispose();

    widget.phoneController.dispose();
    widget.password.dispose();
    phoneFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormTitle(title: 'phone_number'.tr()),
          const Gap(10),
          CustomField(
            filled: true,
            inputType: TextInputType.emailAddress,
            focusNode: phoneFocusNode,
            nextFocus: password,
            prefix: Align(
              widthFactor: 1.5,
              heightFactor: 1.0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAssetImage(
                    imageUrl: ImageResources.flag,
                    height: 34.h,
                    width: 34.w,
                  ),
                  Icon(Icons.arrow_drop_down, color: ColorResources.lightGrey3),
                  Container(
                    height: 30.h,
                    width: 2.w,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            formatter: [
              FilteringTextInputFormatter.digitsOnly
            ],
            hint: 'phone_number'.tr(),
            controller: widget.phoneController,
            validator: FormValidation.phoneNumberValidation,
          ),

          const Gap(10),
          FormTitle(title: 'password'.tr()),
          const Gap(10),
          CustomField(
            isPassword: true,
            filled: true,
            inputType: TextInputType.visiblePassword,
            focusNode: password,

            // formatter: [
            //   FilteringTextInputFormatter.digitsOnly
            // ],
            hint: 'password'.tr(),
            controller: widget.password,
            validator: FormValidation.passwordValidator,
          ),
        ],
      ),
    );
  }
}
