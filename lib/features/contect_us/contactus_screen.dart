import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/utils/image_resources.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/custom_feild.dart';
import 'package:on_express/core/widget/ui.dart';
import 'package:on_express/features/favourites/widget/favourites_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/utils/app_size.dart';
import '../../core/utils/color_resources.dart';
import '../../core/utils/font_manager.dart';
import '../../core/widget/default_scaffold.dart';
import '../../cubits/menu_cubit/menu_cubit.dart';
import '../../cubits/menu_cubit/menu_states.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  Text getText(String text)=>Text(text,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),);

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MenuCubit.get(context);
        return DefaultScaffold(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const FavouritesAppBar(),
              SliverToBoxAdapter(
                child: Text(
                  'contact_us'.tr(),
                  style: FontManager.getSemiBold(
                    fontSize: AppSize.sp20,
                    color: ColorResources.black,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Gap(40),
              ),
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: (){
                                  final Uri params = Uri(
                                    scheme: 'mailto',
                                    path: cubit.settingsModel?.data?.projectEmailAddress??'',
                                  );
                                  final url = params.toString();
                                  openUrl(url,context);
                                }, child: Image.asset(ImageResources.gmail,width: 24,)),
                            InkWell(
                                onTap: (){
                                  _shareViaTwitter();
                                  //openUrl(cubit.settingsModel?.data?.projectTwitterLink??'',context);
                                }, child: Image.asset(ImageResources.twitter,width: 24,)),
                            InkWell(
                                onTap: (){
                                  whatAppContact(
                                    phone: cubit.settingsModel?.data?.projectWhatsAppNumber??'',
                                  );
                                }, child: Image.asset(ImageResources.whatsapp,width: 24,color: ColorResources.primaryColor,)
                            ),
                            InkWell(
                                onTap: (){
                                  //openUrl(cubit.settingsModel?.data?.projectInstagramLink??'',context);
                                  _shareViaInstagram();
                                }, child: Image.asset(ImageResources.insta,width: 24,)),
                            InkWell(
                                onTap: (){
                                  //openUrl(cubit.settingsModel?.data?.projectFacebookLink??'',context);
                                  _shareViaFacebook();
                                }, child: Image.asset(ImageResources.fb,width: 24,)),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        getText(tr('subject')),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20),
                          child: CustomField(
                              controller: subjectController,
                              validator: (str){
                                if(str!.isEmpty)return tr('subject_empty');
                              },
                              hint: tr('enter_subject')
                          ),
                        ),
                        getText(tr('message_details')),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20),
                          child: CustomField(
                              controller: messageController,
                              maxLines: 5,
                              validator: (str){
                                if(str!.isEmpty)return tr('message_empty');
                              },
                              hint: tr('enter_message')
                          ),
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! ContactUsLoadingState,
                            fallback: (context)=>CupertinoActivityIndicator(),
                            builder: (context)=> CustomButton(
                                title: tr('send_message'),
                                isSelected: true,
                                onTap: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.contactUs(
                                        context,
                                        message: messageController.text,
                                        subject: subjectController.text
                                    );
                                  }
                                }
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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

Future<void> openUrl(String url,BuildContext context) async {
  print(url);
  if(await canLaunchUrl(Uri.parse(url))){
    await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
  }else{
    UIAlert.showAlert(context,message: 'This Url can\'t launch');
  }
}

void whatAppContact({String phone = '01223364710'}) {
  String url;
  if (Platform.isAndroid) {
    // add the [https]
    url =  "https://wa.me/${phone}/?text=${Uri.parse('Hello')}"; // new line
  } else {
    // add the [https]
    url = "https://api.whatsapp.com/send?phone=$phone}=&text=${Uri.parse('Hello')}"; // new line
  }
  print(url);
  launchUrl(Uri.parse(url));
}

void _shareViaTwitter() async {
  // Replace with your Twitter sharing logic
  // Example: Launching a Twitter share URL
  String twitterUrl = 'https://twitter.com/intent/tweet?text=${Uri.parse('Hello, visit Daily Wash app')}';
  await canLaunch(twitterUrl)
      ? await launch(twitterUrl)
      : throw 'Could not launch $twitterUrl';
}

void _shareViaInstagram() async {
  // Replace with your Instagram sharing logic
  // Example: Launching an Instagram share URL
  String instagramUrl = 'https://www.instagram.com/dailywash.ae?url=${Uri.parse('Hello, This is our instagram page')}';
  await canLaunch(instagramUrl)
      ? await launch(instagramUrl)
      : throw 'Could not launch $instagramUrl';
}

void _shareViaFacebook() async {
  // Replace with your Facebook sharing logic
  // Example: Launching a Facebook share URL
  String facebookUrl = 'https://www.facebook.com/Dailywash.ae.?url?u=${Uri.parse('Hello, This is our facebook page')}';
  await canLaunch(facebookUrl)
      ? await launch(facebookUrl)
      : throw 'Could not launch $facebookUrl';
}