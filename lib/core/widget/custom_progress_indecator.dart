import 'package:flutter/material.dart';

import '../utils/color_resources.dart';

class CustomProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Set transparent background
      elevation: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CircularProgressIndicator(color: ColorResources.primaryColor,),
        ),
      ),
    );
  }
}
