import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/features/addresses/widget/address_item.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';
import '../../../core/componets/componets.dart';
import '../../../cubits/app_cubit/app_cubit.dart';
import '../../../cubits/menu_cubit/menu_cubit.dart';
import '../../../cubits/menu_cubit/menu_states.dart';
import '../../addresses/add_address_page.dart';

class UserAddressWidget extends StatefulWidget {
  const UserAddressWidget({super.key, required this.storeDetailsViewModel});
  final StoreDetailsViewModel storeDetailsViewModel;

  @override
  State<UserAddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<UserAddressWidget> {
  bool showMore = false;


  @override
  void initState() {
    if(MenuCubit.get(context).addressesModel?.data?.length == 1){
      AppCubit.get(context).chooseAddress(
          0,
          LatLng(
              double.parse(MenuCubit.get(context).addressesModel?.data?[0].latitude??''),
              double.parse(MenuCubit.get(context).addressesModel?.data?[0].longitude??'')
      ));
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "address".tr(),
            style: FontManager.getMediumStyle(
              fontSize: AppSize.sp18,
              color: ColorResources.kFormTitleColor,
            ),
          ),
          const Gap(5),
          ConditionalBuilder(
            condition: MenuCubit.get(context).addressesModel!=null,
            fallback: (c)=>Center(child: CupertinoActivityIndicator(),),
            builder: (c)=> ConditionalBuilder(
              condition: MenuCubit.get(context).addressesModel!.data!.isNotEmpty,
              fallback: (c)=>Center(
                child: Text(
                  'no_address'.tr()
                ),
              ),
              builder: (c)=>SizedBox(
                height: MenuCubit.get(context).addressesModel!.data!.length ==1?150:280,
                child: SingleChildScrollView(
                  child: Column(
                    children: MenuCubit.get(context).addressesModel!.data!.map((e) {
                      int index = MenuCubit.get(context).addressesModel!.data!.indexOf(e);
                      return InkWell(
                        onTap: (){
                          AppCubit.get(context).chooseAddress(
                            index,
                            LatLng(double.parse(e.latitude??''), double.parse(e.longitude??''))
                          );
                        },
                        child: AddressItem(
                          addressModel: e,
                          isSelected: AppCubit.get(context).currentAddressIndex != -1
                              ?AppCubit.get(context).currentAddressIndex == index
                              :false,
                          isEdit: true,
                          isDefualt: true,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          const Gap(15),
          Align(
            alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showMore = !showMore;
                      });
                    },
                    child: Text(
                      showMore?"less".tr():"more".tr(),
                      style: FontManager.getMediumStyle(
                        fontSize: AppSize.sp14,
                        color: ColorResources.primaryColor,
                      ).copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ),
          !showMore
              ? const SizedBox()
              : Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(15),
                      ConditionalBuilder(
                        condition: AppCubit.get(context).addressController.text.isEmpty,
                        fallback: (c)=>Text(
                          AppCubit.get(context).addressController.text,
                          style: FontManager.getMediumStyle(
                            fontSize: AppSize.sp14,
                            color: ColorResources.black,
                          ),
                        ),
                        builder: (c)=> CustomButton(
                          title: "use_current_address".tr(),
                          isSelected: true,
                          onTap: () {
                            AppCubit.get(context).chooseMyCurrentLocation(context);

                          },
                        ),
                      ),
                      const Gap(15),
                      CustomButton(
                        title: "add_new_address".tr(),
                        isSelected: false,
                        onTap: ()async {
                          if (AppCubit.get(context).position != null) {
                            navigateTo(context, AddNewAddressPage());
                          } else {
                            await AppCubit.get(context).getCurrentLocation(context);
                            navigateTo(context, AddNewAddressPage());
                          }
                        },
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  },
);
  }
}
