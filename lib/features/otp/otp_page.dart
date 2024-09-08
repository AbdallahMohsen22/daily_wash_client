import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/auth_logo.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/features/otp/widget/otp_pin_fields.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatelessWidget {
  OtpPage({this.fromLogin = true,this.fromRegister = false});
  bool fromLogin;
  bool fromRegister;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      child: InkWell(
        onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              const OtpBackButton(),
              const Gap(10),
              const AuthLogo(),
              const Gap(15),
              Text(
                "verification".tr(),
                style: FontManager.getMediumStyle(
                  fontSize: AppSize.sp30,
                  color: ColorResources.black,
                ),
              ),
              const Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [PinCodeFields(fromLogin: fromLogin,fromRegister: fromRegister,)],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OtpBackButton extends StatelessWidget {
  const OtpBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Consumer<LanguageProvider>(
        builder: (_, language, __) => Icon(
          language.appLanguage == "en"
              ? Icons.arrow_back_ios_new
              : Icons.arrow_forward_ios,
          color: ColorResources.kArrowBackColor,
          size: 24,
        ),
      ),
    );
  }
}
