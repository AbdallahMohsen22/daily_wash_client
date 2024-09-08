import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/image_resources.dart';

class Maintenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageResources.maintenance,width: double.infinity,height: 225,color:ColorResources.primaryColor),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                children: [
                  Text(
                    tr('maintenance_title'),
                    style: TextStyle(
                        color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 22
                    ),
                  ),
                  Text(
                    tr('maintenance_desc'),
                    style: TextStyle(
                        color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 11
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
