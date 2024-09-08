import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_feild.dart';

class TrackNotes extends StatefulWidget {
  TrackNotes({super.key,required this.note});

  String note;

  @override
  State<TrackNotes> createState() => _TrackNotesState();
}

class _TrackNotesState extends State<TrackNotes> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController notesController = TextEditingController();

  final FocusNode notesFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    notesController.text =
        widget.note;
  }

  @override
  void dispose() {
    super.dispose();

    notesController.dispose();

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
