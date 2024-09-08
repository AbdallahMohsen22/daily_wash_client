import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAssetImage extends StatelessWidget {
  CustomAssetImage(
      {super.key,
      required this.imageUrl,
      required this.height,
      required this.width,
      this.fit,
      this.color});

  final String imageUrl;
  final double height;
  final double width;
  BoxFit? fit;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageUrl,
      color: color,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
    );
  }
}
