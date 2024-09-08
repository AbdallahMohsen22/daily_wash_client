class UserModel {
  String? message;
  bool? status;
  Data? data;

  UserModel({this.message, this.status, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  int? itemNumber;
  String? name;
  String? whatsappNumber;
  String? firebaseToken;
  String? currentLanguage;
  String? personalPhoto;
  String? phoneNumber;
  String? email;
  int? status;
  String? createdAt;
  AddressInformation? addressInformation;

  Data(
      {this.id,
        this.itemNumber,
        this.name,
        this.whatsappNumber,
        this.firebaseToken,
        this.currentLanguage,
        this.personalPhoto,
        this.email,
        this.status,
        this.createdAt,
        this.addressInformation
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = json['item_number'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    whatsappNumber = json['whatsapp_number'];
    firebaseToken = json['firebase_token'];
    currentLanguage = json['current_language'];
    personalPhoto = json['personal_photo'];
    email = json['email'];
    status = json['status'];
    addressInformation = json['address_information'] != null
        ? new AddressInformation.fromJson(json['address_information']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_number'] = this.itemNumber;
    data['name'] = this.name;
    data['whatsapp_number'] = this.whatsappNumber;
    data['firebase_token'] = this.firebaseToken;
    data['current_language'] = this.currentLanguage;
    data['personal_photo'] = this.personalPhoto;
    data['email'] = this.email;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class AddressInformation {
  String? building_name;
  String? floor_number;
  String? apartment_number;
  String? distinguished_landmark;


  AddressInformation({
    this.apartment_number,
    this.building_name,
    this.distinguished_landmark,
    this.floor_number,
});

  AddressInformation.fromJson(Map<String, dynamic> json) {
    building_name = json['building_name'];
    apartment_number = json['apartment_number'];
    distinguished_landmark = json['distinguished_landmark'];
    floor_number = json['floor_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_name'] = this.building_name;
    data['apartment_number'] = this.apartment_number;
    data['distinguished_landmark'] = this.distinguished_landmark;
    data['floor_number'] = this.floor_number;
    return data;
  }
}
