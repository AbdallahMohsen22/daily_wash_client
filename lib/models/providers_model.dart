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
        data!.add(new ProviderData.fromJson(v));
      });
    }
  }

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
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <ProviderData>[];
      json['data'].forEach((v) {
        data!.add(new ProviderData.fromJson(v));
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
  String? address;
  bool? isFavorited;
  List<Reviews>? reviews;
  List<Null>? rates;
  String? createdAt;
  String? distance;

  ProviderData(
      {this.id,
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
        this.createdAt});

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
    distance = json['distance'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    // if (json['rates'] != null) {
    //   rates = <Null>[];
    //   json['rates'].forEach((v) {
    //     rates!.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_number'] = this.itemNumber;
    data['name'] = this.name;
    data['current_latitude'] = this.currentLatitude;
    data['current_longitude'] = this.currentLongitude;
    data['firebase_token'] = this.firebaseToken;
    data['whatsapp_number'] = this.whatsappNumber;
    data['phone_number'] = this.phoneNumber;
    data['personal_photo'] = this.personalPhoto;
    data['current_language'] = this.currentLanguage;
    data['total_rate'] = this.totalRate;
    data['total_rate_number'] = this.totalRateNumber;
    data['total_rate_count'] = this.totalRateCount;
    data['status'] = this.status;
    data['address'] = this.address;
    data['is_favorited'] = this.isFavorited;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    // if (this.rates != null) {
    //   data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    // }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Reviews {
  String? id;
  int? rate;
  String? content;

  Reviews({this.id, this.rate, this.content});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rate'] = this.rate;
    data['content'] = this.content;
    return data;
  }
}
