import 'package:flutter/material.dart';

import '../../../../../core/utils/color_resources.dart';

class OrderInfoItem extends StatelessWidget {
  const OrderInfoItem({super.key, required this.title, required this.value});
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style:  TextStyle(
            color: ColorResources.primaryColor
          ),
        ),
        const Spacer(),
        Text(
          value,
          textAlign: TextAlign.center,
          style:  TextStyle(
              color: ColorResources.primaryColor
          ),
        )
      ],
    );
  }
}
