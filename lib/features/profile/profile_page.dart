import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/base_app_bar.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/features/profile/widget/user_avatar.dart';
import 'package:on_express/features/profile/widget/user_menu.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widget/login_widget.dart';
import '../../cubits/menu_cubit/menu_cubit.dart';
import '../../cubits/menu_cubit/menu_states.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Consumer<LanguageProvider>(
          builder: (_, language, __) =>
              DefaultScaffold(
                child: ConditionalBuilder(
                  condition: token != null,
                  fallback: (context) => LoginWidget(),
                  builder: (context) =>
                      CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          BaseAppBar(
                            isBackExist: false,
                            haveLogo: false,
                            title: Text(
                              "my_profile".tr(),
                              style: FontManager.getSemiBold(
                                fontSize: AppSize.sp20,
                                color: ColorResources.black,
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: UserAvatar(),
                                ),
                                Gap(15),
                                UserMenu()
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: Gap(100),
                          )
                        ],
                      ),
                ),
              ),
        );
      },
    );
  }
}
