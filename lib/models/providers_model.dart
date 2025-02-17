// class ProvidersModel {
//   String? message;
//   bool? status;
//   List<ProviderData>? data;
//
//   ProvidersModel({this.message, this.status, this.data});
//
//   // ProvidersModel.fromJson(Map<String, dynamic> json) {
//   //   message = json['message'] as String?;
//   //   status = json['status'] as bool?;
//   //   if (json['data'] != null) {
//   //     data = (json['data'] as List<dynamic>?)
//   //         ?.map((v) => ProviderData.fromJson(v as Map<String, dynamic>))
//   //         .toList();
//   //   }
//   // }
//   ProvidersModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'] as String?;
//     status = json['status'] as bool?;
//
//     if (json['data'] != null) {
//       if (json['data'] is List) {
//         // If `data` is a list
//         data = (json['data'] as List)
//             .map((v) => ProviderData.fromJson(v as Map<String, dynamic>))
//             .toList();
//       } else if (json['data'] is Map) {
//         // If `data` is a map (for pagination)
//         final paginationData = ProvidersPaginationModel.fromJson(
//           json['data'] as Map<String, dynamic>,
//         );
//         data = paginationData.data?.data;
//       }
//     }
//   }
//
//   Map<String, dynamic> toJson() => {
//     'message': message,
//     'status': status,
//     'data': data?.map((v) => v.toJson()).toList(),
//   };
// }
//
// class ProvidersPaginationModel {
//   String? message;
//   bool? status;
//   PaginationData? data;
//
//   ProvidersPaginationModel({this.message, this.status, this.data});
//
//   // ProvidersPaginationModel.fromJson(Map<String, dynamic> json) {
//   //   message = json['message'] as String?;
//   //   status = json['status'] as bool?;
//   //   data = json['data'] != null
//   //       ? PaginationData.fromJson(json['data'] as Map<String, dynamic>)
//   //       : null;
//   // }
//   ProvidersPaginationModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'] as String?;
//     status = json['status'] as bool?;
//
//     if (json['data'] != null) {
//       if (json['data'] is Map) {
//         // If `data` is a map, parse it as `PaginationData`
//         data = PaginationData.fromJson(json['data'] as Map<String, dynamic>);
//       } else if (json['data'] is List) {
//         // If `data` is a list, wrap it in `PaginationData` with only `data` populated
//         data = PaginationData(
//           data: (json['data'] as List)
//               .map((v) => ProviderData.fromJson(v as Map<String, dynamic>))
//               .toList(),
//         );
//       }
//     }
//   }
//
//
//   Map<String, dynamic> toJson() => {
//     'message': message,
//     'status': status,
//     'data': data?.toJson(),
//   };
// }
//
// class PaginationData {
//   int? currentPage;
//   int? pages;
//   int? count;
//   List<ProviderData>? data;
//
//   PaginationData({this.currentPage, this.pages, this.count, this.data});
//
//   PaginationData.fromJson(Map<String, dynamic> json) {
//     currentPage = json['currentPage'] as int?;
//     pages = json['pages'] as int?;
//     count = json['count'] as int?;
//     if (json['data'] != null) {
//       data = (json['data'] as List<dynamic>?)
//           ?.map((v) => ProviderData.fromJson(v as Map<String, dynamic>))
//           .toList();
//     }
//   }
//
//   Map<String, dynamic> toJson() => {
//     'currentPage': currentPage,
//     'pages': pages,
//     'count': count,
//     'data': data?.map((v) => v.toJson()).toList(),
//   };
// }
//
// class ProviderData {
//   String? id;
//   int? itemNumber;
//   String? name;
//   String? currentLatitude;
//   String? currentLongitude;
//   String? firebaseToken;
//   String? whatsappNumber;
//   String? phoneNumber;
//   String? personalPhoto;
//   String? currentLanguage;
//   int? totalRate;
//   int? totalRateNumber;
//   int? totalRateCount;
//   int? status;
//   String? distance;
//   String? address;
//   bool? isFavorited;
//   List<dynamic>? reviews;
//   List<dynamic>? rates;
//   String? createdAt;
//   ServiceDetails? serviceDetails;
//   int? rushFees;
//   int? transactionFees;
//   int? taxes;
//   int? numberOfEmp;
//
//   ProviderData({
//     this.id,
//     this.itemNumber,
//     this.name,
//     this.currentLatitude,
//     this.currentLongitude,
//     this.firebaseToken,
//     this.whatsappNumber,
//     this.phoneNumber,
//     this.personalPhoto,
//     this.currentLanguage,
//     this.totalRate,
//     this.totalRateNumber,
//     this.totalRateCount,
//     this.status,
//     this.distance,
//     this.address,
//     this.isFavorited,
//     this.reviews,
//     this.rates,
//     this.createdAt,
//     this.serviceDetails,
//     this.rushFees,
//     this.transactionFees,
//     this.taxes,
//     this.numberOfEmp,
//   });
//
//   ProviderData.fromJson(Map<String, dynamic> json) {
//     id = json['id'] as String?;
//     itemNumber = json['item_number'] as int?;
//     name = json['name'] as String?;
//     currentLatitude = json['current_latitude'] as String?;
//     currentLongitude = json['current_longitude'] as String?;
//     firebaseToken = json['firebase_token'] as String?;
//     whatsappNumber = json['whatsapp_number'] as String?;
//     phoneNumber = json['phone_number'] as String?;
//     personalPhoto = json['personal_photo'] as String?;
//     currentLanguage = json['current_language'] as String?;
//     totalRate = json['total_rate'] as int?;
//     totalRateNumber = json['total_rate_number'] as int?;
//     totalRateCount = json['total_rate_count'] as int?;
//     status = json['status'] as int?;
//     distance = json['distance'] as String?;
//     address = json['address'] as String?;
//     isFavorited = json['is_favorited'] as bool?;
//     reviews = json['reviews'] as List<dynamic>?;
//     rates = json['rates'] as List<dynamic>?;
//     createdAt = json['created_at'] as String?;
//     serviceDetails = json['serviceDetails'] != null
//         ? ServiceDetails.fromJson(json['serviceDetails'] as Map<String, dynamic>)
//         : null;
//     rushFees = json['rush_fees'] as int?;
//     transactionFees = json['transaction_fees'] as int?;
//     taxes = json['taxes'] as int?;
//     numberOfEmp = json['numberOfEmp'] as int?;
//   }
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'item_number': itemNumber,
//     'name': name,
//     'current_latitude': currentLatitude,
//     'current_longitude': currentLongitude,
//     'firebase_token': firebaseToken,
//     'whatsapp_number': whatsappNumber,
//     'phone_number': phoneNumber,
//     'personal_photo': personalPhoto,
//     'current_language': currentLanguage,
//     'total_rate': totalRate,
//     'total_rate_number': totalRateNumber,
//     'total_rate_count': totalRateCount,
//     'status': status,
//     'distance': distance,
//     'address': address,
//     'is_favorited': isFavorited,
//     'reviews': reviews,
//     'rates': rates,
//     'created_at': createdAt,
//     'serviceDetails': serviceDetails?.toJson(),
//     'rush_fees': rushFees,
//     'transaction_fees': transactionFees,
//     'taxes': taxes,
//     'numberOfEmp': numberOfEmp,
//   };
// }
//
// class ServiceDetails {
//   Map<String, List<ServiceItem>>? services;
//   bool? isDelivery;
//   int? deliveryFeesPerKilo;
//   int? withTools;
//   int? employeePrice;
//
//   ServiceDetails({
//     this.services,
//     this.isDelivery,
//     this.deliveryFeesPerKilo,
//     this.withTools,
//     this.employeePrice,
//   });
//
//   ServiceDetails.fromJson(Map<String, dynamic> json) {
//     services = {};
//     json.forEach((key, value) {
//       if (value is List) {
//         services![key] = value
//             .map((v) => ServiceItem.fromJson(v as Map<String, dynamic>))
//             .toList();
//       } else if (key == 'is_delivery') {
//         isDelivery = value as bool?;
//       } else if (key == 'delivery_fees_per_kilo') {
//         deliveryFeesPerKilo = value as int?;
//       } else if (key == 'with_tools') {
//         withTools = value as int?;
//       } else if (key == 'employee_price') {
//         employeePrice = value as int?;
//       }
//     });
//   }
//
//   Map<String, dynamic> toJson() => {
//     ...?services?.map((key, value) => MapEntry(key, value.map((v) => v.toJson()).toList())),
//     'is_delivery': isDelivery,
//     'delivery_fees_per_kilo': deliveryFeesPerKilo,
//     'with_tools': withTools,
//     'employee_price': employeePrice,
//   };
// }
//
// class ServiceItem {
//   String? id;
//   String? name;
//   String? icon;
//   int? price;
//
//   ServiceItem({this.id, this.name, this.icon, this.price});
//
//   ServiceItem.fromJson(Map<String, dynamic> json) {
//     id = json['id'] as String?;
//     name = json['name'] as String?;
//     icon = json['icon'] as String?;
//     price = json['price'] as int?;
//   }
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'icon': icon,
//     'price': price,
//   };
// }
class ProvidersModel {
  String? message;
  bool? status;
  List<ProviderData>? data;

