import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_button.dart';
import '../../../core/widget/image_net.dart';
import '../../../cubits/app_cubit/app_cubit.dart';
import '../../../cubits/app_cubit/app_states.dart';
import '../../../models/orders_model.dart';



class ReviewStoreDialog extends StatefulWidget {
  final OrderData orderData;
  const ReviewStoreDialog({Key? key, required this.orderData,    }) : super(key: key);

  @override
  ReviewStoreDialogState createState() => ReviewStoreDialogState();
}

class ReviewStoreDialogState extends State<ReviewStoreDialog> {
  @override
  void initState() {
    super.initState();

  }
  int currentStar = 1;

  TextEditingController controller = TextEditingController();

  ScrollController scrollController = ScrollController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.white,
        child:SingleChildScrollView(
          child: InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    tr("skip"),
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                            )
                          ],
                        ),
                        Container(
                          height: 100,width: 100,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child : ImageNet(image:widget.orderData.providerPersonalPhoto??'',),
                        ),
                        const Gap(20),
                        Text(
                          widget.orderData.providerName??'no_name'.tr(),
                          maxLines: 1,style: TextStyle(color: Color(0xff000000),fontSize: 20,fontWeight: FontWeight.w600),),
                        Text("review_title".tr(),
                          maxLines: 1,style: TextStyle(color: Color(0xff2C2C2C),fontSize: 14,fontWeight: FontWeight.w500),),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemBuilder(1, ImageResources.star1Yes,ImageResources.star1No),
                            itemBuilder(2, ImageResources.star2Yes,ImageResources.star2No),
                            itemBuilder(3, ImageResources.star3Yes,ImageResources.star3No),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            itemBuilder(4, ImageResources.star4Yes, ImageResources.star4No),
                            SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                                width: 100,
                                child: itemBuilder(5, ImageResources.star5Yes, ImageResources.star5No)),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Container(
                          width: double.infinity,
                          padding:
                          const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffB3B3B3),width: 1),
                            borderRadius: BorderRadiusDirectional.circular(15),
                          ),
                          child: TextFormField(
                            maxLines: 3,
                            onTap: (){
                              Future.delayed(Duration(milliseconds: 500),(){
                                scrollController.position.jumpTo(scrollController.position.maxScrollExtent);
                              });
                            },
                            textInputAction: TextInputAction.done,
                            controller: controller,
                            validator: (val){
                              if(val!.isEmpty)return 'review_content_required'.tr();
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: tr('leave_us_a_comment')),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ReviewLaundryLoadingState,
                          fallback: (c)=>CupertinoActivityIndicator(),
                          builder: (c)=> CustomButton(
                              title: 'submit_review'.tr(),
                              onTap: (){
                                if(formKey.currentState!.validate()){
                                  AppCubit.get(context).reviewLaundry(
                                      context: context,
                                      id: widget.orderData.providerId??'',
                                      content: controller.text,
                                      rate: currentStar
                                  );
                                }
                              },
                              isSelected: true),
                        ),
                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  },
);
  }

  Widget itemBuilder(int index, String imageYes, String imageNo) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        setState(() {
          currentStar = index;
        });
      },
      child: Image.asset(
        currentStar == index ? imageYes : imageNo,
        width: 80,
      ),
    );
  }
}
