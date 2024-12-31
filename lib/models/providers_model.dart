class ProvidersModel {
  String? message;
  bool? status;
  List<ProviderData>? data;

  ProvidersModel({this.message, this.status, this.data});

  ProvidersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ProviderData>[];
      json['data'].forEach((v) {
        data!.add(ProviderData.fromJson(v));
      });
    }
  }
// From ابو  شيماء لابو عبير
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProvidersPaginationModel {
  String? message;
  bool? status;
  Data? data;

  ProvidersPaginationModel({this.message, this.status, this.data});

  ProvidersPaginationModel.fromJson(Map<String, dynamic> json) {
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
  List<ProviderData>? data;

  Data({this.currentPage, this.pages, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = _parseInt(json['currentPage']);
    pages = _parseInt(json['pages']);
    count = _parseInt(json['count']);
    if (json['data'] != null) {
      data = <ProviderData>[];
      json['data'].forEach((v) {
        data!.add(ProviderData.fromJson(v));
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

  // Safe parsing function for integers
  int _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0;
    } else if (value is int) {
      return value;
    }
    return 0;
  }
}


class ProviderData {
  String? id;
  int? itemNumber;
  String? name;
  String? currentLatitude;
  String? currentLongitude;
  String? firebaseToken;
  String? whatsappNumber;
  String? phoneNumber;
  String? personalPhoto;
  String? currentLanguage;
  int? totalRate;
  int? totalRateNumber;
  int? totalRateCount;
  int? status;
  String? distance;
  String? address;
  bool? isFavorited;
  List<dynamic>? reviews;
  List<dynamic>? rates;
  String? createdAt;
  ServiceDetails? serviceDetails;
  int? rushFees;
  int? transactionFees;
  int? taxes;
  int? numberOfEmp;

  ProviderData({
    this.id,
    this.itemNumber,
    this.name,
    this.currentLatitude,
    this.currentLongitude,
    this.firebaseToken,
    this.whatsappNumber,
    this.phoneNumber,
    this.personalPhoto,
    this.currentLanguage,
    this.totalRate,
    this.totalRateNumber,
    this.totalRateCount,
    this.status,
    this.address,
    this.isFavorited,
    this.reviews,
    this.rates,
    this.createdAt,
    this.serviceDetails,
    this.rushFees,
    this.transactionFees,
    this.taxes,
    this.numberOfEmp,
  });

  ProviderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = json['item_number'];
    name = json['name'];
    currentLatitude = json['current_latitude'];
    currentLongitude = json['current_longitude'];
    firebaseToken = json['firebase_token'];
    whatsappNumber = json['whatsapp_number'];
    phoneNumber = json['phone_number'];
    personalPhoto = json['personal_photo'];
    currentLanguage = json['current_language'];
    totalRate = json['total_rate'];
    totalRateNumber = json['total_rate_number'];
    totalRateCount = json['total_rate_count'];
    status = json['status'];
    address = json['address'];
    isFavorited = json['is_favorited'];
    reviews = json['reviews'];
    rates = json['rates'];
    createdAt = json['created_at'];
    serviceDetails = json['serviceDetails'] != null
        ? ServiceDetails.fromJson(json['serviceDetails'])
        : null;
    rushFees = json['rush_fees'];
    transactionFees = json['transaction_fees'];
    taxes = json['taxes'];
    numberOfEmp = json['numberOfEmp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_number'] = itemNumber;
    data['name'] = name;
    data['current_latitude'] = currentLatitude;
    data['current_longitude'] = currentLongitude;
    data['firebase_token'] = firebaseToken;
    data['whatsapp_number'] = whatsappNumber;
    data['phone_number'] = phoneNumber;
    data['personal_photo'] = personalPhoto;
    data['current_language'] = currentLanguage;
    data['total_rate'] = totalRate;
    data['total_rate_number'] = totalRateNumber;
    data['total_rate_count'] = totalRateCount;
    data['status'] = status;
    data['address'] = address;
    data['is_favorited'] = isFavorited;
    data['reviews'] = reviews;
    data['rates'] = rates;
    data['created_at'] = createdAt;
    if (serviceDetails != null) {
      data['serviceDetails'] = serviceDetails!.toJson();
    }
    data['rush_fees'] = rushFees;
    data['transaction_fees'] = transactionFees;
    data['taxes'] = taxes;
    data['numberOfEmp'] = numberOfEmp;
    return data;
  }
}

class ServiceDetails {
  Map<String, List<ServiceItem>>? services;
  bool? isDelivery;
  int? deliveryFeesPerKilo;
  int? withTools;
  int? employeePrice;

  ServiceDetails({
    this.services,
    this.isDelivery,
    this.deliveryFeesPerKilo,
    this.withTools,
    this.employeePrice,
  });

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    services = {};
    json.forEach((key, value) {
      if (key == 'is_delivery' || key == 'delivery_fees_per_kilo' || key == 'with_tools' || key == 'employee_price') {
        // Handle individual keys
        if (key == 'is_delivery') isDelivery = value;
        if (key == 'delivery_fees_per_kilo') deliveryFeesPerKilo = value;
        if (key == 'with_tools') withTools = int.tryParse(value.toString());
        if (key == 'employee_price') employeePrice = int.tryParse(value.toString());
      } else if (value is List) {
        services![key] = value.map((v) => ServiceItem.fromJson(v)).toList();
      }
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    services?.forEach((key, value) {
      data[key] = value.map((v) => v.toJson()).toList();
    });
    data['is_delivery'] = isDelivery.toString();
    data['delivery_fees_per_kilo'] = deliveryFeesPerKilo;
    data['with_tools'] = withTools;
    data['employee_price'] = employeePrice;
    return data;
  }
}

class ServiceItem {
  String? id;
  String? name;
  String? icon;
  int? price;

  ServiceItem({this.id, this.name, this.icon, this.price});

  ServiceItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['price'] = price;
    return data;
  }
}
