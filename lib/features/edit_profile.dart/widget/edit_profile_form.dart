import 'dart:io';
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

import '../../../cubits/menu_cubit/menu_cubit.dart';
import '../../../cubits/menu_cubit/menu_states.dart';

class EditProfileForm extends StatefulWidget {
  EditProfileForm({this.image,required this.menuStates});

  File? image;
  MenuStates menuStates;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
 // TextEditingController buildingNameController = TextEditingController();
 // TextEditingController floorNumberController = TextEditingController();
 // TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController distinguishedLandmarkController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  //final FocusNode buildingNameFocusNode = FocusNode();
  //final FocusNode floorNumberFocusNode = FocusNode();
  //final FocusNode apartmentNumberFocusNode = FocusNode();
  final FocusNode distinguishedLandmarkFocusNode = FocusNode();

  @override
  void initState() {
    if(MenuCubit.get(context).userModel != null){
      nameController.text =MenuCubit.get(context).userModel?.data?.name??'';
      phoneController.text =MenuCubit.get(context).userModel?.data?.phoneNumber??'';
     // buildingNameController.text =MenuCubit.get(context).userModel?.data?.addressInformation?.building_name??'';
     // floorNumberController.text =MenuCubit.get(context).userModel?.data?.addressInformation?.floor_number??'';
     // apartmentNumberController.text =MenuCubit.get(context).userModel?.data?.addressInformation?.apartment_number??'';
      distinguishedLandmarkController.text =MenuCubit.get(context).userModel?.data?.addressInformation?.distinguished_landmark??'';
      setState(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    //buildingNameController.dispose();
    //buildingNameFocusNode.dispose();
    //floorNumberController.dispose();
    //floorNumberFocusNode.dispose();
    //apartmentNumberController.dispose();
    //apartmentNumberFocusNode.dispose();
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
             // validator: FormValidation.userNameFormValidation
          ),
          const Gap(15),
          FormTitle(title: 'phone_number'.tr()),
          const Gap(10),
          CustomField(
            filled: true,
            inputType: TextInputType.number,
            focusNode: phoneFocusNode,
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
            controller: phoneController,
            validator: FormValidation.phoneNumberValidation,
          ),
          const Gap(15),
          // FormTitle(title: 'building_name'.tr()),
          // const Gap(10),
          // CustomField(
          //   filled: true,
          //   inputType: TextInputType.text,
          //   focusNode: buildingNameFocusNode,
          //   nextFocus: floorNumberFocusNode,
          //   hint: "enter_building_name".tr(),
          //   controller: buildingNameController,
          // ),
          // const Gap(15),
          // FormTitle(title: 'floor_number'.tr()),
          // const Gap(10),
          // CustomField(
          //   filled: true,
          //   inputType: TextInputType.text,
          //   focusNode: floorNumberFocusNode,
          //   nextFocus: apartmentNumberFocusNode,
          //   hint: "enter_floor_number".tr(),
          //   controller: floorNumberController,
          // ),
          // const Gap(15),
          // FormTitle(title: 'apartment_number'.tr()),
          // const Gap(10),
          // CustomField(
          //   filled: true,
          //   inputType: TextInputType.text,
          //   focusNode: apartmentNumberFocusNode,
          //   nextFocus: buildingNameFocusNode,
          //   hint: "enter_apartment_number".tr(),
          //   controller: apartmentNumberController,
          // ),
          // const Gap(15),
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
              condition: widget.menuStates is! UpdateUserLoadingState,
              fallback: (context)=>CupertinoActivityIndicator(),
              builder: (context)=> CustomButton(
                title: "save_changes".tr(),
                onTap: () {
                  if(formKey.currentState!.validate()){
                    MenuCubit.get(context).updateUser(
                        context: context,
                        phone: phoneController.text.trim(),
                      name: nameController.text.isNotEmpty?nameController.text:null,
                     // buildingName: buildingNameController.text.isNotEmpty?buildingNameController.text:null,
                     // floorNumber: floorNumberController.text.isNotEmpty?floorNumberController.text:null,
                     // apartmentNumber: apartmentNumberController.text.isNotEmpty?apartmentNumberController.text:null,
                      distinguishedLandmark: distinguishedLandmarkController.text.isNotEmpty?distinguishedLandmarkController.text:null,
                    );
                  }
                },
                isSelected: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
