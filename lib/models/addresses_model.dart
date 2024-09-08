class AddressesModel {
  String? message;
  bool? status;
  List<AddressesData>? data;

  AddressesModel({this.message, this.status, this.data});

  AddressesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <AddressesData>[];
      json['data'].forEach((v) {
        data!.add(new AddressesData.fromJson(v));
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

class AddressesData {
  String? id;
  String? userId;
  String? latitude;
  String? longitude;
  String? title;
  bool? isDefault;
  AddressInformation? addressInformation;


  AddressesData(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.title,
        this.isDefault});

  AddressesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    title = json['title'];
    isDefault = json['is_default'];
    addressInformation = json['address_information'] != null
        ? new AddressInformation.fromJson(json['address_information'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['title'] = this.title;
    data['is_default'] = this.isDefault;
    return data;
  }
}

class AddressInformation {
  String? buildingName;
  String? floorNumber;
  String? apartmentNumber;
  String? distinguishedLandmark;

  AddressInformation(
      {this.buildingName,
        this.floorNumber,
        this.apartmentNumber,
        this.distinguishedLandmark});

  AddressInformation.fromJson(Map<String, dynamic> json) {
    buildingName = json['building_name'];
    floorNumber = json['floor_number'];
    apartmentNumber = json['apartment_number'];
    distinguishedLandmark = json['distinguished_landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_name'] = this.buildingName;
    data['floor_number'] = this.floorNumber;
    data['apartment_number'] = this.apartmentNumber;
    data['distinguished_landmark'] = this.distinguishedLandmark;
    return data;
  }
}
