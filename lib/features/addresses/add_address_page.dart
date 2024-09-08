import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/profile_app_bar.dart';
import 'package:on_express/features/addresses/address_view_model.dart';
import 'package:on_express/features/addresses/widget/add_new_address_from.dart';
import 'package:on_express/models/addresses_model.dart';

class AddNewAddressPage extends StatelessWidget {
  AddNewAddressPage({
    super.key,
    this.data,
  });

  AddressesData? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ProfileAppBar(
                title: 'add_new_address'.tr(),
              ),
            ),
          ),
          Expanded(child: AddNewAddressForm(data: data))
        ],
      ),
    );
  }
}
