import 'package:flutter/material.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel {
  static Future<void> launchUrl(BuildContext context) async {
    String url = "https://pavilion-teck.com";
    try {
      if (await canLaunch(url)) {
        await launch(url);
      }
    } on Exception {
      if (context.mounted) {
        UIAlert.showAlert(
          context,
          message: "Cannot open url",
          type: MessageType.error,
        );
      }
    }
  }
}
