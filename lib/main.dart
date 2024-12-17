import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:on_express/config/routes/app_route.dart';
import 'package:on_express/config/theme/app_theme.dart';
import 'package:on_express/core/cache/cache_manger.dart';
import 'package:on_express/core/network/remote/dio.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/features/splash/splash_page.dart';
import 'package:provider/provider.dart';
import 'core/bloc_observer/bloc_observer.dart';
import 'core/constants/app_constants.dart';
import 'core/firebase_helper/firebase_options.dart';
import 'core/firebase_helper/notification_helper.dart';
import 'cubits/app_cubit/app_cubit.dart';
import 'cubits/auth_cubit/auth_cubit.dart';
import 'cubits/menu_cubit/menu_cubit.dart';
import 'features/payment/api_keys.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );
    NotificationHelper();
    fcmToken = await FirebaseMessaging.instance.getToken();
    print("fcmToken====>>>>>$fcmToken");
  }catch(e){
    print(e.toString());
  }

  DioHelper.init();
  await EasyLocalization.ensureInitialized();
  await CacheManager.init();
  token = CacheManager.getString('token');
  print("token=====>>>>>>>$token");
  userId = CacheManager.getString('userId');

  //My puplishableKey for test mode
  Stripe.publishableKey = ApiKeys.puplishableKeyLive;
  Stripe.merchantIdentifier = 'merchant.com.DaliyWashUser.pavilion';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();



  String? loca = CacheManager.getString(AppConstants.languageCode);
  if(loca !=null){
    myLocale = loca;
  }else{
    Platform.localeName.contains('ar')
        ?myLocale = 'ar'
        :myLocale = 'en';
  }
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
    (_) =>   BlocOverrides.runZoned(
          () {
        runApp(
          EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('ar')],
            useOnlyLangCode: true,
            path: 'assets/translations',
            fallbackLocale: const Locale('en'),
            startLocale: Locale(myLocale),
            child: const MainApp(),
          ),
        );
      },
      blocObserver: MyBlocObserver(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => ChangeNotifierProvider(
        create: (_) => LanguageProvider(),
        builder: (_, i) => Consumer<LanguageProvider>(
          builder: (_, language, __) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context)=>AuthCubit()..checkInterNet()),
                BlocProvider(create: (context)=>AppCubit()..init(context)),
                BlocProvider(create: (context)=>MenuCubit()..init()),
              ],
              child: MaterialApp(
                theme: getApplicationTheme(),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: language.appLocale,
                onGenerateRoute: AppRoutes.appRoutes,
                home: const SplashPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
