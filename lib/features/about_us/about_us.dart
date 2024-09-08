import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/shared/language_view_model.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/features/favourites/widget/favourites_app_bar.dart';
import 'package:provider/provider.dart';

import '../../core/widget/shimmer.dart';
import '../../cubits/menu_cubit/menu_cubit.dart';
import '../../cubits/menu_cubit/menu_states.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MenuCubit.get(context);
        return DefaultScaffold(
          child: Consumer<LanguageProvider>(
            builder: (_, language, __) => CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const FavouritesAppBar(),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'about_us'.tr(),
                        style: FontManager.getSemiBold(
                          fontSize: AppSize.sp20,
                          color: ColorResources.black,
                        ),
                      )
                    ],
                  ),
                ),
                ConditionalBuilder(
                  condition: cubit.staticPagesModel!=null,
                  fallback: (c)=>SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: CustomShimmer(width: double.infinity, height: 20),
                      ),
                      childCount: 20
                    ),
                  ),
                  builder: (c)=> SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      child: Html(
                        data:language.appLanguage == 'en'
                            ?cubit.staticPagesModel?.data?.aboutUsEn??''
                            :cubit.staticPagesModel?.data?.aboutUsAr??'',
                      ),
                    )
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Gap(40),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
