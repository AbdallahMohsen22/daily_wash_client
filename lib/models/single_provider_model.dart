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

