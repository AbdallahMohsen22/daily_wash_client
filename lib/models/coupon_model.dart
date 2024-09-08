class CouponModel {
  String? message;
  bool? status;
  Data? data;

  CouponModel({this.message, this.status, this.data});

  CouponModel.fromJson(Map<String, dynamic> json) {
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
  bool? isApplied;
  int? discountValue;
  int? discountType;

  Data({this.isApplied, this.discountValue, this.discountType});

  Data.fromJson(Map<String, dynamic> json) {
    isApplied = json['is_applied'];
    discountValue = json['discount_value'];
    discountType = json['discount_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_applied'] = this.isApplied;
    data['discount_value'] = this.discountValue;
    data['discount_type'] = this.discountType;
    return data;
  }
}
