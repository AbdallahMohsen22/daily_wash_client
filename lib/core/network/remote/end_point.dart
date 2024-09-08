
import 'package:on_express/core/constants/app_constants.dart';

class EndPoints{
  static const String loginUser = 'user/logout';
  static const String createUser = 'user/create-user';
  static const String verifyUser = 'user/verify-user';
  static const String socialLog = 'user/social-login';
  static const String ads = 'advertisement/all-advertisments';
  static const String getUser = 'user/single-user';
  static const String updateUser = 'user/update-user';
  static const String getAddresses = 'address/all-address';
  static const String setDefaultAddresses = 'address//set-default-address/';
  static const String updateAddress = 'address/update-address/';
  static const String addAddress = 'address/add-address';
  static const String getStaticPages = 'static-pages/all';
  static const String getSettings = 'settings';
  static const String contactUs = 'contact-us/create-contact-us';
  static const String notification = 'notification/all-notifications?page=';
  static String deleteUser = 'user/delete-user-by-token';
  static const String getCoupon = 'coupouns/apply-coupoun';
  static const String createOrder = 'orders/create-order';
  static const String getProviders = 'provider/all-near-by-providers';
  static const String getOrders = 'orders/all-orders-with-status';
  static const String deleteOrder = 'orders/delete-order/';
  static const String changeFav = 'user/add-remove-provider-from-favorite';
  static const String getFav = 'user/all-favorited-providers?page=';
  static const String reviewLaundry = 'provider/add-review-to-provider';
  static const String singleProvider = 'provider/single-provider/';
}