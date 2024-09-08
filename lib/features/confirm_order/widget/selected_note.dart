import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_feild.dart';

class SelectedNote extends StatefulWidget {
  const SelectedNote({super.key});

  @override
  State<SelectedNote> createState() => _SelectedNoteState();
}

class _SelectedNoteState extends State<SelectedNote> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController couponController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  final FocusNode couponFocusNode = FocusNode();
  final FocusNode notesFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    notesController.text =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
  }

  @override
  void dispose() {
    super.dispose();
    couponController.dispose();
    notesController.dispose();
    couponFocusNode.dispose();
    notesFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes'.tr(),
            style: FontManager.getSemiBold(
              fontSize: AppSize.sp16,
              color: ColorResources.black,
            ),
          ),
          const Gap(10),
          CustomField(
              filled: true,
              maxLines: 6,
              inputType: TextInputType.text,
              focusNode: notesFocusNode,
              hint: "write_your_notes".tr(),
              controller: notesController,
              validator: (valeu) {
                return null;
              }),
        ],
      ),
    );
  }
}
