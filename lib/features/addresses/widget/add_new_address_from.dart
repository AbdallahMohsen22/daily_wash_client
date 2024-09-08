import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/custom_feild.dart';
import '../../../cubits/app_cubit/app_cubit.dart';
import '../../../cubits/menu_cubit/menu_cubit.dart';
import '../../../cubits/menu_cubit/menu_states.dart';
import '../../../models/addresses_model.dart';
import 'apartment_dialog.dart';
import 'house_dialog.dart';
import 'office_dialog.dart';

class AddNewAddressForm extends StatefulWidget {
  AddNewAddressForm({
    super.key,
    this.data,
  });

  AddressesData? data;


  @override
  State<AddNewAddressForm> createState() => _AddNewAddressFormState();
}

class _AddNewAddressFormState extends State<AddNewAddressForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController addressTitleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final FocusNode addressTitleFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  late LatLng latLng;
  Marker? marker;
  String? type;
  ApartmentDialog apartmentDialog = ApartmentDialog();
  HouseDialog houseDialog = HouseDialog();
  OfficeDialog officeDialog = OfficeDialog();


  @override
  void initState() {
    if(widget.data!=null){
      addressTitleController.text = widget.data?.title??'';
      latLng = LatLng(
          double.parse(widget.data?.latitude??'25.2048'),
          double.parse(widget.data?.longitude??'55.2708')
      );
      getAddress(latLng);
      Future.delayed(Duration.zero,(){
        if(addressTitleController.text == 'apartment'){
          apartmentDialog.buildingNameController.text = widget.data?.addressInformation?.buildingName??'';
          apartmentDialog.floorNumberController.text = widget.data?.addressInformation?.floorNumber??'';
          apartmentDialog.apartmentNumberController.text = widget.data?.addressInformation?.apartmentNumber??'';
          apartmentDialog.notesController.text = widget.data?.addressInformation?.distinguishedLandmark??'';
        }else if(addressTitleController.text == 'house'){
          houseDialog.houseNumberController.text = widget.data?.addressInformation?.apartmentNumber??'';
          houseDialog.notesController.text = widget.data?.addressInformation?.distinguishedLandmark??'';
        }else if(addressTitleController.text == 'office'){
          officeDialog.buildingNameController.text = widget.data?.addressInformation?.buildingName??'';
          officeDialog.floorNumberController.text = widget.data?.addressInformation?.floorNumber??'';
          officeDialog.officeNumberController.text = widget.data?.addressInformation?.apartmentNumber??'';
          officeDialog.notesController.text = widget.data?.addressInformation?.distinguishedLandmark??'';
        }
        chooseTitle(addressTitleController.text);
      });
    }else{
      latLng = LatLng(
          AppCubit.get(context).position?.latitude??25.2048,
          AppCubit.get(context).position?.longitude??55.2708
      );
      getAddress(latLng);
    }
    super.initState();
  }


  void getAddress(LatLng latLng) async {
    String location;
    List<Placemark> place = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: 'en');
    Placemark placeMark = place[0];
    location = placeMark.street ?? '';
    location += ', ${placeMark.country ?? ''}';
    addressController.text = location;
    marker = Marker(
        markerId: MarkerId('origin'),
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(10)
    );
    setState(() {});
  }

  void submit(BuildContext context){
    print(apartmentDialog.floorNumberController.text);
    print(apartmentDialog.buildingNameController.text);
    print(apartmentDialog.notesController.text);
  if (formKey.currentState!.validate()) {
      if(widget.data!=null){
        if(type == 'apartment'){
          MenuCubit.get(context).updateAddress(
            context: context,
            title: type??'',
            latitude: latLng.latitude,
            longitude: latLng.longitude,
            apartmentNumber: apartmentDialog.apartmentNumberController.text,
            buildingName: apartmentDialog.buildingNameController.text,
            distinguishedLandmark: apartmentDialog.notesController.text,
            floorNumber: apartmentDialog.floorNumberController.text,
            id: widget.data?.id??''
          );
        }else if(type == 'house'){
          MenuCubit.get(context).updateAddress(
            context: context,
            title: type??'',
            latitude: latLng.latitude,
            longitude: latLng.longitude,
            apartmentNumber: houseDialog.houseNumberController.text,
            distinguishedLandmark: houseDialog.notesController.text,
            id: widget.data?.id??''
          );
        }else if(type == 'office'){
          MenuCubit.get(context).updateAddress(
            context: context,
            title: type??'',
            latitude: latLng.latitude,
            longitude: latLng.longitude,
            apartmentNumber: officeDialog.officeNumberController.text,
            buildingName: officeDialog.buildingNameController.text,
            distinguishedLandmark: officeDialog.notesController.text,
            floorNumber: officeDialog.floorNumberController.text,
            id: widget.data?.id??''

          );
        }else{
          MenuCubit.get(context).updateAddress(
            context: context,
            title: type??'',
            latitude: latLng.latitude,
            longitude: latLng.longitude,
            id: widget.data?.id??''
          );
        }
      }else{
        AppCubit.get(context).orderLatLng =
            LatLng(latLng.latitude, latLng.longitude);
        if(type == 'apartment'){
          MenuCubit.get(context).addAddress(
            context: context,
            title: type??'',
            latitude: latLng.latitude,
            longitude: latLng.longitude,
            apartmentNumber: apartmentDialog.apartmentNumberController.text,
            buildingName: apartmentDialog.buildingNameController.text,
            distinguishedLandmark: apartmentDialog.notesController.text,
            floorNumber: apartmentDialog.floorNumberController.text,
          );
        }else if(type == 'house'){
          MenuCubit.get(context).addAddress(
            context: context,
            title: type??'',
            latitude: latLng.latitude,
            longitude: latLng.longitude,
            apartmentNumber: houseDialog.houseNumberController.text,
            distinguishedLandmark: houseDialog.notesController.text,
          );
        }else if(type == 'office'){
          MenuCubit.get(context).addAddress(
            context: context,
            title: type??'',
            latitude: latLng.latitude,
            longitude: latLng.longitude,
            apartmentNumber: officeDialog.officeNumberController.text,
            buildingName: officeDialog.buildingNameController.text,
            distinguishedLandmark: officeDialog.notesController.text,
            floorNumber: officeDialog.floorNumberController.text,
          );
        }else{
          MenuCubit.get(context).addAddress(
            context: context,
            title: type??'',
            latitude: latLng.latitude,
            longitude: latLng.longitude,
          );
        }
      }
    }
  }


  @override
  void dispose() {
    super.dispose();
    addressTitleController.dispose();
    addressController.dispose();
    addressTitleFocusNode.dispose();
    addressFocusNode.dispose();
  }


  void chooseTitle (String type){
    setState(() {
      this.type = type;
      addressTitleController.text = type.tr();
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: latLng,
                  zoom: 14,
                ),
                onTap: (LatLng latLng) {
                  this.latLng = latLng;
                  getAddress(latLng);
                },
                myLocationButtonEnabled: false,
                markers: {
                  if(marker!=null)marker!
                },
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          buttonBuilder(
                            onTap: (){
                              chooseTitle('apartment');
                              showDialog(
                                  context: context,
                                  builder: (context) =>apartmentDialog);
                            },
                            title: 'apartment'.tr()
                          ),
                          const Gap(20),
                          buttonBuilder(
                              onTap: (){
                                addressTitleController.text = 'house';
                                chooseTitle('house');

                                showDialog(
                                    context: context,
                                    builder: (context) =>houseDialog
                                );
                              },
                              title: 'house'.tr()
                          ),
                          const Gap(20),
                          buttonBuilder(
                              onTap: (){
                                addressTitleController.text = 'office';
                                chooseTitle('office');

                                showDialog(
                                    context: context,
                                    builder: (context) =>officeDialog);
                              },
                              title: 'office'.tr()
                          ),
                        ],
                      ),
                      const Gap(15),
                      CustomField(
                          filled: true,
                          inputType: TextInputType.text,
                          focusNode: addressTitleFocusNode,
                          readOnly: true,
                          nextFocus: addressFocusNode,
                          hint: "address_title".tr(),
                          controller: addressTitleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "address_title_required".tr();
                            }
                            return null;
                          }),
                       const Gap(15),
                      CustomField(
                          filled: true,
                          inputType: TextInputType.text,
                          focusNode: addressFocusNode,
                          hint: "182256, Tillman, North Glena.....",
                          controller: addressController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "address_required".tr();
                            }
                            return null;
                          }),
                      const Gap(30),
                      Align(
                        alignment: Alignment.center,
                        child: ConditionalBuilder(
                          condition: state is! AddressLoadingState,
                          fallback: (c)=>CupertinoActivityIndicator(),
                          builder: (c)=> CustomButton(
                            title: "save".tr(),
                            onTap:()=>submit(context),
                            isSelected: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buttonBuilder({
    required String title,
    required VoidCallback onTap,
}){
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorResources.primaryColor,
            borderRadius: BorderRadiusDirectional.circular(15)

          ),
          alignment: AlignmentDirectional.center,
          child: Text(
            title,
            style: FontManager.getMediumStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
