import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/base_app_bar.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/shimmer.dart';
import 'package:on_express/features/notifications/widget/notification_item.dart';

import '../../cubits/menu_cubit/menu_cubit.dart';
import '../../cubits/menu_cubit/menu_states.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    MenuCubit.get(context).getNotification();
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MenuCubit.get(context);
        return DefaultScaffold(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              BaseAppBar(
                isBackExist: true,
                title: Text(
                  'notifications'.tr(),
                  style: FontManager.getSemiBold(
                    fontSize: AppSize.sp20,
                    color: ColorResources.black,
                  ),
                ),
                notification: const SizedBox(),
              ),
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  cubit.getNotification();
                },
              ),
              ConditionalBuilder(
                condition: cubit.notificationModel!=null,
                fallback: (context)=>SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: CustomShimmer(height: 200,width: double.infinity),
                        ),
                    childCount: 5,
                  ),
                ),
                builder: (context)=> ConditionalBuilder(
                  condition: cubit.notificationModel!.data!.data!.isNotEmpty,
                  fallback: (context)=>SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Gap(60),
                          Image.asset(ImageResources.noNotifications,height: 340,),
                          const Gap(20),
                          Text(
                              'no_notification_yet'.tr(),
                            style: FontManager.getSemiBold(color: ColorResources.black,fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  builder: (context){
                    cubit.paginationAllNotification(context);
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                            NotificationItem(
                              notificationModel:cubit.notificationModel!.data!.data![index],
                            ),
                        childCount: cubit.notificationModel!.data!.data!.length,
                      ),
                    );
                  },
                ),
              ),
              if(state is GetNotificationLoadingState)
              const SliverToBoxAdapter(
                child: CupertinoActivityIndicator(),
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
