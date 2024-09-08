import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/shimmer.dart';
import 'package:on_express/features/addresses/add_address_page.dart';
import 'package:on_express/features/addresses/address_view_model.dart';
import 'package:on_express/features/addresses/widget/address_item.dart';
import 'package:on_express/features/favourites/widget/favourites_app_bar.dart';

import '../../core/componets/componets.dart';
import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/menu_cubit/menu_cubit.dart';
import '../../cubits/menu_cubit/menu_states.dart';


class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  AddressViewModel addressViewModel = AddressViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MenuCubit.get(context);
        return DefaultScaffold(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const FavouritesAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'my_addresses'.tr(),
                      style: FontManager.getSemiBold(
                        fontSize: AppSize.sp20,
                        color: ColorResources.black,
                      ),
                    )
                  ],
                ),
              ),
              ConditionalBuilder(
                condition: cubit.addressesModel!=null && state is! AddressLoadingState,
                fallback: (c)=>SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: CustomShimmer(
                              width: double.infinity,
                              height: context.height * 0.13,
                            ),
                          ),
                      childCount: 3
                  ),
                ),
                builder: (c)=> ConditionalBuilder(
                  condition: cubit.addressesModel!.data!.isNotEmpty,
                  fallback: (c)=>SliverToBoxAdapter(
                    child: Text('No Addresses Yet'),
                  ),
                  builder: (c)=> SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (c, i) => AddressItem(
                              addressModel: cubit.addressesModel!.data![i],
                              isSelected: cubit.addressesModel?.data?[i].isDefault == true,
                            ),
                        childCount: cubit.addressesModel!.data!.length
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: Gap(30)),
              SliverToBoxAdapter(
                child: CustomButton(
                  title: 'add_new_address'.tr(),
                  isSelected: true,
                  iconImage: ImageResources.add,
                  onTap: () async {
                    if (AppCubit.get(context).position != null) {
                      navigateTo(context, AddNewAddressPage());
                    } else {
                      await AppCubit.get(context).getCurrentLocation(context);
                      navigateTo(context, AddNewAddressPage());
                    }
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: Gap(40),
              )
            ],
          ),
        );
      },
    );
  }
}
