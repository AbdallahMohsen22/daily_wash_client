import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/base_app_bar.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/login_widget.dart';
import 'package:on_express/core/widget/shimmer.dart';
import 'package:on_express/features/requests/model/request_model.dart';
import 'package:on_express/features/requests/requests_view_model.dart';
import 'package:on_express/features/requests/widget/request_item.dart';
import 'package:on_express/features/requests/widget/request_status.dart';
import '../../core/constants/app_constants.dart';
import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/app_cubit/app_states.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  RequestViewModel requestViewModel = RequestViewModel();

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getOrders();
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = AppCubit.get(context);
    return DefaultScaffold(
      child: ConditionalBuilder(
        condition: token!=null,
        fallback: (context)=>LoginWidget(),
        builder: (context)=> CustomScrollView(
          controller: cubit.ordersModel!=null?cubit.ordersScrollerController:null,
          physics: const BouncingScrollPhysics(),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: ()async{
                Future.delayed(Duration.zero,(){
                  cubit.getOrders();
                });
              },
            ),
            BaseAppBar(
              isBackExist: false,
              haveLogo: false,
              title: Text(
                "my_requests".tr(),
                style: FontManager.getSemiBold(
                  fontSize: AppSize.sp20,
                  color: ColorResources.black,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [RequestStatus()],
              ),
            ),
            BlocBuilder<GenericCubit<List<RequestModel>?>,
                GenericCubitState<List<RequestModel>?>>(
              bloc: requestViewModel.requestsCubit,
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: cubit.ordersModel!=null &&state is! GetOrdersLoadingState,
                  fallback: (context)=>SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: CustomShimmer(width: context.width,
                                height: context.height * 0.15,),
                            ),
                        childCount: 6),
                  ),
                  builder: (context)=> ConditionalBuilder(
                    condition: cubit.ordersModel!.data!.data!.isNotEmpty,
                    fallback: (context)=>SliverToBoxAdapter(
                      child: Center(child: Text(
                        'no_requests_yet'.tr(),
                        style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),
                      )),
                    ),
                    builder: (context){
                      Future.delayed(Duration.zero,(){
                        cubit.paginationOrders(context);
                      });
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                                (context, index) => RequestItem(
                              requestModel: cubit.ordersModel!.data!.data![index],
                              deleteRequest: () =>
                                  requestViewModel.deleterequest(index).then(
                                        (value) => Navigator.pop(
                                      context,
                                    ),
                                  ),
                            ),
                            childCount: cubit.ordersModel!.data!.data!.length),
                      );
                    }
                  ),
                );
              },
            ),
            if(state is GetOrdersLoadingState)
            const SliverToBoxAdapter(
              child: CupertinoActivityIndicator(),
            ),
            const SliverToBoxAdapter(
              child: Gap(70),
            )
          ],
        ),
      ),
    );
  },
);
  }
}
