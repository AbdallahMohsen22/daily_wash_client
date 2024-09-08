import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_express/core/cache/cache_language.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _appLocale = const Locale("en");
  String _appLanguage = "en";

  // return the appLocale, if not supported make "en" by default
  Locale get appLocale {
    fetchLocale();
    return _appLocale;
  }

  String get appLanguage => _appLanguage;

  bool get isArabicAppLanguage => _appLanguage == 'en';

  fetchLocale() async {
    if (LanguagePrefs.getLanguageCode() == null) {
      _appLocale = const Locale('en');
      return null;
    }

    _appLocale = Locale(LanguagePrefs.getLanguageCode()!);
    _appLanguage = LanguagePrefs.getLanguageCode()!;

    Future.microtask(() {
      notifyListeners();
    });
  }

  Future<void> changeLanguage(Locale type, BuildContext context) async {
    if (type == const Locale('ar')) {
      _appLocale = const Locale('ar');
      _appLanguage = "ar";
      LanguagePrefs.saveLanguageCode('ar');
      LanguagePrefs.saveCountryCode('EG');
    } else {
      _appLocale = const Locale('en');
      _appLanguage = "en";
      LanguagePrefs.saveLanguageCode('en');
      LanguagePrefs.saveCountryCode('US');
    }
    if (context.mounted) {
      context.setLocale(_appLocale);
    }

    notifyListeners();
  }
}
