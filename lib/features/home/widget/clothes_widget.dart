import 'package:flutter/material.dart';

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
      _calculateTotalCost();
    });
  }

  void _calculateTotalCost() {
    double sum = 0.0;
    _itemCounts.forEach((key, value) {
      final pricingItem = widget.provider?.serviceDetails?.services?['Clothes']?[key];
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Services Details Grid
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 items per row
                crossAxisSpacing: 8,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8, // Adjust for better spacing
              ),
              itemCount: widget.provider?.serviceDetails?.services?['Clothes']?.length ?? 0,
              itemBuilder: (context, index) {
                return _buildClothingItem(index);
              },
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

  Widget _buildClothingItem(int index) {
    if (widget.provider?.serviceDetails?.services != null && index < (widget.provider!.serviceDetails?.services?['Clothes']?.length ?? 0)) {
      final item = widget.provider!.serviceDetails?.services?['Clothes']?[index];
      final price = item?.price ?? 0;
      final iconPath = item?.icon ?? ''; // Assuming 'icon' holds the image path
      final name = item?.name ?? 'Item';

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Image.network(
            iconPath,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8),
          // Name
          Text(
            name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          // Price
          Text(
            "$price AED",
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          SizedBox(height: 4),
          // Counter
          _textField(index, price),
        ],
      );
    } else {
      // Placeholder if item not available
      return SizedBox.shrink();
    }
  }

  Widget _textField(int index, int price) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
          hintText: "0",
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          final count = int.tryParse(value) ?? 0;
          _updateItemCount(index, count, price);
        },
      ),
    );
  }
}
