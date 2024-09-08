import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/auth_logo.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/features/login/login_page.dart';
import 'package:on_express/features/login/widget/have_account.dart';
import 'package:on_express/features/login/widget/social_buttons.dart';
import 'package:on_express/features/registration/widget/regiistration_form.dart';

import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../cubits/auth_cubit/auth_states.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({this.fromLogin = true});

  bool fromLogin;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultScaffold(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                const AuthLogo(),
                const Gap(15),
                Text(
                  "register_now".tr(),
                  style: FontManager.getMediumStyle(
                    fontSize: AppSize.sp30,
                    color: ColorResources.black,
                  ),
                ),
                const Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(30),
                    RegistrationForm(states: state,),
                    const Gap(15),
                    HaveAccount(
                      isRegister: true,
                      onTap: () {
                        navigateTo(context, LoginPage(fromLogin: fromLogin));
                      },
                    ),
                    const Gap(30),
                    ConditionalBuilder(
                        condition: state is! SocialLoadingState,
                        fallback: (context)=>Center(child: CupertinoActivityIndicator(),),
                        builder: (context)=> SocialButtons(context,fromLogin: fromLogin,fromRegister: true,))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
