import 'package:easy_localization/easy_localization.dart';

class FormValidation {
  static String? userNameFormValidation(String? value) {
    if (value!.isEmpty) {
      return "userName_is_required".tr();
    }
    return null;
  }

  static String? phoneNumberValidation(String? value) {
    if (value!.isEmpty) {
      return "phone_number_required".tr();
    }
    if(!value.startsWith('05')){
      return "phone_number_invalid".tr();
    }
    return null;
  }
  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? nationalIdValidation(String? value) {
    if (value!.isEmpty) {
      return "national_is_required".tr();
    }
    return null;
  }

  static String? validation(String? value) {
    if (value!.isEmpty) {
      return "field_is_required".tr();
    }
    return null;
  }

  static String? validateFormEmail(String? email) {
    if (email!.isEmpty) {
      return "email_is_requires".tr();
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
      return "email_is_requires".tr();
    }
    return null;
  }
}