  ProvidersModel({this.message, this.status, this.data});

  ProvidersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
    status = json['status'] as bool?;
    if (json['data'] != null) {
      if (json['data'] is List) {
        // If `data` is a list
        data = (json['data'] as List)
            .map((v) => ProviderData.fromJson(v as Map<String, dynamic>))
            .toList();
      } else if (json['data'] is Map) {
        // If `data` is a map (for pagination)
        final paginationData = ProvidersPaginationModel.fromJson(
          json['data'] as Map<String, dynamic>,
        );
        data = paginationData.data?.data;
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'status': status,
        'data': data?.map((v) => v.toJson()).toList(),
      };
}

class ProvidersPaginationModel {
  String? message;
  bool? status;
  PaginationData? data;

  ProvidersPaginationModel({this.message, this.status, this.data});

  ProvidersPaginationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
    status = json['status'] as bool?;
    if (json['data'] != null) {
      if (json['data'] is Map) {
        // If `data` is a map, parse it as `PaginationData`
        data = PaginationData.fromJson(json['data'] as Map<String, dynamic>);
      } else if (json['data'] is List) {
        // If `data` is a list, wrap it in `PaginationData` with only `data` populated
        data = PaginationData(
          data: (json['data'] as List)
              .map((v) => ProviderData.fromJson(v as Map<String, dynamic>))
              .toList(),
        );
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'status': status,
        'data': data?.toJson(),
      };
}

class PaginationData {
  int? currentPage;
  int? pages;
  int? count;
  List<ProviderData>? data;

