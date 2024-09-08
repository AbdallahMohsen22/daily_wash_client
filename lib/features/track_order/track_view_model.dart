import 'dart:io';

import 'package:flutter/material.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackViewModel {
  Future<void> launchPhoneDialer(BuildContext context,String phone) async {
    final Uri phoneUri = Uri(scheme: "tel", path: phone);
    try {
      if (await canLaunch(phoneUri.toString())) {
        await launch(phoneUri.toString());
      }
    } on Exception {
      if (context.mounted) {
        UIAlert.showAlert(
          context,
          message: "Cannot dial",
          type: MessageType.error,
        );
      }
    }
  }

  Future<void> whatsapp(BuildContext context,String phone) async {
    var androidUrl = "whatsapp://send?phone=$phone&text=Your Message here";
    var iosUrl =
        "https://wa.me/$phone?text=${Uri.parse('Your Message here')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      if (context.mounted) {
        UIAlert.showAlert(
          context,
          message: 'WhatsApp is not installed.',
          type: MessageType.error,
        );
      }
    }
  }
}
