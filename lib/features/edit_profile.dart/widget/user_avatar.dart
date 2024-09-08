import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/image_net.dart';
import '../../../core/utils/font_manager.dart';
import '../../../cubits/menu_cubit/menu_cubit.dart';
import '../../../cubits/menu_cubit/menu_states.dart';

class EditUserAvatar extends StatefulWidget {
  EditUserAvatar({super.key});



  @override
  State<EditUserAvatar> createState() => _EditUserAvatarState();
}

class _EditUserAvatarState extends State<EditUserAvatar> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.h75),
                child: ConditionalBuilder(
                  condition: MenuCubit.get(context).profileImage==null,
                  fallback:(c)=>Image.file(
                      MenuCubit.get(context).profileImage!,
                    height: AppSize.h150,
                    width: AppSize.w150,
                    fit: BoxFit.cover,
                  ),
                  builder:(c)=> ImageNet(
                    fit: BoxFit.cover,
                    image: MenuCubit.get(context).userModel?.data?.personalPhoto??'',
                    height: AppSize.h150,
                    width: AppSize.w150,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: -4,
                child: InkWell(
                  onTap: ()=>_handleAttachmentPressed(context),
                  child: Container(
                    height: AppSize.h40,
                    width: AppSize.w40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.white,
                    ),
                    child: Center(
                      child: CustomAssetImage(
                        imageUrl: ImageResources.camera,
                        fit: BoxFit.cover,
                        height: AppSize.h25,
                        width: AppSize.w25,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _handleImageSelection(ImageSource source,BuildContext context) async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: source,
    );

    if (result != null) {
      MenuCubit.get(context).profileImage = File(result.path);
      setState(() {});
      //MenuCubit.get(context).emitState();
      //Navigator.pop(context);
    }
  }

  void _handleAttachmentPressed(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return SafeArea(
        child: Container(
          color: ColorResources.white,
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  _handleImageSelection(ImageSource.gallery,context);
                  //Navigator.pop(context);
                },
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Gallery',
                    style: bottomSheetTextStyle(),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _handleImageSelection(ImageSource.camera,context);
                 // Navigator.pop(context);
                },
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Camera',
                    style: bottomSheetTextStyle(),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Cancel',
                    style: bottomSheetTextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  },
),
    );
  }

  TextStyle bottomSheetTextStyle() {
    return FontManager.getBoldStyle(
      fontSize: AppSize.sp16,
      color: ColorResources.black,
    );
  }
}
