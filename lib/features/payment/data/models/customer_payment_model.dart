class CustomerPaymentInputModel {
  final String id;
  final String object;
  final String? address;
  final int balance;
  final int created;
  final String? currency;
  final String? defaultSource;
  final bool delinquent;
  final String? description;
  final String? discount;
  final String email;
  final String invoicePrefix;
  final InvoiceSettings invoiceSettings;
  final bool livemode;
  final Map<String, dynamic> metadata;
  final String name;
  final int nextInvoiceSequence;
  final String? phone;
  final List<String> preferredLocales;
  final String? shipping;
  final String taxExempt;
  final String? testClock;

  CustomerPaymentInputModel({
    required this.id,
    required this.object,
    this.address,
    required this.balance,
    required this.created,
    this.currency,
    this.defaultSource,
    required this.delinquent,
    this.description,
    this.discount,
    required this.email,
    required this.invoicePrefix,
    required this.invoiceSettings,
    required this.livemode,
    required this.metadata,
    required this.name,
    required this.nextInvoiceSequence,
    this.phone,
    required this.preferredLocales,
    this.shipping,
    required this.taxExempt,
    this.testClock,
  });

  factory CustomerPaymentInputModel.fromJson(Map<String, dynamic> json) {
    return CustomerPaymentInputModel(
      id: json['id'],
      object: json['object'],
      address: json['address'],
      balance: json['balance'],
      created: json['created'],
      currency: json['currency'],
      defaultSource: json['default_source'],
      delinquent: json['delinquent'],
      description: json['description'],
      discount: json['discount'],
      email: json['email'],
      invoicePrefix: json['invoice_prefix'],
      invoiceSettings: InvoiceSettings.fromJson(json['invoice_settings']),
      livemode: json['livemode'],
      metadata: Map<String, dynamic>.from(json['metadata']),
      name: json['name'],
      nextInvoiceSequence: json['next_invoice_sequence'],
      phone: json['phone'],
      preferredLocales: List<String>.from(json['preferred_locales']),
      shipping: json['shipping'],
      taxExempt: json['tax_exempt'],
      testClock: json['test_clock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'address': address,
      'balance': balance,
      'created': created,
      'currency': currency,
      'default_source': defaultSource,
      'delinquent': delinquent,
      'description': description,
      'discount': discount,
      'email': email,
      'invoice_prefix': invoicePrefix,
      'invoice_settings': invoiceSettings.toJson(),
      'livemode': livemode,
      'metadata': metadata,
      'name': name,
      'next_invoice_sequence': nextInvoiceSequence,
      'phone': phone,
      'preferred_locales': preferredLocales,
      'shipping': shipping,
      'tax_exempt': taxExempt,
      'test_clock': testClock,
    };
  }
}

class InvoiceSettings {
  final String? customFields;
  final String? defaultPaymentMethod;
  final String? footer;
  final String? renderingOptions;

  InvoiceSettings({
    this.customFields,
    this.defaultPaymentMethod,
    this.footer,
    this.renderingOptions,
  });

  factory InvoiceSettings.fromJson(Map<String, dynamic> json) {
    return InvoiceSettings(
      customFields: json['custom_fields'],
      defaultPaymentMethod: json['default_payment_method'],
      footer: json['footer'],
      renderingOptions: json['rendering_options'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'custom_fields': customFields,
      'default_payment_method': defaultPaymentMethod,
      'footer': footer,
      'rendering_options': renderingOptions,
    };
  }
}
