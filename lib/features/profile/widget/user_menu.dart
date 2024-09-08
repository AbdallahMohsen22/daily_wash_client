import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/config/routes/app_route.dart';
import 'package:on_express/core/cache/cache_manger.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/constants/app_constants.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_asset_image.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/login/login_page.dart';
import 'package:on_express/features/profile/profile_view_model.dart';
import 'package:on_express/features/profile/widget/delete_account_body.dart';
import 'package:on_express/features/profile/widget/menu_item.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../../cubits/menu_cubit/menu_cubit.dart';
import '../../../cubits/menu_cubit/menu_states.dart';
import '../../contect_us/contactus_screen.dart';
import '../../settings/widget/change_language_widget.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({super.key});

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  String version = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version = packageInfo.version;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (_, language, __) =>
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuItem(
                  imageUrl: ImageResources.edit,
                  title: 'edit_profile'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.editProfilePage);
                  },
                ),
                const Gap(20),
                MenuItem(
                  imageUrl: ImageResources.setting,
                  title: 'Settings'.tr(),
                  onTap: () {
                    UIAlert.buildCustomBottomSheet(
                      context,
                      ChangeLanguageWidget(
                        languageProvider: language,
                      ),
                    );
                  },
                ),
                const Gap(20),
                MenuItem(
                  imageUrl: ImageResources.favourites,
                  title: 'favorite_stores'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.favoritesPage);
                  },
                ),
                const Gap(20),
                MenuItem(
                  imageUrl: ImageResources.address,
                  title: 'my_addresses'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.addressPage);
                  },
                ),
                const Gap(20),
                MenuItem(
                  imageUrl: ImageResources.aboutUs,
                  title: 'about_us'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.aboutUsPage);
                  },
                ),
                const Gap(20),
                MenuItem(
                  imageUrl: ImageResources.terms,
                  title: 'terms_conditions'.tr(),
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.termsAndConditionsPage);
                  },
                ),
                const Gap(20),
                MenuItem(
                  imageUrl: ImageResources.contactUs,
                  title: 'contact_us'.tr(),
                  onTap: () {
                    navigateTo(context, ContactUsScreen());
                  },
                ),
                const Gap(20),
                // PowerByWidget(version: version),
                const Gap(15),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      CustomButton(
                        title: 'delete_account'.tr(),
                        isSelected: true,
                        onTap: () {
                          UIAlert.buildCustomBottomSheet(
                            context,
                            BlocConsumer<MenuCubit, MenuStates>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return BottomSheetBody(
                                  imageUrl: ImageResources.deleteAccount,
                                  button: ConditionalBuilder(
                                    condition: state is! DeleteAccountLoadingState,
                                    fallback: (c)=>SizedBox(width:double.infinity,child: CupertinoActivityIndicator()),
                                    builder: (c)=> CustomButton(
                                      isSelected: true,
                                      title: 'delete_account'.tr(),
                                      onTap: () {
                                        MenuCubit.get(context).deleteAccount(context);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const Gap(15),
                      GestureDetector(
                        onTap: () {
                          UIAlert.buildCustomBottomSheet(
                            context,
                            BottomSheetBody(
                              imageUrl: ImageResources.logout2,
                              button: CustomButton(
                                isSelected: true,
                                title: 'logout'.tr(),
                                onTap: () {
                                  token = null;
                                  userId = null;
                                  CacheManager.remove('token');
                                  CacheManager.remove('userId');
                                  navigateTo(context, LoginPage());
                                },
                              ),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomAssetImage(
                              imageUrl: ImageResources.logout,
                              height: AppSize.h20,
                              width: AppSize.w20,
                            ),
                            const Gap(10),
                            Text(
                              "logout".tr(),
                              style: FontManager.getSemiBold(
                                fontSize: AppSize.sp20,
                                color: ColorResources.black,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(10),
              ],
            ),
          ),
    );
  }
}

class PowerByWidget extends StatelessWidget {
  const PowerByWidget({
    super.key,
    required this.version,
  });

  final String version;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProfileViewModel.launchUrl(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "power_by".tr(),
                style: FontManager.getLightStyle(
                  fontSize: AppSize.sp16,
                  color: ColorResources.black10,
                ),
              ),
              const Gap(4),
              CustomAssetImage(
                imageUrl: ImageResources.tG,
                height: AppSize.h20,
                width: AppSize.w20,
              )
            ],
          ),
          Text(
            "${"version".tr()} $version",
            style: FontManager.getLightStyle(
              fontSize: AppSize.sp16,
              color: ColorResources.black10,
            ),
          ),
        ],
      ),
    );
  }
}
