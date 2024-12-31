import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/base_app_bar.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/shimmer.dart';
import 'package:on_express/features/home/home_view_model.dart';
import 'package:on_express/features/home/widget/ads/aids_widget.dart';
import 'package:on_express/features/home/widget/laundromat_item.dart';

import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/app_cubit/app_states.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel homeViewModel = HomeViewModel();
  String? selectedCategory; // Holds the currently selected category

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getCurrentLocation(context);
    AppCubit.get(context).getProviders();
    // AppCubit.get(context).getCars();
    // AppCubit.get(context).getHouses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        // Decide which data to display based on the selected category
        List<dynamic>? displayedItems;
        if (selectedCategory == 'laundry') {
          displayedItems = cubit.providersModel?.data;
        } else if (selectedCategory == 'car') {
          displayedItems = cubit.carsModel?.data;
        } else if (selectedCategory == 'house') {
          displayedItems = cubit.housesModel?.data;
        }

        return DefaultScaffold(
          haveBackground: true,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: displayedItems != null ? cubit.providersScrollerController : null,
            slivers: [
              BaseAppBar(
                isBackExist: false,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    AdsWidget(homeViewModel: homeViewModel),
                    const Gap(15),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'house';
                          });
                        },
                        child: Image.asset(ImageResources.houseClean),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'car';
                          });
                        },
                        child: Image.asset(ImageResources.carClean),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'laundry';
                          });
                        },
                        child: Image.asset(ImageResources.laundryClean),
                      ),
                    ),
                  ],
                ),
              ),
              if (displayedItems != null && displayedItems.isNotEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => LaundromatItem(provider: displayedItems![index]),
                    childCount: displayedItems.length,
                  ),
                )
              else if (displayedItems == null || displayedItems.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text(
                        'no_items_found'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              if (state is GetProvidersLoadingState)
                const SliverToBoxAdapter(
                  child: CupertinoActivityIndicator(),
                ),
              const SliverToBoxAdapter(
                child: Gap(70),
              ),
            ],
          ),
        );
      },
    );
  }
}

