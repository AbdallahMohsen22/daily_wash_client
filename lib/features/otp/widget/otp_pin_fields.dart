import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widget/ui.dart';
import '../../../cubits/auth_cubit/auth_cubit.dart';
import '../../../cubits/auth_cubit/auth_states.dart';

class PinCodeFields extends StatefulWidget {
  PinCodeFields({this.fromLogin = true,this.fromRegister = false,
    this.fromDialog = false});
  bool fromLogin;
  bool fromRegister;
  bool fromDialog;

  @override
  // ignore: library_private_types_in_public_api
  _PinCodeFieldsState createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  TextEditingController pinCodeController = TextEditingController();

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  String otpCode = '';
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;
  late Timer timer2;

  @override
  void initState() {
    super.initState();
    pinCodeController.text = code.toString();
    timer2 = Timer(const Duration(seconds: 2), () {
      AuthCubit.get(context).verifyUser(context: context,
          fromLogin: widget.fromLogin,
          fromRegister: widget.fromRegister,fromDialog: widget.fromDialog);
    });
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    timer2.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Column(
          children: <Widget>[
            Form(
              key: formKey,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.w20),
                  child: PinCodeTextField(
                    enablePinAutofill: true,
                    appContext: context,
                    hintCharacter: '*',
                    textStyle: FontManager.getMediumStyle(
                        fontSize: AppSize.sp16, color: ColorResources.black),
                    pastedTextStyle: FontManager.getMediumStyle(
                        fontSize: AppSize.sp16, color: ColorResources.white),
                    length: 4,
                    useExternalAutoFillGroup: true,
                    obscureText: true,
                    obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    animationCurve: Curves.bounceInOut,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      activeColor: ColorResources.kInputColor,
                      inactiveColor: ColorResources.lightGrey3,
                      selectedColor: ColorResources.kOrangeColor.withOpacity(
                          .5),
                      inactiveFillColor: ColorResources.white,
                      selectedFillColor:
                      ColorResources.kOrangeColor.withOpacity(.5),
                      borderWidth: 1.5,
                      borderRadius: BorderRadius.circular(12),
                      fieldHeight: AppSize.h67,
                      fieldWidth: AppSize.h67,
                      activeFillColor: ColorResources.kOrangeColor.withOpacity(
                          .5),
                    ),
                    autoFocus: true,
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: pinCodeController,
                    keyboardType: TextInputType.number,
                    onCompleted: (submitedCode) {
                      if (otpCode.length < 4) {
                        hasError = true;
                        setState(() {});
                      } else {
                        hasError = false;
                        setState(() {});
                        if(int.parse(otpCode) == code){
                          cubit.verifyUser(
                              context: context,
                              fromLogin: widget.fromLogin,
                              fromRegister: widget.fromRegister,
                              fromDialog: widget.fromDialog
                          );
                        }else{
                          UIAlert.showAlert(context,message: 'code_invalid'.tr(),type: MessageType.warning);
                        }
                      }
                    },
                    onChanged: (value) {
                      otpCode = value;
                    },
                    beforeTextPaste: (text) {
                      return true;
                    },
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.w15),
              child: Text(
                hasError ? "يجب ملئ جميع الحقول" : "",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: AppSize.sp16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    if(secondsRemaining == 0){
                      secondsRemaining = 60;
                      UIAlert.showAlert(context,message: '${'code_is'.tr()} $code');
                      setState(() {});
                    }
                  },
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  child: RichText(
                      text: TextSpan(
                          text: secondsRemaining == 0?'try_again'.tr():"$secondsRemaining:00",
                          style: FontManager.getMediumStyle(
                              fontSize: AppSize.sp16,
                              color: ColorResources.black))),
                ),
                const Gap(20),
                ConditionalBuilder(
                  condition: state is! VerifyUserLoadingState,
                  fallback: (context)=>const CupertinoActivityIndicator(),
                  builder: (context)=> CustomButton(
                    title: 'verify_number'.tr(),
                    isSelected: true,
                    onTap: () {
                      if (otpCode.length < 4) {
                        hasError = true;
                        setState(() {});
                      } else {
                        hasError = false;
                        setState(() {});
                        if(int.parse(otpCode) == code){
                          cubit.verifyUser(
                              context: context,
                              fromLogin: widget.fromLogin,
                              fromRegister: widget.fromRegister,
                              fromDialog: widget.fromDialog
                          );
                        }else{
                          UIAlert.showAlert(context,message: 'code_invalid'.tr(),type: MessageType.warning);
                        }
                      }

                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //   AppRoutes.navigationPage,
                      //       (route) => false,
                      // );
                    },
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
