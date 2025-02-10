import 'package:on_express/models/providers_model.dart';

class SingleProviderModel {
  String? message;
  bool? status;
  ProviderData? data;

  SingleProviderModel({this.message, this.status, this.data});

  SingleProviderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new ProviderData.fromJson(json['data']) : null;
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

// import 'package:on_express/models/providers_model.dart';
//
// class SingleProviderModel {
//   String? message;
//   bool? status;
//   ProviderData? data;
//
//   SingleProviderModel({this.message, this.status, this.data});
//
//   SingleProviderModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     data = json['data'] != null
//         ? new ProviderData.fromJson(json['data'])
//         : null;
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
//
// class ProviderData {
//   int? currentPage;
//   int? pages;
//   int? count;
//   List<Data>? data;
//
//   ProviderData({this.currentPage, this.pages, this.count, this.data});
//
//   ProviderData.fromJson(Map<String, dynamic> json) {
//     currentPage = json['currentPage'];
//     pages = json['pages'];
//     count = json['count'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['currentPage'] = this.currentPage;
//     data['pages'] = this.pages;
//     data['count'] = this.count;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? name;
//   String? service;
//   String? phoneNumber;
//   String? whatsappNumber;
//   int? status;
//
//   Data(
//       {this.id,
//         this.name,
//         this.service,
//         this.phoneNumber,
//         this.whatsappNumber,
//         this.status});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     service = json['service'];
//     phoneNumber = json['phone_number'];
//     whatsappNumber = json['whatsapp_number'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['service'] = this.service;
//     data['phone_number'] = this.phoneNumber;
//     data['whatsapp_number'] = this.whatsappNumber;
//     data['status'] = this.status;
//     return data;
//   }
// }
