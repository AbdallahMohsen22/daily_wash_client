import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/generic_cubit/generic_cubit.dart';
import 'package:on_express/core/utils/app_size.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/utils/font_manager.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';
import 'package:on_express/features/store_details/widget/date_time_items.dart';

import '../../../cubits/menu_cubit/menu_cubit.dart';
import '../../../cubits/menu_cubit/menu_states.dart';

class DateAndTimeWidget extends StatefulWidget {
  const DateAndTimeWidget({super.key, required this.storeDetailsViewModel});

  final StoreDetailsViewModel storeDetailsViewModel;

  @override
  State<DateAndTimeWidget> createState() => _DateAndTimeWidgetState();
}

class _DateAndTimeWidgetState extends State<DateAndTimeWidget> {

  bool isDateTimeNow = false;
  bool isDateTimeNowSelected = false;
  String dateNow  = '';
  int currentMonth = DateTime.now().month;
  int currentDay = DateTime(DateTime.now().year,DateTime.now().month+1).toUtc().day;
  String monthName = DateFormat('MMM').format(DateTime(DateTime.now().year,DateTime.now().month+1).toUtc());
  var inputFormat = DateFormat('HH:mm:ss MM/dd/yyyy','en');


  void setOrderDateNow() {
    setState(() {
      dateNow = inputFormat.format(DateTime.now().copyWith(minute: 0,second: 0)); // <-- dd/MM 24H format
      isDateTimeNow = true;
    });
  }

  String getMonthName(int month){
    print(month);
    currentDay = DateTime(DateTime.now().year,month+1).toUtc().day;
    print(currentDay);
    return  DateFormat('MMM').format(DateTime(DateTime.now().year,month+1).toUtc(),);

  }

