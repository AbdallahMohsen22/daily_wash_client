import 'package:on_express/core/cache/cache_manger.dart';
import 'package:on_express/core/constants/app_constants.dart';

class InitScreenPrefs {
  static int? intValue;

  static Future<int> getOnce() async {
    if (CacheManager.getInt(AppConstants.initScreen) == null) {
      intValue = 1;
    } else {
      intValue = CacheManager.getInt(AppConstants.initScreen);
    }

    return intValue!;
  }

  static once(int num) async {
    await CacheManager.saveInt(AppConstants.initScreen, num);

    intValue = CacheManager.getInt(AppConstants.initScreen)!;
  }
}
