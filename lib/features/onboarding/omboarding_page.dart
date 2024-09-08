import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:on_express/config/routes/app_route.dart';
import 'package:on_express/core/cache/init_screen_cahce.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/features/onboarding/model/silder_model.dart';
import 'package:on_express/features/onboarding/widget/silder.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<SliderModel> slides = [];
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = getSlides();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: Container(
        height: context.height,
        width: context.width,
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.w20,
          vertical: AppSize.h15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(30),
            Expanded(
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    // contents of slider
                    return SliderPage(
                      image: slides[index].getImage()!,
                      description: slides[index].description!,
                      title: slides[index].title!,
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                (index) => buildDot(index, context),
              ),
            ),
            const Gap(20),
            CustomButton(
              title: currentIndex == slides.length - 1
                  ? "to_homepage".tr()
                  : 'next'.tr(),
              isSelected: true,
              onTap: () {
                if (currentIndex == slides.length - 1) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.navigationPage, (route) => false);
                  InitScreenPrefs.once(2);
                } else {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn);
                  InitScreenPrefs.once(1);
                }
              },
            ),
            Gap(context.height * 0.07),
          ],
        ),
      ),
    );
  }

// container created for dots
  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      height: 10,
      width: currentIndex == index ? 50 : 20,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: currentIndex == index
            ? ColorResources.primaryColor
            : ColorResources.darkGrey3,
        borderRadius: BorderRadius.circular(20),
      ),
      duration: const Duration(milliseconds: 300),
    );
  }
}