  PaginationData({this.currentPage, this.pages, this.count, this.data});

  PaginationData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'] as int?;
    pages = json['pages'] as int?;
    count = json['count'] as int?;
    if (json['data'] != null) {
      data = (json['data'] as List<dynamic>)
          .map((v) => ProviderData.fromJson(v as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'pages': pages,
        'count': count,
        'data': data?.map((v) => v.toJson()).toList(),
      };
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
  List<dynamic>? reviews; // Assuming reviews can be of any type
  List<dynamic>? rates; // Assuming rates can be of any type
  String? createdAt;
  ServiceDetails? serviceDetails;
  int? rushFees;
  int? transactionFees;
  int? taxes;
  String? startTime;
  String? endTime;

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
    this.startTime,
    this.endTime,
  });

  ProviderData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    itemNumber = json['item_number'] as int?;
    name = json['name'] as String?;
    currentLatitude = json['current_latitude'] as String?;
    currentLongitude = json['current_longitude'] as String?;
    firebaseToken = json['firebase_token'] as String?;
    whatsappNumber = json['whatsapp_number'] as String?;
    phoneNumber = json['phone_number'] as String?;
    personalPhoto = json['personal_photo'] as String?;
    currentLanguage = json['current_language'] as String?;
    totalRate = json['total_rate'] as int?;
    totalRateNumber = json['total_rate_number'] as int?;
    totalRateCount = json['total_rate_count'] as int?;
    status = json['status'] as int?;
    address = json['address'] as String?;
    isFavorited = json['is_favorited'] as bool?;
    reviews = json['reviews'] as List<dynamic>?;
    rates = json['rates'] as List<dynamic>?;
    createdAt = json['created_at'] as String?;
    serviceDetails = json['serviceDetails'] != null
        ? ServiceDetails.fromJson(
            json['serviceDetails'] as Map<String, dynamic>)
        : null;
    rushFees = json['rush_fees'] as int?;
    transactionFees = json['transaction_fees'] as int?;
    taxes = json['taxes'] as int?;
    startTime = json['start_time'] as String?;
    endTime = json['end_time'] as String?;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'item_number': itemNumber,
        'name': name,
        'current_latitude': currentLatitude,
        'current_longitude': currentLongitude,
        'firebase_token': firebaseToken,
        'whatsapp_number': whatsappNumber,
        'phone_number': phoneNumber,
        'personal_photo': personalPhoto,
        'current_language': currentLanguage,
        'total_rate': totalRate,
        'total_rate_number': totalRateNumber,
        'total_rate_count': totalRateCount,
        'status': status,
        'address': address,
        'is_favorited': isFavorited,
        'reviews': reviews,
        'rates': rates,
        'created_at': createdAt,
        'serviceDetails': serviceDetails?.toJson(),
        'rush_fees': rushFees,
        'transaction_fees': transactionFees,
        'taxes': taxes,
        'start_time': startTime,
        'end_time': endTime,
      };
}

class ServiceDetails {
  List<House>? house;
  int? defaultNumOfEmployees;
  int? defaultPrice;
  int? extraEmployee;
  int? withTools;
  int? employeePrice;
  List<Car>? cars;
  List<Clothing>? clothes;
  bool? isDelivery;
  int? deliveryFeesPerKilo;

