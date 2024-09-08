import 'package:flutter/material.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/features/home/home_page.dart';
import 'package:on_express/features/profile/profile_page.dart';
import 'package:on_express/features/requests/requests_page.dart';
import 'package:on_express/features/search/search_page.dart';

class NavigationViewModel {
  GenericCubit<int> navigationCubit = GenericCubit(0);

  List<Widget> pages = [
    HomePage(),
    const SearchPage(),
    const RequestsPage(),
    const ProfilePage()
  ];

  List<String> icons = [
    ImageResources.home,
    ImageResources.search,
    ImageResources.requests,
    ImageResources.profile,
  ];

  int selectIndex = 0;

  void setSelectedPage(int index) {
    navigationCubit.onLoadingState();
    selectIndex = index;
    navigationCubit.onUpdateData(selectIndex);
  }
}
