import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/widget/image_net.dart';
import 'package:on_express/features/home/home_view_model.dart';
import 'package:on_express/features/home/widget/ads/ads_item.dart';
import '../../../../core/widget/shimmer.dart';
import '../../../../cubits/app_cubit/app_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({
    super.key,
    required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return ConditionalBuilder(
      condition: cubit.adsModel!=null,
      fallback:(c)=> CustomShimmer(height: context.height * 0.2,width: double.infinity,),
      builder:(c)=> ConditionalBuilder(
        condition: cubit.adsModel!.data!.ads!.isNotEmpty,
        fallback: (c)=>Text('no_ads'),
        builder: (c)=> Column(
          children: [
            SizedBox(
              height: context.height * 0.2,
              width: context.height * 0.4,
              child: CarouselSlider.builder(
                itemCount: cubit.adsModel!.data!.ads!.length,
                itemBuilder: (c,i,page) => ConditionalBuilder(
                  condition: cubit.adsModel!.data!.ads![i].advertisementViewType == 1,
                  fallback: (c)=>Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20)
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                          onTap: (){
                            context.read<AppCubit>().tapOnAd(context,
                                ad: cubit.adsModel!.data!.ads![i]);
                          },
                          child: ImageNet(image: cubit.adsModel!.data!.ads![i].backgroundImage??''))),
                  builder: (c)=> AdsItem(ad: cubit.adsModel!.data!.ads![i]),
                ),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  disableCenter: true,
                  onPageChanged: (index, reason) {
                    homeViewModel.setSelectedAds(index);
                  },
                ),
              ),
            ),
            const Gap(8),
            BlocBuilder<GenericCubit<int?>, GenericCubitState<int?>>(
              bloc:homeViewModel.adsCubit ,
              builder: (context, state) {
                return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                cubit.adsModel!.data!.ads!.length,
                    (index) =>
                    buildDot(homeViewModel.selectedAds, index, context),
              ),
            );
  },
),
          ],
        ),
      ),
    );
  }
}

Widget buildDot(int currentIndex, int index, BuildContext context) {
  return AnimatedContainer(
    height: 10,
    width: currentIndex == index ? 30 : 10,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      color: currentIndex == index
          ? ColorResources.yellow
          : ColorResources.darkGrey,
      borderRadius: BorderRadius.circular(20),
    ),
    duration: const Duration(milliseconds: 300),
  );
}
