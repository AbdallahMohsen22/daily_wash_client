import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:on_express/core/cache/cache_manger.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/constants/app_constants.dart';
import 'package:on_express/core/network/remote/dio.dart';
import 'package:on_express/core/network/remote/end_point.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/core/widget/verification_phone_dialogs.dart';
import 'package:on_express/features/otp/otp_page.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../config/routes/app_route.dart';
import '../../../features/bottom_navigation_bar/navigation_page.dart';
import '../app_cubit/app_cubit.dart';
import '../menu_cubit/menu_cubit.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {

  AuthCubit():super(AuthInitState());
  static AuthCubit get(context)=>BlocProvider.of(context);


  void emitState()=>emit(EmitState());

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
  }

  void createUser({
    required String phone,
    String? name,
   // String? buildingName,
   // String? floorNumber,
   // String? apartmentNumber,
    String? distinguishedLandmark,
    bool fromLogin = true,
    bool fromRegister = false,
    bool fromDialog = false,
    required BuildContext context,
  }){

    FormData formData = FormData.fromMap({
      "phone_number":phone,
      if(name!=null)"name":name,
     // if(buildingName!=null)"address_information[building_name]":buildingName,
     // if(floorNumber!=null)"address_information[floor_number]":floorNumber,
     // if(apartmentNumber!=null)"address_information[apartment_number]":apartmentNumber,
      if(distinguishedLandmark!=null)"address_information[distinguished_landmark]":distinguishedLandmark,
      "firebase_token":fcmToken??'fcm',
    });
    emit(CreateUserLoadingState());
    print(phone);
    DioHelper.postData2(
      url: EndPoints.createUser,
      formData:formData
    ).then((value) {
      if(value.data['data']!=null){
        userId = value.data['data']['user_id'];
        code = value.data['data']['code'];
        UIAlert.showAlert(context,message: '${'code_is'.tr()} $code');
        emit(CreateUserSuccessState());
        if(!fromDialog) navigateTo(context, OtpPage(fromLogin: fromLogin,
          fromRegister: fromRegister,));
        if(fromDialog) {
          Navigator.pop(context);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => VerificationDialog());
        }
      }else{
        UIAlert.showAlert(context,message: value.data['message']??'wrong'.tr());
        emit(CreateUserWrongState());
      }
    }).catchError((e){
      emit(CreateUserErrorState());
    });
  }

  void verifyUser({
    required BuildContext context,
    bool fromLogin = true,
    bool fromRegister = false,
    bool fromDialog = false,
  }){
    emit(VerifyUserLoadingState());
    DioHelper.postData(
        url: EndPoints.verifyUser,
        data: {
          "user_id":userId,
          "code":code,
        }
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null){
        token = value.data['data']['token'];
        CacheManager.saveString('token', token);
        CacheManager.saveString('userId', userId);
        UIAlert.showAlert(context,message:  value.data['message']);
        if(AppCubit.get(context).adsModel!=null){
          AppCubit.get(context).init(context);
          MenuCubit.get(context).init();
        }
        emit(VerifyUserSuccessState());
        if(fromDialog){
          Navigator.pop(context);
        }else{
          if(fromLogin){
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.navigationPage,(route) => false,);
          }else{
            if(fromRegister)Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }
      }else{
        UIAlert.showAlert(context,message: value.data['message']??'wrong'.tr());
        emit(VerifyUserWrongState());
      }
    }).catchError((e){
      print(e.toString());
      emit(VerifyUserErrorState());
    });
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }


  UserCredential? userCredential;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void socialLog(BuildContext context,{bool fromLogin = true,bool fromRegister = false}){
    emit(SocialLoadingState());
    print(userCredential!.user!.email);
    print(userCredential!.user!.phoneNumber);
    print(userCredential!.credential!.providerId);
    print(context);
    DioHelper.postData(
        url:EndPoints.socialLog,
        data: {
          'email':userCredential!.user!.email??'',
          'name':userCredential!.user!.displayName??'',
          'social_id':userCredential!.credential!.providerId,
        }
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null){
        token = value.data['data']['token'];
        CacheManager.saveString('token',token);
        emit(SocialSuccessState());
        if(AppCubit.get(context).adsModel!=null){
          AppCubit.get(context).init(context);
          MenuCubit.get(context).init();
        }
        if(fromLogin){
           navigateAndFinish(context, NavigationPage());
        }else{
          if(fromRegister)Navigator.pop(context);
          Navigator.pop(context);
        }
      }else{
        UIAlert.showAlert(context,message: value.data['message']??'wrong'.tr());
        emit(SocialWrongState());
      }
    }).catchError((e){
      print(e.toString());
      UIAlert.showAlert(context,message: 'wrong'.tr());
      emit(SocialErrorState());
    });
  }
}