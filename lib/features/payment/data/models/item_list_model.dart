class ItemListModel {
  final List<ItemModel> items;

  ItemListModel({
    required this.items,
  });

  // Factory method to create an ItemListModel from JSON
  factory ItemListModel.fromJson(Map<String, dynamic> json) {
    return ItemListModel(
      items: List<ItemModel>.from(
        json['items'].map((item) => ItemModel.fromJson(item)),
      ),
    );
  }

  // Method to convert an ItemListModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class ItemModel {
  final String name;
  final int quantity;
  final String price;
  final String currency;

  ItemModel({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });

  // Factory method to create an ItemModel from JSON
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      currency: json['currency'],
    );
  }

  // Method to convert an ItemModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'currency': currency,
    };
  }
}