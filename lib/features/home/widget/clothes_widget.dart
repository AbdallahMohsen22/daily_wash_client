import 'package:flutter/material.dart';
import 'package:on_express/core/utils/image_resources.dart';

class ClothesCounterWidget extends StatelessWidget {
  final List<Map<String, String>> clothes;

  ClothesCounterWidget({super.key})
      : clothes = [
    {"image": ImageResources.pants, "label": "Pants"},
    {"image": ImageResources.pants, "label": "Shorts"},
    {"image": ImageResources.pants, "label": "Shirt"},
    {"image": ImageResources.pants, "label": "Jacket"},
    {"image": ImageResources.pants, "label": "T-Shirt"},
    {"image": ImageResources.pants, "label": "Vest"},
    {"image": ImageResources.pants, "label": "Shoes"},
    {"image": ImageResources.pants, "label": "Underwear"},
  ];

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
                _clothingItem(ImageResources.pants),
                _clothingItem(ImageResources.shorts),
                _clothingItem(ImageResources.shirt1),
                _clothingItem(ImageResources.shoes),
              ],
            ),
            SizedBox(height: 20), // Space between rows
            // Second Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _clothingItem(ImageResources.jacket),
                _clothingItem(ImageResources.blueDress),
                _clothingItem(ImageResources.bra),
                _clothingItem(ImageResources.shirt2),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _clothingItem(String imagePath) {
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
            SizedBox(
              width: 30,
              height: 30,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
