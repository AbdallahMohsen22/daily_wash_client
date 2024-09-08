import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:on_express/core/cache/cache_manger.dart';
import 'package:on_express/core/network/remote/end_point.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/splash/splash_page.dart';
import '../../../models/addresses_model.dart';
import '../../../models/notification_model.dart';
import '../../../models/settings_model.dart';
import '../../../models/static_pages_model.dart';
import '../../../models/user_model.dart';
import '../../core/componets/componets.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/remote/dio.dart';
import '../../core/widget/verification_phone_dialogs.dart';
import 'menu_states.dart';

class MenuCubit extends Cubit<MenuStates>{

  MenuCubit ():super(MenuInitState());
  
  static MenuCubit get(context)=>BlocProvider.of(context);
  
  UserModel? userModel;

  AddressesModel? addressesModel;

  StaticPagesModel? staticPagesModel;

  SettingsModel? settingsModel;

  NotificationModel? notificationModel;

  ScrollController notificationScrollController = ScrollController();

  File? profileImage;


  void emitState()=>EmitState();

  void init(){
    checkInterNet();
    getSettings();
    getUser();
    getAddresses();
    getStaticPages();
    getNotification();
  }

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
  }

  void getUser(){
    DioHelper.getData(
      url: EndPoints.getUser,
      token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        userModel = UserModel.fromJson(value.data);
        emit(UserSuccessState());
        print('status ${userModel?.data?.status}');
      }
    }).catchError((e){
      emit(UserErrorState());
    });
  }
  
  
  void updateUser({
  required BuildContext context,
  required String phone,
    String? name,
   // String? buildingName,
   // String? floorNumber,
   // String? apartmentNumber,
    String? distinguishedLandmark,
    bool fromDialog = false,
})async{
    FormData formData = FormData.fromMap({
      "phone_number":phone,
      if(name!=null)"name":name,
     // if(buildingName!=null)"address_information[building_name]":buildingName,
     // if(floorNumber!=null)"address_information[floor_number]":floorNumber,
     // if(apartmentNumber!=null)"address_information[apartment_number]":apartmentNumber,
      if(distinguishedLandmark!=null)"address_information[distinguished_landmark]":distinguishedLandmark,
      "firebase_token":fcmToken??'fcm',
    });
    if(profileImage!=null){
      MultipartFile file = await  MultipartFile.fromFile(
          profileImage!.path,filename: profileImage!.path.split('/').last
      );
      formData.files.add(MapEntry('personal_photo', file));
    }
    emit(UpdateUserLoadingState());
    print(formData.files);
    DioHelper.putData2(
      url: EndPoints.updateUser,
      token: 'Bearer $token',
      formData:formData,
    ).then((value) {
      print(value.data);
      if(value.data['status'] == true){
        UIAlert.showAlert(context,message: value.data['message']);
        profileImage = null;
        getUser();
        Navigator.pop(context);
        if(fromDialog){
          showDialog(context: context,
              builder: (context)=>VerifyPhoneDialog(phone:phone));
        }
      }else{
        if(fromDialog)Navigator.pop(context);
        UIAlert.showAlert(context,message: value.data['message']??'wrong'.tr());
        emit(UpdateUserWrongState());
        if(value.data['message']!=null){
          if(value.data['message'].contains('User is not Verified yet')){
            showDialog(
                context: context,
                builder: (context)=>VerifyPhoneDialog(phone:phone)
            );
          }
        }
      }
    }).catchError((e){
      print(e.toString());
      emit(UpdateUserErrorState());
    });
  }


  void getAddresses(){
    emit(AddressLoadingState());
    DioHelper.getData(
        url: EndPoints.getAddresses,
        token: 'Bearer $token'
    ).then((value) {
      print(value.data);
      if(value.data['data']!=null){
        addressesModel = AddressesModel.fromJson(value.data);
        emit(AddressSuccessState());
      }else{
        emit(AddressWrongState());
      }
    }).catchError((e){
      emit(AddressErrorState());
    });
  }

  void setDefaultAddresses(String id){
    emit(AddressLoadingState());
    DioHelper.putData(
        url: '${EndPoints.setDefaultAddresses}$id',
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['status']==true){
        getAddresses();
      }
    }).catchError((e){
      emit(AddressErrorState());
    });
  }


  void updateAddress({
    required BuildContext context,
    required String id,
    required String title,
    required double latitude,
    required double longitude,
    String? buildingName,
    String? floorNumber,
    String? apartmentNumber,
    String? distinguishedLandmark,
  }){
    FormData formData = FormData.fromMap({
      "latitude":latitude,
      "longitude":longitude,
      "title":title,
      if(buildingName!=null)"address_information[building_name]":buildingName,
      if(floorNumber!=null)"address_information[floor_number]":floorNumber,
      if(apartmentNumber!=null)"address_information[apartment_number]":apartmentNumber,
      if(distinguishedLandmark!=null)"address_information[distinguished_landmark]":distinguishedLandmark,
    });
    emit(AddressLoadingState());
    DioHelper.putData2(
      url: '${EndPoints.updateAddress}$id',
      token: 'Bearer $token',
      formData: formData,
    ).then((value) {
      print(value.data);
      if(value.data['status'] == true){
        UIAlert.showAlert(context,message: value.data['message']);
        getAddresses();
        Navigator.pop(context);
      }else{
        UIAlert.showAlert(context,message: value.data['message']??'wrong'.tr());
        emit(AddressWrongState());
      }
    }).catchError((e){
      print(e.toString());
      emit(AddressErrorState());
    });
  }




  void addAddress({
    required BuildContext context,
    required String title,
    required double latitude,
    required double longitude,
    String? buildingName,
    String? floorNumber,
    String? apartmentNumber,
    String? distinguishedLandmark,
  }){

    FormData formData = FormData.fromMap({
      "latitude":latitude,
      "longitude":longitude,
      "title":title,
      if(buildingName!=null)"address_information[building_name]":buildingName,
      if(floorNumber!=null)"address_information[floor_number]":floorNumber,
      if(apartmentNumber!=null)"address_information[apartment_number]":apartmentNumber,
      if(distinguishedLandmark!=null)"address_information[distinguished_landmark]":distinguishedLandmark,
    });
    emit(AddressLoadingState());
    DioHelper.postData2(
      url: EndPoints.addAddress,
      token: 'Bearer $token',
      formData:formData,
    ).then((value) {
      print(value.data);
      if(value.data['status'] == true){
        UIAlert.showAlert(context,message: value.data['message']);
        getAddresses();
        Navigator.pop(context);
      }else{
        UIAlert.showAlert(context,message: value.data['message']??'wrong'.tr());
        emit(AddressWrongState());
      }
    }).catchError((e){
      print(e.toString());
      emit(AddressErrorState());
    });
  }

  void getStaticPages(){
    DioHelper.getData(
        url: EndPoints.getStaticPages,
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        staticPagesModel = StaticPagesModel.fromJson(value.data);
        emit(StaticPagesSuccessState());
      }
    }).catchError((e){
      emit(StaticPagesErrorState());
    });
  }

  void getSettings(){
    DioHelper.getData(
        url: EndPoints.getSettings,
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        settingsModel = SettingsModel.fromJson(value.data);
        emit(SettingsSuccessState());
      }
    }).catchError((e){
      emit(SettingsErrorState());
    });
  }

  void contactUs(BuildContext context,{
    required String subject,required String message}){
    emit(ContactUsLoadingState());
    DioHelper.postData(
        url: EndPoints.contactUs,
        token: 'Bearer $token',
        data:{
          'name':userModel?.data?.name??'Ahmed',
          'subject':subject,
          'message':message,
        }
    ).then((value) {
      if(value.data['status'] == true){
        UIAlert.showAlert(context,
          message: 'message_added'.tr(),
        );
        emit(ContactUsSuccessState());
        Navigator.pop(context);
      }else{
        UIAlert.showAlert(context,
          message: value.data['message'] ?? 'wrong'.tr(),
        );
        emit(ContactUsWrongState());
      }
    }).catchError((e){
      UIAlert.showAlert(context,
        message: e.toString(),
      );
      emit(ContactUsErrorState());
    });
  }


  void getNotification({int page = 1}){
    emit(GetNotificationLoadingState());
    DioHelper.getData(
        url:'${EndPoints.notification}$page',
        token: 'Bearer $token',lang: myLocale
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          notificationModel = NotificationModel.fromJson(value.data);
        }
        else{
          notificationModel!.data!.currentPage = value.data['data']['currentPage'];
          notificationModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            notificationModel!.data!.data!.add(NotificationData.fromJson(e));
          });
        }
        emit(GetNotificationSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        emit(GetNotificationWrongState());
      }
    }).catchError((e){
      print(e.toString());
      emit(GetNotificationErrorState());
    });
  }

  void paginationAllNotification(BuildContext context){
    notificationScrollController.addListener(() {
      if (notificationScrollController.offset == notificationScrollController.position.maxScrollExtent){
        if (notificationModel!.data!.currentPage != notificationModel!.data!.pages) {
          if(state is! GetNotificationLoadingState){
            int currentPage = notificationModel!.data!.currentPage! +1;
            getNotification(page: currentPage);
          }
        }
      }
    });
  }


  void deleteAccount(BuildContext context){
    emit(DeleteAccountLoadingState());
    DioHelper.deleteData(
        url: EndPoints.deleteUser,
        token: 'Bearer $token'
    ).then((value) {
      print(value.data);
      print(token);
      print(userId);
      if(value.data['status']==true){
        token = null;
        userId = null;
        CacheManager.remove('userId');
        CacheManager.remove('token');
        emit(DeleteAccountSuccessState());
        navigateAndFinish(context, SplashPage());
      }else{
        UIAlert.showAlert(context,
          message: value.data['message'] ?? 'wrong'.tr(),
        );
        emit(DeleteAccountWrongState());
      }
    }).catchError((e){
      UIAlert.showAlert(context,
        message: e.toString(),
      );
      emit(DeleteAccountErrorState());
    });
  }





}