import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/widget/base_app_bar.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/features/home/home_view_model.dart';
import 'package:on_express/features/home/widget/ads/aids_widget.dart';
import 'package:on_express/features/home/widget/laundromat_item.dart';
import 'package:on_express/models/providers_model.dart';

import '../../core/utils/color_resources.dart';
import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/app_cubit/app_states.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  HomeViewModel homeViewModel = HomeViewModel();
  List<ProviderData>? displayedItems;

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getProviders();

    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      _updateDisplayedItems(_tabController!.index);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateDisplayedItems(0); // Default to Clothes category
    });
  }

  void _updateDisplayedItems(int index) {
    final cubit = AppCubit.get(context);
    setState(() {
      if (index == 0) {
        displayedItems = cubit.providersModel?.data
            ?.where((item) => item.serviceDetails?.house != null)
            .toList();
      } else if (index == 1) {
        displayedItems = cubit.providersModel?.data
            ?.where((item) => item.serviceDetails?.cars != null)
            .toList();
      } else if (index == 2) {
        displayedItems = cubit.providersModel?.data
            ?.where((item) => item.serviceDetails?.clothes != null)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: DefaultScaffold(
            haveBackground: true,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: displayedItems != null
                  ? cubit.providersScrollerController
                  : null,
              slivers: [
                BaseAppBar(isBackExist: false),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      AdsWidget(homeViewModel: homeViewModel),
                      const Gap(15),
                      TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(
                            icon: Icon(
                              Icons.house,
                              size: 30,
                              color: ColorResources.primaryColor,
                            ),
                            text: 'House'.tr(),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.directions_car,
                              size: 30,
                              color: ColorResources.primaryColor,
                            ),
                            text: 'Cars'.tr(),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.local_laundry_service,
                              size: 30,
                              color: ColorResources.primaryColor,
                            ),
                            text: 'Clothes'.tr(),
                          ),
                        ],
                        indicatorColor: ColorResources.primaryColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: ColorResources.primaryColor,
                        unselectedLabelColor: ColorResources.black,
                        dividerColor: Colors.transparent,
                        // isScrollable: true,
                      ),
                    ],
                  ),
                ),
                if (state is GetProvidersLoadingState)
                  const SliverToBoxAdapter(
                    child: Center(child: CupertinoActivityIndicator()),
                  )
                else if (displayedItems != null && displayedItems!.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => LaundromatItem(
                        provider: displayedItems![index],
                      ),
                      childCount: displayedItems!.length,
                    ),
                  )
                else if (displayedItems == null || displayedItems!.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: Text(
                          'no_laundries_yet'.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: Gap(70)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
