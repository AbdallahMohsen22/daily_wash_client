import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/features/bottom_navigation_bar/navigation_view_model.dart';
import '../../core/componets/componets.dart';
import '../../core/constants/app_constants.dart';
import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/app_cubit/app_states.dart';
import '../../cubits/menu_cubit/menu_cubit.dart';
import '../../cubits/menu_cubit/menu_states.dart';
import '../wrong_screens/maintenance.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationViewModel navigationViewModel = NavigationViewModel();



  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).updateApp(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);
      },
      builder: (context, state) {
        return BlocConsumer<MenuCubit, MenuStates>(
          listener: (context, state) {
            if(isConnect!=null)checkNet(context);
            if(MenuCubit.get(context).settingsModel?.data?.isProjectInFactoryMode == 2){
              navigateAndFinish(context, Maintenance());
            }
          },
          builder: (context, state) {
            return BlocBuilder<GenericCubit<int>, GenericCubitState<int>>(
              bloc: navigationViewModel.navigationCubit,
              builder: (context, state) =>
                  Scaffold(
                      extendBodyBehindAppBar: true,
                      extendBody: true,
                      body: navigationViewModel.pages[state.data],
                      bottomNavigationBar: CurvedNavigationBar(
                        //height: AppSize.h80,
                        color: ColorResources.white,
                        buttonBackgroundColor: ColorResources.primaryColor,
                        index: state.data,
                        backgroundColor: Colors.transparent,
                        onTap: (index) {
                          navigationViewModel.setSelectedPage(index);
                        },
                        items: navigationViewModel.icons.map((e) {
                          int index = navigationViewModel.icons.indexOf(e);
                          return Padding(
                            padding: EdgeInsets.all(AppSize.h8),
                            child: CustomAssetImage(
                              fit: BoxFit.contain,
                              color: navigationViewModel.selectIndex == index
                                  ? ColorResources.white
                                  : Colors.grey,
                              imageUrl: navigationViewModel.icons[index],
                              height: navigationViewModel.selectIndex == index
                                  ? AppSize.h30
                                  : AppSize.h26,
                              width: navigationViewModel.selectIndex == index
                                  ? AppSize.h30
                                  : AppSize.h26,
                            ),
                          );
                        }).toList(),
                      )),
            );
          },
        );
      },
    );
  }
}
