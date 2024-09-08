import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/base_app_bar.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/features/home/widget/laundromat_item.dart';
import 'package:on_express/features/search/widget/search_bar.dart';

import '../../core/widget/shimmer.dart';
import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/app_cubit/app_states.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = AppCubit.get(context);
    return DefaultScaffold(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          BaseAppBar(isBackExist: false),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBarWidget(),
                const Gap(15),
                Text(
                  "results_for".tr(),
                  style: FontManager.getMediumStyle(
                    fontSize: AppSize.sp14,
                    color: ColorResources.lightGrey2,
                  ),
                ),
                Text(
                  "all_clean_laundry".tr(),
                  style: FontManager.getBoldStyle(
                    fontSize: AppSize.sp24,
                    color: ColorResources.black,
                  ),
                ),
              ],
            ),
          ),
          ConditionalBuilder(
            condition: cubit.providersModel!=null && state is! GetProvidersLoadingState,
            fallback: (c)=>SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: CustomShimmer(width:context.width,
                        height:context.height * 0.15),
                  ),
                  childCount: 10),
            ),
            builder: (c)=> ConditionalBuilder(
                condition: cubit.providersModel!.data!.isNotEmpty,
                fallback: (c)=>SliverToBoxAdapter(child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(child: Text(
                      'no_laundries_yet'.tr(),
                      style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),
                    )))),
                builder: (c)
                {
                  // Future.delayed(Duration.zero,(){
                  //   cubit.paginationProviders(context);
                  // });
                  return   SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (context, index) => LaundromatItem(
                            provider: cubit
                                .providersModel!.data![index]),
                        childCount:
                        cubit.providersModel!.data!.length),
                  );
                }),
          ),
          if(state is GetProvidersLoadingState)
            const SliverToBoxAdapter(
              child: CupertinoActivityIndicator(),
            ),
          const SliverToBoxAdapter(
            child: Gap(70),
          )
        ],
      ),
    );
  },
);
  }
}
