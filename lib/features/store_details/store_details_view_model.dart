import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/addresses/model/address_model.dart';
import 'package:on_express/features/home/model/service_type_model.dart';

import '../../cubits/app_cubit/app_cubit.dart';

class StoreDetailsViewModel {
  ///objects
  GenericCubit<int?> serviceTypeCubit = GenericCubit(null);
  GenericCubit<int?> deliveryTypeCubit = GenericCubit(null);
  GenericCubit<int?> dateCubit = GenericCubit(null);
  GenericCubit<int?> timeCubit = GenericCubit(null);
  GenericCubit<bool?> requestDateNowCubit = GenericCubit(null);
  GenericCubit<int?> paymentMethodCubit = GenericCubit(null);

  ///variables
  int selectedDelivery = -1;
  int selectedServiceType = -1;
  int selectedDate = -1;
  int selectedTime = -1;
  int selectPaymentMethod = -1;
  String currentTime = '';
  final useAddress = AddressModel(title: "Home", location: "26985 Brighton..");
  bool checkSelectedServiceType = false;
  bool checkSelectedDeliveryType = false;
  bool checkSelectedLatLng = false;
  bool checkSelectedPayment = false;

  List<ServiceTypeModel> serviceTypes = [
    ServiceTypeModel(
      title: "delivery".tr(),
      imageUrl: ImageResources.delivery,
    ),
    ServiceTypeModel(
      title: "pickup".tr(),
      imageUrl: ImageResources.pickup,
    ),
  ];

  List<String> selectedDeliveryService = [
    ImageResources.car,
    ImageResources.motorcycle,
  ];
  List<String> unSelectedDeliveryService = [
    ImageResources.car2,
    ImageResources.motorcycle2,
  ];
  List<String> times = [
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
  ];
  List<String> paymentMethods = [
    ImageResources.visa,
    ImageResources.applePay,
    ImageResources.mastercard,
    "pay_on_delivery".tr()
  ];

  /// methods
  void setSelectedService(int index,context) {
    serviceTypeCubit.onLoadingState();
    selectedServiceType = index;
    AppCubit.get(context).emitState();
    serviceTypeCubit.onUpdateData(selectedServiceType);
  }

  //set selected delivery
  void setSelectedDelivery(int index) {
    deliveryTypeCubit.onLoadingState();
    selectedDelivery = index;
    deliveryTypeCubit.onUpdateData(selectedDelivery);
  }

  //set selected date
  void setSelectedDate(int index) {
    dateCubit.onLoadingState();
    selectedDate = index;
    dateCubit.onUpdateData(selectedDate);
  }

  //set selected time
  void setSelectedTime(int index) {
    timeCubit.onLoadingState();
    selectedTime = index;
    timeCubit.onUpdateData(selectedTime);
  }


//set selected payment method
  void setSelectedPaymentMethod(int index) {
    paymentMethodCubit.onLoadingState();
    selectPaymentMethod = index;
    paymentMethodCubit.onUpdateData(selectedTime);
  }

  void addRequest(
      {
        required BuildContext context,
      required StoreDetailsViewModel storeDetailsViewModel,
      required String providerId,
      String? additionalNotes,
      String? couponCode}) {
    if (serviceTypeCubit.state.data == null) {
      UIAlert.showNotificationToast("service_type_required".tr());
      checkSelectedServiceType = false;
    } else {
      checkSelectedServiceType = true;
    }
    if (deliveryTypeCubit.state.data == null) {
      UIAlert.showNotificationToast("delivery_type_required".tr());
      checkSelectedDeliveryType = false;
    } else {
      checkSelectedDeliveryType = true;
    }
    if (paymentMethodCubit.state.data == null) {
      UIAlert.showNotificationToast("payment_method_required".tr());
      checkSelectedPayment = false;
    } else {
      checkSelectedPayment = true;
    }
    if (AppCubit
        .get(context)
        .orderLatLng == null) {
      UIAlert.showNotificationToast("address_required".tr());
      checkSelectedLatLng = false;
    } else {
      checkSelectedLatLng = true;
    }
    currentTime = currentTime.replaceAll('/', '-');
    if (context.mounted &&checkSelectedLatLng&&checkSelectedDeliveryType
        &&checkSelectedServiceType&&checkSelectedPayment) {
      AppCubit.get(context).createOrder(
        context: context,
        orderDate: currentTime,
        paymentMethod: selectPaymentMethod == 3?'cash':'online',
        providerId: providerId,
        serviceType: selectedServiceType == 0 ?2:1,
        vehicleType: selectedDelivery == 0 ?'big':'small',
        additionalNotes: additionalNotes,
        couponCode: couponCode
      );
    }
  }
}
