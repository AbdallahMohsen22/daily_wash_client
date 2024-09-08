import 'package:flutter/material.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/addresses/model/address_model.dart';

class AddressViewModel {
  GenericCubit<List<AddressModel>?> addressCubit = GenericCubit(null);
  int selectedAddress = -1;

  List<AddressModel> addresses = [
    AddressModel(title: "Home", location: "26985 Brighton.."),
    AddressModel(title: "Gym", location: "26985 Brighton.."),
    AddressModel(title: "Work", location: "26985 Brighton.."),
  ];

  void setSelectedAddress(int index) {
    addressCubit.onLoadingState();
    selectedAddress = index;
    addressCubit.onUpdateData(addresses);
  }

  void addNewAddress(BuildContext context, String title, String location) {
    addressCubit.onLoadingState();
    final newAddress = AddressModel(title: title, location: location);
    addresses.add(newAddress);

    addressCubit.onUpdateData(addresses);
    showAlertMessage(
      context,
      message: "address added successfully ",
      type: MessageType.success,
    ).then((value) {
      Navigator.pop(context);
    });
  }

  Future<void> showAlertMessage(BuildContext context,
      {required String message, required MessageType type}) async {
    UIAlert.showAlert(
      context,
      message: message,
      type: type,
    );
  }
}
