import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/form_validation.dart';

import '../../../core/widget/custom_button.dart';
import '../../../core/widget/custom_feild.dart';
import '../../../core/widget/form_title.dart';

class ApartmentDialog extends StatefulWidget {
  ApartmentDialog({super.key});

  TextEditingController buildingNameController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  State<ApartmentDialog> createState() => _ApartmentDialogState();
}

class _ApartmentDialogState extends State<ApartmentDialog> {



  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Form(
          key: formKey,
          child: InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormTitle(title: 'building_name'.tr()),
                  const Gap(10),
                  CustomField(
                    filled: true,
                    inputType: TextInputType.text,
                    hint: "enter_building_name".tr(),
                    controller: widget.buildingNameController,
                    validator: FormValidation.validation,
                  ),
                  const Gap(15),
                  FormTitle(title: 'floor_number'.tr()),
                  const Gap(10),
                  CustomField(
                    filled: true,
                    inputType: TextInputType.text,
                    hint: "enter_floor_number".tr(),
                    controller: widget.floorNumberController,
                    validator: FormValidation.validation,
                  ),
                  const Gap(15),
                  FormTitle(title: 'apartment_number'.tr()),
                  const Gap(10),
                  CustomField(
                    filled: true,
                    inputType: TextInputType.text,
                    hint: "enter_apartment_number".tr(),
                    controller: widget.apartmentNumberController,
                    validator: FormValidation.validation,
                  ),
                  const Gap(15),
                  FormTitle(title: 'notes'.tr()),
                  const Gap(10),
                  CustomField(
                    filled: true,
                    inputType: TextInputType.text,
                    hint: "enter_notes".tr(),
                    controller: widget.notesController,
                    validator: FormValidation.validation,
                  ),
                  const Gap(15),
                  Center(
                    child: CustomButton(
                      title: 'save'.tr(),
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          Navigator.pop(context);
                        }
                      },
                      isSelected: true,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}