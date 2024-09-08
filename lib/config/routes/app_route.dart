import 'package:flutter/material.dart';
import 'package:on_express/features/about_us/about_us.dart';
import 'package:on_express/features/addresses/adresses_page.dart';
import 'package:on_express/features/bottom_navigation_bar/navigation_page.dart';
import 'package:on_express/features/confirm_order/confirm_order_page.dart';
import 'package:on_express/features/edit_profile.dart/edit_profile_page.dart';
import 'package:on_express/features/favourites/Favorites_page.dart';
import 'package:on_express/features/login/login_page.dart';
import 'package:on_express/features/notifications/notification_page.dart';
import 'package:on_express/features/onboarding/omboarding_page.dart';
import 'package:on_express/features/otp/otp_page.dart';
import 'package:on_express/features/registration/registration_page.dart';
import 'package:on_express/features/settings/settings_page.dart';
import 'package:on_express/features/splash/splash_page.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';
import 'package:on_express/features/terms_conditions/terms_conditions.dart';

class AppRoutes {
  // All app routes
  static const String splashPage = "splashPage";
  static const String navigationPage = "NavigationPage";
  static const String editProfilePage = "EditProfilePage";
  static const String favoritesPage = "FavoritesPage";
  static const String settingsPage = "SettingsPage";
  static const String addressPage = "AddressPage";
  static const String aboutUsPage = "AboutUsPage";
  static const String termsAndConditionsPage = "TermsAndConditionsPage";
  static const String notificationPage = "NotificationPage";
  static const String onboardingPage = "onboardingPage";
  static const String loginPage = "LoginPages";
  static const String otpPage = "OtpPage";
  static const String registrationPage = "RegistrationPage";
  static const String confirmOrder = "ConfirmOrder";
  static const String trackOrderPage = "TrackOrderPage";
  static const String trackMapPage = "TrackMapPage";

  static Route<dynamic> appRoutes(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splashPage:
        return appPage(const SplashPage());
      case onboardingPage:
        return appPage(const OnboardingPage());
      case loginPage:
        return appPage(LoginPage());
      case otpPage:
        return appPage(OtpPage());

      case navigationPage:
        return appPage(const NavigationPage());
      case editProfilePage:
        return appPage(EditProfilePage());
      case favoritesPage:
        return appPage(const FavoritesPage());
      case settingsPage:
        return appPage(const SettingsPage());
      case addressPage:
        return appPage(const AddressPage());
      case registrationPage:
        return appPage(RegistrationPage());
      case aboutUsPage:
        return appPage(const AboutUsPage());
      case notificationPage:
        return appPage(const NotificationPage());
      case confirmOrder:
        return appPage(ConfirmOrder(
          storeDetailsViewModel: args as StoreDetailsViewModel,
        ));
      case termsAndConditionsPage:
        return appPage(const TermsAndConditionsPage());

      default:
        return appPage(const SplashPage());
    }
  }

  static PageRouteBuilder appPage(Widget page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.fastOutSlowIn;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }
    );
  }
}
