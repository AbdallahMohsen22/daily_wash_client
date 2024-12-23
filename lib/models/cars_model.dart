class CarsModel {
  String? message;
  bool? status;
  List<CarData>? data;

  CarsModel({this.message, this.status, this.data});

  CarsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <CarData>[];
      json['data'].forEach((v) {
        data!.add(CarData.fromJson(v));
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

// class ProvidersPaginationModel {
//   String? message;
//   bool? status;
//   Data? data;
//
//   ProvidersPaginationModel({this.message, this.status, this.data});
//
//   ProvidersPaginationModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

class Data {
  int? currentPage;
  int? pages;
  int? count;
  List<CarData>? data;

  Data({this.currentPage, this.pages, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = _parseInt(json['currentPage']);
    pages = _parseInt(json['pages']);
    count = _parseInt(json['count']);
    if (json['data'] != null) {
      data = <CarData>[];
      json['data'].forEach((v) {
        data!.add(CarData.fromJson(v));
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

class CarData {
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
  String? address;
  bool? isFavorited;
  String?distance;
  int? distance_value;
  List<Reviews>? reviews;
  List<dynamic>? rates;
  String? createdAt;
  List<PricingItem>? pricingItems;
  bool? isDelivery;
  num? taxes;
  num? delivery_fees;
  num? transaction_fees;

  CarData({
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
    this.pricingItems,
    this.isDelivery,
    this.taxes,
    this.transaction_fees,
    this.delivery_fees,
  });

  CarData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = _parseInt(json['item_number']);
    name = json['name'];
    currentLatitude = json['current_latitude'];
    currentLongitude = json['current_longitude'];
    firebaseToken = json['firebase_token'];
    whatsappNumber = json['whatsapp_number'];
    phoneNumber = json['phone_number'];
    personalPhoto = json['personal_photo'];
    currentLanguage = json['current_language'];
    totalRate = _parseInt(json['total_rate']);
    totalRateNumber = _parseInt(json['total_rate_number']);
    totalRateCount = _parseInt(json['total_rate_count']);
    distance_value=_parseInt(json['distance_value']);
    distance=json['distance'];
    status = json['status'];
    address = json['address'];
    isFavorited = json['is_favorited'];
    isDelivery = json['is_delivery'];
    createdAt = json['created_at'];
    if (json['reviews'] != null) {
      reviews =
          (json['reviews'] as List).map((v) => Reviews.fromJson(v)).toList();
    }
    rates = json['rates'];
    if (json['pricingItems'] != null) {
      pricingItems = List.from(
          json['pricingItems']?.map((item) => PricingItem.fromJson(item)) ??
              []);
    }
    taxes = _parseInt(json['taxes']);
    transaction_fees = _parseInt(json['transaction_fees']);
    delivery_fees = _parseInt(json['delivery_fees']);
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
    data['distance_value']=distance_value;
    data['distance']=distance;
    data['is_favorited'] = isFavorited;
    data['is_delivery'] = isDelivery;
    data['created_at'] = createdAt;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['rates'] = rates;
    if (pricingItems != null) {
      data['pricingItems'] = pricingItems!.map((v) => v.toJson()).toList();
    }
    data['taxes'] = taxes;
    data['delivery_fees'] = delivery_fees;
    data['transaction_fees'] = transaction_fees;
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

class Reviews {
  String? id;
  String? username;
  int? rate;
  String? content;

  Reviews({this.id, this.rate, this.content, this.username});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['user_name'];
    rate = json['rate'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.username;
    data['rate'] = this.rate;
    data['content'] = this.content;
    return data;
  }
}

class PricingItem {
  String? id;
  String? name;
  String? icon;
  int? price;

  PricingItem({this.id, this.name, this.icon, this.price});

  PricingItem.fromJson(Map<String, dynamic> json) {
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
