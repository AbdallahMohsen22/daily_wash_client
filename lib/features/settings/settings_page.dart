import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/profile_app_bar.dart';
import 'package:on_express/features/settings/widget/active_notification.dart';
import 'package:on_express/features/settings/widget/language_widget.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (_, language, __) => DefaultScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            ProfileAppBar(
              title: 'Settings'.tr(),
            ),
            const Gap(30),
            LanguageWidget(languageProvider: language),
            // const Gap(30),
            // const ActiveNotificationWidget()
          ],
        ),
      ),
    );
  }
}
