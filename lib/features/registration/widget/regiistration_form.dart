import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/form_validation.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/custom_feild.dart';
import 'package:on_express/core/widget/form_title.dart';

import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../../cubits/auth_cubit/auth_states.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm({required this.states,this.fromLogin = true});

  bool fromLogin;
  AuthStates states;

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController password = TextEditingController();
 // TextEditingController buildingNameController = TextEditingController();
 // TextEditingController floorNumberController = TextEditingController();
 // TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController distinguishedLandmarkController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
 // final FocusNode buildingNameFocusNode = FocusNode();
 // final FocusNode floorNumberFocusNode = FocusNode();
 // final FocusNode apartmentNumberFocusNode = FocusNode();
  final FocusNode distinguishedLandmarkFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    password.dispose();
   // buildingNameController.dispose();
   // buildingNameFocusNode.dispose();
   // floorNumberController.dispose();
   // floorNumberFocusNode.dispose();
   // apartmentNumberController.dispose();
   // apartmentNumberFocusNode.dispose();
    distinguishedLandmarkController.dispose();
    distinguishedLandmarkFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormTitle(title: 'full_name'.tr()),
          const Gap(10),
          CustomField(
              filled: true,
              inputType: TextInputType.text,
              focusNode: nameFocusNode,
              nextFocus: phoneFocusNode,
              hint: "enter_full_name".tr(),
              controller: nameController,
              //validator: FormValidation.userNameFormValidation
          ),
          const Gap(15),
          FormTitle(title: 'phone_number'.tr()),

          const Gap(10),
          CustomField(
            filled: true,
            inputType: TextInputType.text,
            focusNode: phoneFocusNode,
            nextFocus: distinguishedLandmarkFocusNode,
            formatter: [
              FilteringTextInputFormatter.digitsOnly
            ],
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
            hint: 'phone_number'.tr(),
            controller: phoneController,
            validator: FormValidation.phoneNumberValidation,
          ),
          const Gap(15),
          FormTitle(title: 'password'.tr()),
          CustomField(
            isPassword: true,
            filled: true,
            inputType: TextInputType.visiblePassword,
            focusNode: passwordFocusNode,

            // formatter: [
            //   FilteringTextInputFormatter.digitsOnly
            // ],
            hint: 'password'.tr(),
            controller: password,
            validator: FormValidation.passwordValidator,
          ),
          // FormTitle(title: 'building_name'.tr()),
          // const Gap(10),
          // CustomField(
          //     filled: true,
          //     inputType: TextInputType.text,
          //     focusNode: buildingNameFocusNode,
          //     nextFocus: floorNumberFocusNode,
          //     hint: "enter_building_name".tr(),
          //     controller: buildingNameController,
          // ),
          // const Gap(15),
          // FormTitle(title: 'floor_number'.tr()),
          // const Gap(10),
          // CustomField(
          //     filled: true,
          //     inputType: TextInputType.text,
          //     focusNode: floorNumberFocusNode,
          //     nextFocus: apartmentNumberFocusNode,
          //     hint: "enter_floor_number".tr(),
          //     controller: floorNumberController,
          // ),
          // const Gap(15),
          // FormTitle(title: 'apartment_number'.tr()),
          // const Gap(10),
          // CustomField(
          //     filled: true,
          //     inputType: TextInputType.text,
          //     focusNode: apartmentNumberFocusNode,
          //     nextFocus: buildingNameFocusNode,
          //     hint: "enter_apartment_number".tr(),
          //     controller: apartmentNumberController,
          // ),
          const Gap(15),
          FormTitle(title: 'distinguished_landmark'.tr()),
          const Gap(10),
          CustomField(
              filled: true,
              inputType: TextInputType.text,
              focusNode: distinguishedLandmarkFocusNode,
              hint: "enter_distinguished_landmark".tr(),
              controller: distinguishedLandmarkController,
          ),
          const Gap(30),
          Align(
            alignment: Alignment.center,
            child: ConditionalBuilder(
              condition: widget.states is! CreateUserLoadingState,
              fallback: (context)=>const CupertinoActivityIndicator(),
              builder: (context)=> CustomButton(
                  title: "register_now".tr(),
                  onTap: () {
                    if(formKey.currentState!.validate()){
                      AuthCubit.get(context).createUser(
                          phone: phoneController.text.trim(),
                          name: nameController.text.isNotEmpty?nameController.text:null,
                         //buildingName: buildingNameController.text.isNotEmpty?buildingNameController.text:null,
                         //floorNumber: floorNumberController.text.isNotEmpty?floorNumberController.text:null,
                         //apartmentNumber: apartmentNumberController.text.isNotEmpty?apartmentNumberController.text:null,
                          distinguishedLandmark: distinguishedLandmarkController.text.isNotEmpty?distinguishedLandmarkController.text:null,
                          context: context,
                        fromLogin: widget.fromLogin,
                        fromRegister: true
                      );
                    }
                  },
                  isSelected: true),
            ),
          )
        ],
      ),
    );
  }
}
