import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/cubits/auth_cubit/auth_cubit.dart';
import 'package:on_express/cubits/auth_cubit/auth_states.dart';
import 'package:on_express/cubits/menu_cubit/menu_cubit.dart';
import '../../cubits/menu_cubit/menu_states.dart';
import '../../features/otp/widget/otp_pin_fields.dart';
import '../utils/color_resources.dart';
import '../utils/form_validation.dart';
import '../utils/image_resources.dart';
import 'custom_asset_image.dart';
import 'custom_feild.dart';
import 'form_title.dart';

class UpdatePhoneDialog extends StatefulWidget {
  UpdatePhoneDialog({super.key});

  @override
  State<UpdatePhoneDialog> createState() => _UpdatePhoneDialogState();
}

class _UpdatePhoneDialogState extends State<UpdatePhoneDialog> {
  TextEditingController phoneController = TextEditingController();

  // TextEditingController buildingNameController = TextEditingController();
  // TextEditingController floorNumberController = TextEditingController();
  // TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController distinguishedLandmarkController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Dialog(
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'required_add_phone'.tr(),
                    style: FontManager.getSemiBold(
                      color: ColorResources.black, fontSize: 16),
                ),
              ),
              const Gap(15),
              FormTitle(title: 'phone_number'.tr()),
              const Gap(10),
              CustomField(
                filled: true,
                inputType: TextInputType.number,
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
                //   hint: "enter_building_name".tr(),
                //   controller: buildingNameController,
                // ),
                // const Gap(15),
                // FormTitle(title: 'floor_number'.tr()),
                // const Gap(10),
                // CustomField(
                //   filled: true,
                //   inputType: TextInputType.text,
                //   hint: "enter_floor_number".tr(),
                //   controller: floorNumberController,
                // ),
                // const Gap(15),
                // FormTitle(title: 'apartment_number'.tr()),
                // const Gap(10),
                // CustomField(
                //   filled: true,
                //   inputType: TextInputType.text,
                //   hint: "enter_apartment_number".tr(),
                //   controller: apartmentNumberController,
                // ),
                // const Gap(15),
                FormTitle(title: 'distinguished_landmark'.tr()),
                const Gap(10),
                CustomField(
                  filled: true,
                  inputType: TextInputType.text,
                  hint: "enter_distinguished_landmark".tr(),
                  controller: distinguishedLandmarkController,
                ),
              const Gap(15),
              Center(
                child: ConditionalBuilder(
                  condition: state is! UpdateUserLoadingState,
                  fallback: (c)=>CupertinoActivityIndicator(),
                  builder: (c)=> CustomButton(
                    title: 'add_phone'.tr(),
                    onTap: () {
                      if(phoneController.text.isNotEmpty){
                        MenuCubit.get(context).updateUser(
                            context: context,
                            phone: phoneController.text,
                           // buildingName: buildingNameController.text.isNotEmpty?buildingNameController.text:null,
                           // floorNumber: floorNumberController.text.isNotEmpty?floorNumberController.text:null,
                           // apartmentNumber: apartmentNumberController.text.isNotEmpty?apartmentNumberController.text:null,
                            distinguishedLandmark: distinguishedLandmarkController.text.isNotEmpty?distinguishedLandmarkController.text:null,
                            fromDialog: true
                        );
                      }
                    },
                    isSelected: true,
                  ),
                ),
              )
              ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class VerifyPhoneDialog extends StatefulWidget {
  VerifyPhoneDialog({this.phone = ''});

  String phone;



  @override
  State<VerifyPhoneDialog> createState() => _VerifyPhoneDialogState();
}

class _VerifyPhoneDialogState extends State<VerifyPhoneDialog> {
  TextEditingController phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneController.text = widget.phone;
    AuthCubit.get(context).emitState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Dialog(
          surfaceTintColor: Colors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'verify_phone'.tr(),
                      style: FontManager.getSemiBold(
                          color: ColorResources.black, fontSize: 16),
                    ),
                  ),
                  const Gap(15),
                  FormTitle(title: 'phone_number'.tr()),
                  const Gap(10),
                  CustomField(
                    filled: true,
                    inputType: TextInputType.number,
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
                          Icon(Icons.arrow_drop_down,
                              color: ColorResources.lightGrey3),
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
                  Center(
                    child: ConditionalBuilder(
                      condition: state is! CreateUserLoadingState,
                      fallback: (c)=>CupertinoActivityIndicator(),
                      builder: (c)=> CustomButton(
                        title: 'verify'.tr(),
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            AuthCubit.get(context).createUser(
                                context: context,
                                phone: phoneController.text,
                                fromDialog: true
                            );
                          }
                        },
                        isSelected: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


class VerificationDialog extends StatelessWidget {
  VerificationDialog({super.key});


  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'verification'.tr(),
                style: FontManager.getSemiBold(
                    color: ColorResources.black, fontSize: 16),
              ),
            ),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [PinCodeFields(
                fromDialog: true,
              )],
            ),
          ],
        ),
      ),
    );
  }
}

