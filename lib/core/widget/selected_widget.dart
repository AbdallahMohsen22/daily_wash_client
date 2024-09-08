import 'package:flutter/material.dart';
import 'package:on_express/core/utils/color_resources.dart';

class SelectedWidget extends StatelessWidget {
  const SelectedWidget({
    super.key,
    required this.isSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorResources.grey2,
      ),
      child: Center(
        child: Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? ColorResources.primaryColor : null,
          ),
        ),
      ),
    );
  }
}
