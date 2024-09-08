import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/features/search/search_view_model.dart';
import 'package:toastification/toastification.dart';

import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/app_cubit/app_states.dart';
import 'custom_progress_indecator.dart';

class UIAlert {
  static Future<dynamic> buildCustomBottomSheet(BuildContext context,
      Widget child) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
      backgroundColor: ColorResources.white,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: context.height * 0.4,
          decoration: BoxDecoration(
            color: ColorResources.primaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
          ),
          child: child,
        );
      },
    );
  }

  static Future<dynamic> showCupertinoAlertDialog(BuildContext context,
      {required String id, required String title}) {
    return showDialog(
      context: context,
      builder: (context) =>
          BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return CupertinoAlertDialog(
                title: Text(
                  title.tr(),
                  style: FontManager.getSemiBold(
                    fontSize: AppSize.sp14,
                    color: ColorResources.black,
                  ),
                ),
                actions: <Widget>[
                  ConditionalBuilder(
                    condition: state is! DeleteOrderLoadingState,
                    fallback: (c)=>Center(child: CupertinoActivityIndicator(),),
                    builder: (c)=> CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: (){
                        AppCubit.get(context).deleteOrder(context: context, id: id);
                      },
                      child: Text(
                        "yes".tr(),
                        style: FontManager.getSemiBold(
                          fontSize: AppSize.sp14,
                          color: ColorResources.black,
                        ),
                      ),
                    ),
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      "cancel".tr(),
                      style: FontManager.getSemiBold(
                        fontSize: AppSize.sp14,
                        color: ColorResources.black,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              );
            },
          ),
    );
  }

  static Future<void> showAlert(context, {message, type}) async {
    Toastification().show(
      context: context,
      title: Text(message ?? ""),
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 5),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        )
      ],
      showProgressBar: true,
      backgroundColor: type == MessageType.error
          ? ColorResources.kErrorColor
          : type == MessageType.success
          ? Colors.green[200]
          : type == MessageType.warning
          ? Colors.amber
          : Colors.green[200],
    );
  }

  static void showFilterDialog(BuildContext context,
      {required Widget child, required SearchViewModel filter}) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return BlocBuilder<GenericCubit<List<bool>?>,
            GenericCubitState<List<bool>?>>(
          bloc: filter.filterCubit,
          builder: (context, state) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 300,
                margin: EdgeInsets.only(
                  left: AppSize.w20,
                  right: AppSize.w20,
                  bottom: context.height * 0.3,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: SizedBox.expand(child: child),
              ),
            );
          },
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  static Future<Object?> showMaterialPage(BuildContext context,
      {required Widget child}) {
    return showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.white,
            child: child,
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  static void showCustomDailog(BuildContext context, {required Widget child}) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: context.height * 0.6,
            margin: EdgeInsets.only(
              left: AppSize.w20,
              right: AppSize.w20,
              bottom: context.height * 0.2,
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: SizedBox.expand(child: child),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  static showNotificationToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showLoading(context){
    showDialog(context: context,barrierDismissible: false,
        builder: (context)=>CustomProgressDialog());
  }
}

enum MessageType { error, success, warning }
