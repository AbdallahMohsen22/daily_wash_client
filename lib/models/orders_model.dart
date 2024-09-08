class OrdersModel {
  String? message;
  bool? status;
  Data? data;

  OrdersModel({this.message, this.status, this.data});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  int? pages;
  int? count;
  List<OrderData>? data;

  Data({this.currentPage, this.pages, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(new OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentPage'] = this.currentPage;
    data['pages'] = this.pages;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  String? id;
  String? userName;
  String? providerLatitude;
  String? providerLongitude;
  String? providerName;
  String? providerPhone;
  String? providerId;
  String? providerPersonalPhoto;
  String? orderedReceivingReceipt;
  int? itemNumber;
  int? status;
  int? serviceType;
  String? userLatitude;
  String? userLongitude;
  int? vatValue;
  int? appFees;
  int? subTotalPrice;
  int? shippingCharges;
  int? totalPrice;
  String? paymentMethod;
  List<UserAddress>? userAddress;
  String? orderedReceivingDate;
  String? orderedDate;
  String? createdAt;
  String? additionalNotes;
  String? deliveryManLatitude;
  String? deliveryManLongitude;
  String? deliveryManName;
  String? deliveryManPhone;

  OrderData(
      {this.id,
        this.userName,
        this.providerLatitude,
        this.providerLongitude,
        this.providerName,
        this.providerPhone,
        this.providerPersonalPhoto,
        this.orderedReceivingReceipt,
        this.itemNumber,
        this.status,
        this.serviceType,
        this.userLatitude,
        this.userLongitude,
        this.vatValue,
        this.appFees,
        this.subTotalPrice,
        this.shippingCharges,
        this.totalPrice,
        this.providerId,
        this.paymentMethod,
        this.userAddress,
        this.orderedReceivingDate,
        this.orderedDate,
        this.createdAt,
        this.additionalNotes});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    providerLatitude = json['provider_latitude'];
    providerLongitude = json['provider_longitude'];
    providerName = json['provider_name'];
    providerId = json['provider_id'];
    providerPhone = json['provider_phone'];
    providerPersonalPhoto = json['provider_personal_photo'];
    orderedReceivingReceipt = json['ordered_receiving_receipt'];
    itemNumber = json['item_number'];
    status = json['status'];
    serviceType = json['service_type'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    vatValue = json['vat_value'];
    appFees = json['app_fees'];
    subTotalPrice = json['sub_total_price'];
    shippingCharges = json['shipping_charges'];
    totalPrice = json['total_price'];
    paymentMethod = json['payment_method'];
    if (json['user_address'] != null) {
      userAddress = <UserAddress>[];
      json['user_address'].forEach((v) {
        userAddress!.add(new UserAddress.fromJson(v));
      });
    }
    deliveryManLatitude = json['delivery_man_latitude'];
    deliveryManLongitude = json['delivery_man_longitude'];
    deliveryManName = json['delivery_man_name'];
    orderedReceivingDate = json['ordered_receiving_date'];
    orderedDate = json['ordered_date'];
    createdAt = json['created_at'];
    additionalNotes = json['additional_notes'];
    deliveryManPhone = json['delivery_man_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['provider_latitude'] = this.providerLatitude;
    data['provider_longitude'] = this.providerLongitude;
    data['provider_name'] = this.providerName;
    data['provider_phone'] = this.providerPhone;
    data['provider_personal_photo'] = this.providerPersonalPhoto;
    data['ordered_receiving_receipt'] = this.orderedReceivingReceipt;
    data['provider_id'] = this.providerId;
    data['item_number'] = this.itemNumber;
    data['status'] = this.status;
    data['service_type'] = this.serviceType;
    data['user_latitude'] = this.userLatitude;
    data['user_longitude'] = this.userLongitude;
    data['vat_value'] = this.vatValue;
    data['app_fees'] = this.appFees;
    data['sub_total_price'] = this.subTotalPrice;
    data['shipping_charges'] = this.shippingCharges;
    data['total_price'] = this.totalPrice;
    data['payment_method'] = this.paymentMethod;
    if (this.userAddress != null) {
      data['user_address'] = this.userAddress!.map((v) => v.toJson()).toList();
    }
    data['ordered_receiving_date'] = this.orderedReceivingDate;
    data['ordered_date'] = this.orderedDate;
    data['created_at'] = this.createdAt;
    data['additional_notes'] = this.additionalNotes;
    return data;
  }
}

class UserAddress {
  String? id;
  String? title;

  UserAddress({this.id, this.title});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
