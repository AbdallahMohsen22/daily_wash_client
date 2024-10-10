import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/auth_logo.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/features/login/widget/have_account.dart';
import 'package:on_express/features/login/widget/login_form.dart';
import 'package:on_express/features/login/widget/social_buttons.dart';
import '../../core/componets/componets.dart';
import '../../core/constants/app_constants.dart';
import '../../cubits/auth_cubit/auth_cubit.dart';
import '../../cubits/auth_cubit/auth_states.dart';
import '../registration/registration_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({this.fromLogin = true});

  TextEditingController phoneController = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  bool fromLogin;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);
      },
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
                  "sign_in".tr(),
                  style: FontManager.getMediumStyle(
                    fontSize: AppSize.sp30,
                    color: ColorResources.black,
                  ),
                ),
                const Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoginForm(phoneController: phoneController,formKey: formKey,password: password,),
                    const Gap(30),
                    ConditionalBuilder(
                      condition: state is! CreateUserLoadingState,
                      fallback: (context) =>
                          Center(child: CupertinoActivityIndicator(),),
                      builder: (context) => CustomButton(
                          title: "sign_in".tr(),
                          onTap: () {
                            if(formKey.currentState!.validate()){
                              AuthCubit.get(context).createUser(
                                phone:phoneController.text.trim(),
                                context: context,
                                fromLogin: fromLogin
                              );
                            }
                          },
                          isSelected: true),
                    ),
                    const Gap(15),
                    HaveAccount(
                      isRegister: false,
                      onTap: () {
                        navigateTo(context, RegistrationPage(fromLogin: fromLogin,));
                      },
                    ),
                    const Gap(30),
                    ConditionalBuilder(
                        condition: state is! SocialLoadingState,
                        fallback: (context) =>
                            Center(child: CupertinoActivityIndicator(),),
                        builder: (context) => SocialButtons(context,fromLogin: fromLogin,))
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