  @override
  void initState() {
    widget.storeDetailsViewModel.currentTime = inputFormat.format(
        DateTime(DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day+1,
            DateTime.now().hour,0,0
        ),
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return BlocBuilder<GenericCubit<int?>, GenericCubitState<int?>>(
      bloc: widget.storeDetailsViewModel.dateCubit,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "date_and_time".tr(),
                style: FontManager.getMediumStyle(
                  fontSize: AppSize.sp18,
                  color: ColorResources.kFormTitleColor,
                ),
              ),
              // const Spacer(),
              // IconButton(onPressed: (){
              //   if(currentMonth != 1){
              //     currentMonth -- ;
              //     monthName = getMonthName(currentMonth);
              //     setState(() {});
              //   }
              // }, icon: Icon(Icons.arrow_back_ios)),
              // Text(
              //   '$monthName',
              //   style: FontManager.getMediumStyle(
              //     fontSize: AppSize.sp18,
              //     color: ColorResources.kFormTitleColor,
              //   ),
              // ),
              // IconButton(onPressed: (){
              //   if(currentMonth != 12){
              //     currentMonth ++;
              //     monthName = getMonthName(currentMonth);
              //     setState(() {});
              //   }
              // }, icon: Icon(Icons.arrow_forward_ios)),
            ],
          ),
          const Gap(15),
          //   if(!isDateTimeNow)
          //   ConditionalBuilder(
          //     condition: cubit.settingsModel!=null,
          //     fallback: (c)=>Center(child: CupertinoActivityIndicator()),
          //     builder: (c)=> SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(//DateTime.now().copyWith(month: DateTime.now().month).day
          //       children: List.generate(currentDay , (index) =>
          //           DateItem(
          //           isSelected: widget.storeDetailsViewModel.selectedDate == index
          //               ? true
          //               : false,
          //           isCurrentMonth:currentMonth <= DateTime.now().month,
          //           index: index+1,
          //           onTap: () {
          //             print(isDateTimeNow);
          //             print(cubit.settingsModel);
          //             print(cubit.settingsModel);
          //             setState(() {
          //               isDateTimeNowSelected = false;
          //               isDateTimeNow = false;
          //             });
          //             if(!isDateTimeNow){
          //               widget.storeDetailsViewModel.setSelectedDate(index);
          //             }
          //           }
          //       )),
          //     ),
          //     ),
          //   ),
          // if(!isDateTimeNow)
          //   const Gap(20),
          // if(!isDateTimeNow)
          //   state.data == null
          //     ? const SizedBox()
          //     :
          //   ConditionalBuilder(
          //   condition: cubit.settingsModel!=null,
          //   fallback: (c)=>Center(child: CupertinoActivityIndicator()),
          //   builder: (c)=> BlocBuilder<GenericCubit<int?>, GenericCubitState<int?>>(
          //           bloc: widget.storeDetailsViewModel.timeCubit,
          //           builder: (context, state) {
          //             List<String> hours = [];
          //             List<int> hours24Format = [];
          //             for (int i = cubit.settingsModel?.data?.openingTime??0; i<cubit.settingsModel!.data!.closingTime!;i++){
          //               String hour = DateFormat.jm('en').format(DateTime.now().copyWith(hour: i +2 ,minute: 0),);
          //               hours24Format.add(i+2);
          //               //if(DateTime.now().hour <=i)
          //               hours.add(hour);
          //             }
          //             print(hours);
          //             return Wrap(
          //               spacing: 15,
          //               runSpacing: 10,
          //               children: hours.map((e) {
          //                 int index = hours.indexOf(e);
          //                 return TimeItem(
          //                     isSelected:
          //                     widget.storeDetailsViewModel.selectedTime == index
          //                         ? true
          //                         : false,
          //                     time: e,
          //                     onTap: () {
          //                       if(widget.storeDetailsViewModel.selectedDate != -1){
          //                         setState(() {
          //                           isDateTimeNowSelected = false;
          //                         });
          //                         widget.storeDetailsViewModel.setSelectedTime(index);
          //                         widget.storeDetailsViewModel.currentTime = inputFormat.format(
          //                             DateTime(DateTime.now().year,
          //                                 currentMonth,
          //                                 widget.storeDetailsViewModel.selectedDate +1,
          //                                 hours24Format[index]
          //                             )
          //                         );
          //                         print(widget.storeDetailsViewModel.currentTime);
          //                       }
          //                     }
          //                 );
          //               }).toList(),
          //             );
          //           }
          //         ),
          //     ),
          const Gap(15),
          Center(
            child: CustomButton(
                title: "specific_time".tr(),
                onTap: (){
                  showCupertinoModalPopup(
                      context: context,
                      builder:(context)=> Container(
                        height: 240,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          minimumDate:DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,DateTime.now().hour),
                          maximumDate:DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+7,DateTime.now().hour) ,
                          onDateTimeChanged: (date){
                            setState(() => widget.storeDetailsViewModel.currentTime = inputFormat.format(
                                date
                            ));
                          },
                        ),
                      )
                  );
                },
                isSelected: true
            ),
          ),
          const Gap(20),
          if(widget.storeDetailsViewModel.currentTime.isNotEmpty)
          Center(
            child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.h10,
                ),
                width: AppSize.w200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDateTimeNowSelected
                      ? ColorResources.primaryColor
                      : ColorResources.primaryColor.withOpacity(0.3),
                ),
                child: Center(
                  child: Text(
                    widget.storeDetailsViewModel.currentTime,
                    softWrap: true,
                    style: FontManager.getMediumStyle(
                      fontSize: isDateTimeNowSelected ? AppSize.sp16 : AppSize.sp14,
                      color:
                      isDateTimeNowSelected ? ColorResources.white : ColorResources.black75,
                    ),
                  ),
                )),
          )
          // BlocBuilder<GenericCubit<bool?>, GenericCubitState<bool?>>(
          //   bloc: widget.storeDetailsViewModel.requestDateNowCubit,
          //   builder: (context, state) => Align(
          //     alignment: Alignment.center,
          //     child: CustomButton(
          //       title:!isDateTimeNowSelected?'request_now'.tr():"specific_time".tr(),
          //       onTap: () {
          //         setState(() {
          //           isDateTimeNowSelected = !isDateTimeNowSelected;
          //           widget.storeDetailsViewModel.setSelectedTime(-1);
          //           widget.storeDetailsViewModel.setSelectedDate(-1);
          //           isDateTimeNow = !isDateTimeNow;
          //         });
          //         if(isDateTimeNow){
          //           isDateTimeNowSelected = true;
          //           setOrderDateNow();
          //           widget.storeDetailsViewModel.currentTime = inputFormat.format(
          //               DateTime(DateTime.now().year,
          //                   DateTime.now().month,
          //                   DateTime.now().day+1,
          //                   DateTime.now().hour,0,0
          //               )
          //           );
          //         }
          //       },
          //       isSelected: true,
          //     ),
          //   ),
          // ),
          // Gap(20),
          // if(isDateTimeNow)
          //   Center(
          //     child: GestureDetector(
          //       onTap: (){
          //         setState(() {
          //           isDateTimeNowSelected = !isDateTimeNowSelected;
          //           widget.storeDetailsViewModel.setSelectedTime(-1);
          //           widget.storeDetailsViewModel.setSelectedDate(-1);
          //           isDateTimeNow = !isDateTimeNow;
          //         });
          //       },
          //       child: Container(
          //           padding: EdgeInsets.symmetric(
          //             vertical: AppSize.h10,
          //           ),
          //           width: AppSize.w200,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: isDateTimeNowSelected
          //                 ? ColorResources.primaryColor
          //                 : ColorResources.primaryColor.withOpacity(0.3),
          //           ),
          //           child: Center(
          //             child: Text(
          //               dateNow,
          //               softWrap: true,
          //               style: FontManager.getMediumStyle(
          //                 fontSize: isDateTimeNowSelected ? AppSize.sp16 : AppSize.sp14,
          //                 color:
          //                 isDateTimeNowSelected ? ColorResources.white : ColorResources.black75,
          //               ),
          //             ),
          //           )),
          //     ),
          //   ),
        ],
      ),
    );
  },
);
  }
}
