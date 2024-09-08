import 'package:on_express/core/cache/cache_manger.dart';
import 'package:on_express/core/constants/app_constants.dart';

class LanguagePrefs {
  static void saveLanguageCode(String value) {
    CacheManager.saveString(AppConstants.languageCode, value);
  }

  static void saveCountryCode(String value) {
    CacheManager.saveString(AppConstants.countryCode, value);
  }

  static String? getLanguageCode() {
    return CacheManager.getString(AppConstants.languageCode);
  }
}