  ServiceDetails({
    this.house,
    this.defaultNumOfEmployees,
    this.defaultPrice,
    this.extraEmployee,
    this.withTools,
    this.employeePrice,
    this.cars,
    this.clothes,
    this.isDelivery,
    this.deliveryFeesPerKilo,
  });

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    if (json['House'] != null) {
      house = <House>[];
      json['House'].forEach((v) {
        house!.add(House.fromJson(v as Map<String, dynamic>));
      });
    }
    defaultNumOfEmployees = json['default_NumOfEmployees'] as int?;
    defaultPrice = json['default_Price'] as int?;
    extraEmployee = json['extra_employee'] as int?;
    withTools = json['with_tools'] as int?;
    employeePrice = json['employee_price'] as int?;
    if (json['Cars'] != null) {
      cars = <Car>[];
      json['Cars'].forEach((v) {
        cars!.add(Car.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['Clothes'] != null) {
      clothes = <Clothing>[];
      json['Clothes'].forEach((v) {
        clothes!.add(Clothing.fromJson(v as Map<String, dynamic>));
      });
    }
    isDelivery = json['is_delivery'] as bool?;
    deliveryFeesPerKilo = json['delivery_fees_per_kilo'] as int?;
  }

  Map<String, dynamic> toJson() => {
        'House': house?.map((v) => v.toJson()).toList(),
        'default_NumOfEmployees': defaultNumOfEmployees,
        'default_Price': defaultPrice,
        'extra_employee': extraEmployee,
        'with_tools': withTools,
        'employee_price': employeePrice,
        'Cars': cars?.map((v) => v.toJson()).toList(),
        'Clothes': clothes?.map((v) => v.toJson()).toList(),
        'is_delivery': isDelivery,
        'delivery_fees_per_kilo': deliveryFeesPerKilo,
      };
}

class House {
  String? id;
  String? name;
  String? ar_name;
  String? icon;
  int? price;

  House({this.id, this.name, this.icon, this.price});

  House.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    ar_name = json['ar_name'] as String?;
    icon = json['icon'] as String?;
    price = json['price'] as int?;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'ar_name': ar_name,
        'icon': icon,
        'price': price,
      };
}

class Car {
  String? id;
  String? name;
  String? ar_name;
  String? icon;
  int? price;

  Car({this.id, this.name, this.icon, this.price});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    ar_name = json['ar_name'] as String?;
    icon = json['icon'] as String?;
    price = json['price'] as int?;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'ar_name': ar_name,
        'icon': icon,
        'price': price,
      };
}

class Clothing {
  String? id;
  String? name;
  String? ar_name;
  String? icon;
  int? price;

  Clothing({this.id, this.name, this.icon, this.price});

  Clothing.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    ar_name = json['ar_name'] as String?;
    icon = json['icon'] as String?;
    price = json['price'] as int?;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'ar_name': ar_name,
        'icon': icon,
        'price': price,
      };
}
