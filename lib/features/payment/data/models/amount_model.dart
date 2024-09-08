class AmountModel {
  final String? total;
  final String? currency;
  final AmountDetailsModel? details;

  AmountModel({
    required this.total,
    required this.currency,
    required this.details,
  });

  // Factory method to create an AmountModel from JSON
  factory AmountModel.fromJson(Map<String, dynamic> json) {
    return AmountModel(
      total: json['total'],
      currency: json['currency'],
      details: json['details'] == null
          ? null
          : AmountDetailsModel.fromJson(json['details']),
    );
  }

  // Method to convert an AmountModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'currency': currency,
      'details': details?.toJson(),
    };
  }
}

class AmountDetailsModel {
  final String? subtotal;
  final String? shipping;
  final int? shippingDiscount;

  AmountDetailsModel({
    this.subtotal,
    this.shipping,
    this.shippingDiscount,
  });

  // Factory method to create an AmountDetailsModel from JSON
  factory AmountDetailsModel.fromJson(Map<String, dynamic> json) {
    return AmountDetailsModel(
      subtotal: json['subtotal'],
      shipping: json['shipping'],
      shippingDiscount: json['shipping_discount'],
    );
  }

  // Method to convert an AmountDetailsModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'shipping': shipping,
      'shipping_discount': shippingDiscount,
    };
  }
}