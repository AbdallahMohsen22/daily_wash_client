import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/widget/ui.dart';


class Update extends StatelessWidget {
  Update({
    required this.releaseNote,
    required this.url,
  });
  String url;
  String releaseNote;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageResources.update,width: double.infinity,height: 225,color:ColorResources.primaryColor),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Column(
                children: [
                  Text(
                    tr('update_title'),
                    style: TextStyle(
                        color: Colors.black87,fontWeight: FontWeight.w500,fontSize: 22
                    ),
                  ),
                  Text(
                    releaseNote,
                    style: TextStyle(
                        color: Colors.grey.shade600,fontWeight: FontWeight.w500,fontSize: 11
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
                title: tr('update_now'),
                isSelected: true,
                onTap: ()async{
                  if(await canLaunchUrl(Uri.parse(url))){
                  await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
                  }else{
                    UIAlert.showAlert(context,message:'This Url can\'t launch',type: MessageType.error);
                  }
                }
            )
          ],
        ),
      ),
    );
  }
}
