import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_button.dart';

import '../../../cubits/auth_cubit/auth_cubit.dart';

class SocialButtons extends StatelessWidget {
  SocialButtons(this.context,{this.fromLogin = true,this.fromRegister = false});

  BuildContext context;

  bool fromLogin;
  bool fromRegister;

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // CustomButton(
        //     title: "sign_with_google".tr(),
        //     socialIcon: ImageResources.google,
        //     onTap: () async{
        //       cubit.userCredential = await cubit.signInWithGoogle();
        //       if(cubit.userCredential!=null){
        //         cubit.socialLog(this.context,fromLogin: fromLogin,fromRegister: fromRegister);
        //       }
        //     },
        //     isSelected: false),
        const Gap(15),
        if(defaultTargetPlatform == TargetPlatform.iOS)
        CustomButton(
            title: "sign_with_apple".tr(),
            socialIcon: ImageResources.apple,
            onTap: () async{
              cubit.userCredential = await cubit.signInWithApple();
              if(cubit.userCredential!=null){
                cubit.socialLog(this.context,fromLogin: fromLogin,fromRegister: fromRegister);
              }
            },
            isSelected: false),
      ],
    );
  }
}
