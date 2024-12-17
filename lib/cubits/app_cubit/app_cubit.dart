import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/network/remote/dio.dart';
import 'package:on_express/core/network/remote/end_point.dart';
import 'package:on_express/features/requests/widget/request_status.dart';
import 'package:on_express/features/store_details/store_details_page.dart';
import 'package:on_express/models/single_provider_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../features/wrong_screens/update.dart';
import '../../../models/ads_model.dart';
import '../../../models/coupon_model.dart';
import '../../../models/directions_model.dart';
import '../../../models/orders_model.dart';
import '../../../models/providers_model.dart';
import '../../core/constants/app_constants.dart';
import '../../core/location_helper/directions.dart';
import '../../core/widget/ui.dart';
import '../../features/contect_us/contactus_screen.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);

  ADSModel? adsModel;

  ProvidersModel? providersModel;

  ProvidersPaginationModel? favProvidersModel;

  OrdersModel? ordersModel;

  SingleProviderModel? singleProviderModel;

  ScrollController ordersScrollerController = ScrollController();

  ScrollController providersScrollerController = ScrollController();

  ScrollController favProvidersScrollerController = ScrollController();

  TextEditingController searchController = TextEditingController();

  Position? position;

  LatLng? orderLatLng;

  int currentAddressIndex = -1;

  CouponModel? couponModel;

  FilterModel? filter;

  Directions? directions;

  Marker? origin;

  Marker? distance;

  Map<String, bool> favorites = {};

  List<FilterModel> orderStatus = [
    FilterModel(title: 'new', status: 1),
    FilterModel(title: 'assigned_to_delivery', status: 2),
    FilterModel(title: 'Received', status: 3),
    FilterModel(title: 'delivered_to_laundry', status: 4),
    FilterModel(title: 'finished', status: 5),
  ];

  void emitState() => emit(EmitState());

  void init(BuildContext context) {
    checkInterNet();
    getAds();
    getCurrentLocation(context);
    getProviders();
    getOrders();
    getFavProviders();
  }

  void updateApp(context) async {
    final newVersion = await NewVersionPlus().getVersionStatus();
    if (await checkUpdates()) {
      if (newVersion != null) {
        if (newVersion.appStoreLink.isNotEmpty)
          navigateAndFinish(
              context,
              Update(
                  url: newVersion.appStoreLink,
                  releaseNote: newVersion.releaseNotes ?? tr('update_desc')));
      }
    }
  }

  Future<bool> checkUpdates() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.ensureInitialized();
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetchAndActivate();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    bool haveVersion = false;
    final json = remoteConfig.getString('app_version2');
    Map<String, dynamic> jsonDecod = jsonDecode(json);
    final version = jsonDecod['version'];
    final local = packageInfo.version.split('.').map(int.parse).toList();
    final store = version.split('.').map(int.parse).toList();
    for (var i = 0; i < store.length; i++) {
      if (store[i] > local[i]) haveVersion = true;
      if (local[i] > store[i]) haveVersion = false;
    }
    return haveVersion;
  }

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
  }

  void takeFav(List<ProviderData> providers) {
    for (var provider in providers) {
      favorites.addAll({provider.id!: provider.isFavorited!});
    }
  }

  TextEditingController addressController = TextEditingController();

  void chooseMyCurrentLocation(BuildContext context) async {
    currentAddressIndex = -1;
    if (position != null) {
      orderLatLng = LatLng(position!.latitude, position!.longitude);
      getAddress(orderLatLng!);
    } else {
      await getCurrentLocation(context);
      if (position != null) {
        orderLatLng = LatLng(position!.latitude, position!.longitude);
        getAddress(orderLatLng!);
      }
    }
    emitState();
  }

  void getAddress(LatLng latLng) async {
    String location;
    List<Placemark> place = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: 'en');
    Placemark placeMark = place[0];
    location = placeMark.street ?? '';
    location += ', ${placeMark.country ?? ''}';
    addressController.text = location;
    emitState();
  }

  void chooseAddress(int index, LatLng latLng) {
    addressController.text = '';
    orderLatLng = latLng;
    currentAddressIndex = index;
    emitState();
  }

  void getAds() {
    DioHelper.getData(
      url: EndPoints.ads,
    ).then((value) {
      if (value.data['data'] != null) {
        adsModel = ADSModel.fromJson(value.data);
        emit(AdsSuccessState());
      }
    }).catchError((e) {
      emit(AdsErrorState());
    });
  }

  void getSingleProvider(BuildContext context,{required String id}) {
    UIAlert.showLoading(context);
    DioHelper.getData(
      url: '${EndPoints.singleProvider}$id',
    ).then((value) {
      Navigator.pop(context);
      if (value.data['data'] != null) {
        singleProviderModel = SingleProviderModel.fromJson(value.data);
        emit(SingleProviderSuccessState());
        navigateTo(context,
            StoreDetailsPage(
              provider: singleProviderModel?.data??ProviderData(),));
      }
    }).catchError((e) {
      emit(SingleProviderErrorState());
      Navigator.pop(context);
    });
  }


  void tapOnAd(BuildContext context,{required ImageAdvertisements ad}){
    if(ad.type ==2)
      openUrl(ad.link??'', context);
    if(ad.type ==3)
      context.read<AppCubit>().getSingleProvider(
          context,
          id: ad.link??'');
  }

  Future<Position> checkPermissions(BuildContext context) async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {}
    if (permission == LocationPermission.denied) {
      print('permission = denied with request');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('permission = denied');
        UIAlert.showAlert(context, message: 'location_permission'.tr());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('permission = deniedForever');
      UIAlert.showAlert(context, message: 'location_permission'.tr());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    emit(LocationLoadingState());
    await checkPermissions(context);
    await Geolocator.getLastKnownPosition().then((value) {
      if (value != null) {
        position = value;
        emit(LocationSuccessState());
        getProviders();
      }
    });
  }

  void getProviders({
    int page = 1,
    String? rate,
  }) {
    emit(GetProvidersLoadingState());
    DioHelper.getData(
      url: EndPoints.getProviders,
      query: {
        "page": page,
        // "limit": 200,
        if (searchController.text.isNotEmpty) "name": searchController.text,
        // if (rate != null) "rate": 'highest',
        if (position != null) "current_latitude": position?.latitude,
        if (position != null) "current_longitude": position?.longitude,
        // if (position == null) "current_latitude": '3.07796442',
        // if (position == null) "current_longitude": '101.5865449',
      },
      token: 'Bearer $token',
    ).then((value) {
      print(value.data);
      if (value.data['status'] == true && value.data['data'] != null) {
        if (value.statusCode == 200) {
          print("Api status message====>>>>${value.statusMessage}");
          print("Api status code========>>>>${value.data}");
          print("Api Get Providers========>>>>>>>>>>${providersModel!.data}");
          print("Api Get Providers========>>>>>>>>>>${providersModel!.status}");
          print("Api Get Providers========>>>>>>>>>>${providersModel!.message}");
          providersModel = ProvidersModel.fromJson(value.data);
          takeFav(providersModel!.data!);
          // if(page == 1) {
          //
          // }
          // else{
          //   providersModel!.currentPage = value.data['data']['currentPage'];
          //   providersModel!.data!.pages = value.data['data']['pages'];
          //   value.data['data']['data'].forEach((e){
          //     providersModel!.data!.data!.add(ProviderData.fromJson(e));
          //   });
          //   takeFav(providersModel!.data!.data!);
          // }
          emit(GetProvidersSuccessState());
        }
      } else {
        // emit(GetProvidersWrongState());
        print("Error 400== >>");
        emit(GetProvidersErrorState());
      }
    }).catchError((e) {
      print("Error parsing data: ${e.toString()}");
      emit(GetProvidersErrorState());
    });
  }

  // void getProviders({
  //   int page = 1,
  //   String? rate,
  // }) {
  //   emit(GetProvidersLoadingState());
  //   DioHelper.getData(
  //     url: EndPoints.getProviders,
  //     query: {
  //       "page": page,
  //       if (searchController.text.isNotEmpty) "name": searchController.text,
  //       if (position != null) "current_latitude": position?.latitude,
  //       if (position != null) "current_longitude": position?.longitude,
  //     },
  //     token: 'Bearer $token',
  //   ).then((value) {
  //     print(value.data); // Inspect the response data
  //     if (value.data != null) {
  //       if (value.statusCode == 200) {
  //         print("Api status message====>>>>${value.statusMessage}");
  //         print("Api status code========>>>>${value.data}");
  //
  //         // Handle the response assuming it is a list
  //         try {
  //           // Assuming the response is a list of provider objects
  //           List<dynamic> providersList = value.data;
  //
  //           // Loop through each provider and process them
  //           providersList.forEach((providerData) {
  //             // You can now handle each provider object
  //             print("Provider Data: $providerData");
  //
  //             // Parse the individual provider data
  //             var provider = ProvidersModel.fromJson(providerData);
  //             print("Parsed Provider: ${provider.message}");
  //
  //             // If necessary, handle any nested fields (e.g., pricingItems)
  //             List pricingItems = providerData['pricingItems'] ?? [];
  //             pricingItems.forEach((item) {
  //               int price = int.tryParse(item['price'].toString()) ?? 0; // Ensure it's an int
  //               print("Item price: $price");
  //             });
  //           });
  //
  //           // Emit success state after processing
  //           emit(GetProvidersSuccessState());
  //         } catch (e, stackTrace) {
  //           print("Error parsing fields: ${e.toString()}");
  //           print("Stack trace: $stackTrace"); // This prints the stack trace
  //           emit(GetProvidersErrorState());
  //         }
  //       } else {
  //         print("Error: ${value.statusMessage}");
  //         emit(GetProvidersErrorState());
  //       }
  //     } else {
  //       print("Error 400: No data found");
  //       emit(GetProvidersErrorState());
  //     }
  //   }).catchError((e, stackTrace) {
  //     print("Error parsing data: ${e.toString()}");
  //     print("Stack trace: $stackTrace"); // This prints the stack trace
  //     emit(GetProvidersErrorState());
  //   });
  // }

  // void paginationProviders(BuildContext context){
  //   providersScrollerController.addListener(() {
  //     if (providersScrollerController.offset == providersScrollerController.position.maxScrollExtent){
  //       if (providersModel!.data!.currentPage != providersModel!.data!.pages) {
  //         if(state is! GetProvidersLoadingState){
  //           int currentPage = providersModel!.data!.currentPage! +1;
  //           getProviders(page: currentPage);
  //         }
  //       }
  //     }
  //   });
  // }

  void getCoupon(BuildContext context, String code) {
    emit(GetCouponLoadingState());
    DioHelper.postData(
        url: EndPoints.getCoupon,
        token: 'Bearer $token',
        data: {"code": code}).then((value) {
      print(value.data);
      if (value.data['data'] != null) {
        bool isApplied = value.data['data']['is_applied'];
        if (isApplied) {
          couponModel = CouponModel.fromJson(value.data);
        } else {
          UIAlert.showAlert(context,
              message: 'Sorry This Coupon is\'nt applied');
        }
        emit(GetCouponSuccessState());
      } else {
        UIAlert.showAlert(context,
            message: value.data['message'] ?? 'wrong'.tr());
        emit(GetCouponWrongState());
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetCouponErrorState());
    });
  }

  void createOrder({
    required BuildContext context,
    required String orderDate,
    required String paymentMethod,
    required String providerId,
    required int serviceType,
    required String vehicleType,
    String? additionalNotes,
    String? couponCode,
  }) {
    emit(CreateOrderLoadingState());
    DioHelper.postData2(
        url: EndPoints.createOrder,
        token: 'Bearer $token',
        formData: FormData.fromMap({
          "ordered_date": orderDate, //orderDate,
          if (additionalNotes != null) "additional_notes": additionalNotes,
          if (couponCode != null) "coupoun_code": couponCode,
          "payment_method": paymentMethod,
          "service_type": serviceType,
          "vehicle_type": vehicleType,
          "user_latitude": orderLatLng!.latitude,
          "user_longitude": orderLatLng!.longitude,
          "provider_id": providerId,
        })).then((value) {
      if (value.data['data'] != null && value.data['status'] == true) {
        UIAlert.showAlert(context, message: value.data['message']);
        emit(CreateOrderSuccessState());

        Navigator.pop(context);
      } else {
        UIAlert.showAlert(context,
            message: value.data['message'] ?? 'wrong'.tr());
        emit(CreateOrderWrongState());
      }
    }).catchError((e) {
      print(e.toString());
      UIAlert.showAlert(context, message: 'wrong'.tr());

      emit(CreateOrderErrorState());
    });
  }

  void getOrders({int page = 1}) {
    emit(GetOrdersLoadingState());
    DioHelper.getData(
      url: EndPoints.getOrders,
      query: {
        'page': page,
        if (filter?.status != null) 'status': filter?.status,
      },
      token: 'Bearer $token',
    ).then((value) {
      if (value.data['status'] == true && value.data['data'] != null) {
        if (page == 1) {
          ordersModel = OrdersModel.fromJson(value.data);
        } else {
          ordersModel!.data!.currentPage = value.data['data']['currentPage'];
          ordersModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e) {
            ordersModel!.data!.data!.add(OrderData.fromJson(e));
          });
        }
        emit(GetOrdersSuccessState());
      } else if (value.data['status'] == false && value.data['data'] != null) {
        emit(GetOrdersWrongState());
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetOrdersErrorState());
    });
  }

  void paginationOrders(BuildContext context) {
    ordersScrollerController.addListener(() {
      if (ordersScrollerController.offset ==
          ordersScrollerController.position.maxScrollExtent) {
        if (ordersModel!.data!.currentPage != ordersModel!.data!.pages) {
          if (state is! GetOrdersLoadingState) {
            int currentPage = ordersModel!.data!.currentPage! + 1;
            getOrders(page: currentPage);
          }
        }
      }
    });
  }

  void deleteOrder({
    required BuildContext context,
    required String id,
  }) {
    emit(DeleteOrderLoadingState());
    DioHelper.deleteData(
      url: '${EndPoints.deleteOrder}$id',
      token: 'Bearer $token',
    ).then((value) {
      print(value.data);
      if (value.data['status'] == true) {
        UIAlert.showAlert(context, message: value.data['message']);
        getOrders();
        Navigator.pop(context);
      } else {
        UIAlert.showAlert(context,
            message: value.data['message'] ?? 'wrong'.tr());
        emit(DeleteOrderWrongState());
      }
    }).catchError((e) {
      print(e.toString());
      emit(DeleteOrderErrorState());
    });
  }

  Future<void> getDirection({
    required LatLng originLatLng,
    required LatLng destinationLatLng,
  }) async {
    origin = Marker(
        position: position != null
            ? LatLng(position!.latitude, position!.longitude)
            : LatLng(25.1995140, 55.2773970),
        markerId: MarkerId('origin'),
        icon: await BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure));
    distance = Marker(
        position: destinationLatLng,
        markerId: MarkerId('destination'),
        icon: await BitmapDescriptor.defaultMarkerWithHue(20));
    await DirectionsRepository()
        .getDirections(
            origin: originLatLng,
            destination: destinationLatLng,
            mode: 'driving')
        .then((value) {
      if (value != null) {
        directions = value;
        emit(LocationSuccessState());
      }
    }).catchError((e) {
      print(e.toString());
      // showToast(msg: e.toString(),toastState: false);
    });
  }

  String favLoadingId = '';

  void changeFav(BuildContext context, String id) {
    favLoadingId = id;
    favorites[id] = !favorites[id]!;
    emit(ChangeFavLoadingState());
    DioHelper.postData(
        url: EndPoints.changeFav,
        token: 'Bearer $token',
        data: {'favorited_provider': id}).then((value) {
      print(value.data);
      if (value.data['status'] == true) {
        favLoadingId = '';
        getFavProviders();
        UIAlert.showAlert(context, message: value.data['message']);
      } else {
        favLoadingId = '';
        favorites[id] = !favorites[id]!;
        UIAlert.showAlert(context,
            message: value.data['message'] ?? 'wrong'.tr());
        emit(ChangeFavWrongState());
      }
    }).catchError((e) {
      favLoadingId = '';
      favorites[id] = !favorites[id]!;
      print(e.toString());
      emit(ChangeFavErrorState());
    });
  }

  void getFavProviders({int page = 1}) {
    emit(GetProvidersLoadingState());
    DioHelper.getData(
      url: '${EndPoints.getFav}$page',
      token: 'Bearer $token',
    ).then((value) {
      print(value.data);
      if (value.data['status'] == true && value.data['data'] != null) {
        if (page == 1) {
          favProvidersModel = ProvidersPaginationModel.fromJson(value.data);
          takeFav(favProvidersModel!.data!.data!);
        } else {
          favProvidersModel!.data!.currentPage =
              value.data['data']['currentPage'];
          favProvidersModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e) {
            favProvidersModel!.data!.data!.add(ProviderData.fromJson(e));
          });
          takeFav(favProvidersModel!.data!.data!);
        }
        emit(GetProvidersSuccessState());
      } else if (value.data['status'] == false && value.data['data'] != null) {
        emit(GetProvidersWrongState());
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetProvidersErrorState());
    });
  }

  void paginationFavProviders(BuildContext context) {
    favProvidersScrollerController.addListener(() {
      if (favProvidersScrollerController.offset ==
          favProvidersScrollerController.position.maxScrollExtent) {
        if (favProvidersModel!.data!.currentPage !=
            favProvidersModel!.data!.pages) {
          if (state is! GetProvidersLoadingState) {
            int currentPage = favProvidersModel!.data!.currentPage! + 1;
            getFavProviders(page: currentPage);
          }
        }
      }
    });
  }

  void reviewLaundry({
    required BuildContext context,
    required String id,
    required String content,
    required int rate,
  }) {
    emit(ReviewLaundryLoadingState());
    DioHelper.postData(
        url: EndPoints.reviewLaundry,
        token: 'Bearer $token',
        data: {
          "provider_id": id,
          "review_content": content,
          "review_rate": rate,
        }).then((value) {
      if (value.data['status'] == true && value.data['data'] == null) {
        UIAlert.showAlert(context, message: value.data['message']);
        emit(ReviewLaundrySuccessState());
        Navigator.pop(context);
      } else {
        UIAlert.showAlert(context,
            message: value.data['data'] != null
                ? value.data['data'].toString()
                : value.data['message'] ?? 'wrong'.tr());
        emit(ReviewLaundryWrongState());
      }
    }).catchError((e) {
      print(e.toString());
      emit(ReviewLaundryErrorState());
    });
  }
}
