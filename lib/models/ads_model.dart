class ADSModel {
  String? message;
  bool? status;
  Data? data;

  ADSModel({this.message, this.status, this.data});

  ADSModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<ImageAdvertisements>? ads;


  Data.fromJson(Map<String, dynamic> json) {
    ads = <ImageAdvertisements>[];
    if (json['image_advertisements'] != null) {
      json['image_advertisements'].forEach((v) {
        ads!.add(new ImageAdvertisements.fromJson(v));
      });
    }
    if (json['normal_advertisements'] != null) {
      json['normal_advertisements'].forEach((v) {
        ads!.add(new ImageAdvertisements.fromJson(v));
      });
    }
  }

}

class ImageAdvertisements {
  String? id;
  int? advertisementViewType;
  int? advertisementViewTimeType;
  String? endViewDate;
  String? startViewDate;
  String? title;
  String? description;
  String? link;
  String? backgroundImage;
  int? type;

  ImageAdvertisements(
      {this.id,
        this.advertisementViewType,
        this.advertisementViewTimeType,
        this.endViewDate,
        this.startViewDate,
        this.title,
        this.description,
        this.link,
        this.backgroundImage,
        this.type});

  ImageAdvertisements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisementViewType = json['advertisement_view_type'];
    advertisementViewTimeType = json['advertisement_view_time_type'];
    endViewDate = json['end_view_date'];
    startViewDate = json['start_view_date'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    backgroundImage = json['background_image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advertisement_view_type'] = this.advertisementViewType;
    data['advertisement_view_time_type'] = this.advertisementViewTimeType;
    data['end_view_date'] = this.endViewDate;
    data['start_view_date'] = this.startViewDate;
    data['title'] = this.title;
    data['description'] = this.description;
    data['link'] = this.link;
    data['background_image'] = this.backgroundImage;
    data['type'] = this.type;
    return data;
  }
}
