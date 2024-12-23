import 'package:flutter/material.dart';
import 'package:on_express/core/utils/image_resources.dart';

import '../../../models/providers_model.dart';

class ClothesCounterWidget extends StatefulWidget {
  final ProviderData? provider;

  ClothesCounterWidget({super.key, this.provider});

  @override
  _ClothesCounterWidgetState createState() => _ClothesCounterWidgetState();
}

class _ClothesCounterWidgetState extends State<ClothesCounterWidget> {
  final Map<int, int> _itemCounts = {}; // Tracks number of pieces entered
  double _totalCost = 0.0; // Tracks total cost

  void _updateItemCount(int index, int count, int price) {
    setState(() {
      _itemCounts[index] = count;
      _calculateTotalCost(price: price, index: index, count: count);
    });
  }

  void _calculateTotalCost({required int price, required int index, required int count}) {
    double sum = 0.0;
    _itemCounts.forEach((key, value) {
      final pricingItem = widget.provider?.pricingItems?[key];
      if (pricingItem != null) {
        sum += value * (pricingItem.price ?? 0);
      }
    });
    _totalCost = sum;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildClothingItem(0, ImageResources.pants),
                _buildClothingItem(1, ImageResources.shorts),
                _buildClothingItem(2, ImageResources.shirt1),
                _buildClothingItem(3, ImageResources.shoes),
              ],
            ),
            SizedBox(height: 20),
            // Second Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildClothingItem(4, ImageResources.jacket),
                _buildClothingItem(5, ImageResources.blueDress),
                _buildClothingItem(6, ImageResources.bra),
                _buildClothingItem(7, ImageResources.shirt2),
              ],
            ),
            SizedBox(height: 20),
            // Total Cost Display
            Text(
              "Laundry fees: ${_totalCost.toStringAsFixed(2)} AED",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClothingItem(int index, String imagePath) {
    // Check if the index is valid
    if (widget.provider?.pricingItems != null && index < widget.provider!.pricingItems!.length) {
      final price = widget.provider!.pricingItems![index].price ?? 0;
      return _clothingItem(imagePath, _textField(index, price));
    } else {
      // If the index is invalid, display a placeholder or empty widget
      return _clothingItem(imagePath, _textField(index, 0, isPlaceholder: true));
    }
  }

  Widget _clothingItem(String imagePath, Widget textField) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              imagePath,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 8), // Space between image and text field
            textField,
          ],
        ),
      ],
    );
  }

  Widget _textField(int index, int price, {bool isPlaceholder = false}) {
    return SizedBox(
      width: 30,
      height: 30,
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.3)),
          hintText: isPlaceholder ? "X" : "0",
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
        ),
        keyboardType: TextInputType.number,
        enabled: !isPlaceholder, // Disable input for placeholder
        onChanged: (value) {
          final count = int.tryParse(value) ?? 0;
          _updateItemCount(index, count, price);
        },
      ),
    );
  }
}
