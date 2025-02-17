// //051900004
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:on_express/core/componets/componets.dart';
import 'package:on_express/core/constants/app_constants.dart';
import 'package:on_express/core/extensions/media_values.dart';
import 'package:on_express/core/utils/color_resources.dart';
import 'package:on_express/core/widget/base_app_bar.dart';
import 'package:on_express/core/widget/custom_button.dart';
import 'package:on_express/core/widget/default_scaffold.dart';
import 'package:on_express/core/widget/verification_phone_dialogs.dart';
import 'package:on_express/features/login/login_page.dart';
import 'package:on_express/features/store_details/store_details_view_model.dart';
import 'package:on_express/features/store_details/widget/coupon_notes_widget.dart';
import 'package:on_express/features/store_details/widget/payment_method.dart';
import 'package:on_express/features/store_details/widget/total_order.dart';
import 'package:on_express/features/store_details/widget/user_address_widget.dart';
import 'package:on_express/features/store_details/widget/date_time_widget.dart';
import 'package:on_express/features/store_details/widget/pic_store_service.dart';
import 'package:on_express/features/store_details/widget/pick_delivery_service.dart';
import 'package:on_express/features/store_details/widget/store_image.dart';
import 'package:on_express/models/providers_model.dart';
import '../../core/utils/image_resources.dart';
import '../../cubits/app_cubit/app_cubit.dart';
import '../../cubits/app_cubit/app_states.dart';
import '../../cubits/menu_cubit/menu_cubit.dart';
import '../../cubits/menu_cubit/menu_states.dart';
import '../payment/data/repos/checkout_repo_impl.dart';
import '../payment/presentation/manager/cuibt/payment_cuibt.dart';
import '../payment/presentation/manager/cuibt/payment_state.dart';
import '../payment/presentation/views/widgets/custom_botton_bloc_consumer.dart';

// ignore: must_be_immutable
class StoreDetailsPage extends StatefulWidget {
  StoreDetailsPage({super.key, required this.provider});

  ProviderData? provider;

  @override
  State<StoreDetailsPage> createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {
  StoreDetailsViewModel storeDetailsViewModel = StoreDetailsViewModel();
  CouponAndNotes couponAndNotes = CouponAndNotes();
  final Map<int, int> _itemCounts = {};
  final Map<int, int> selectedServices = {}; // Tracks selected service indices
  final Set<int> selectedServicesBool = {};
// Tracks number of pieces entered
  final Map<int, TextEditingController> _textControllers = {};
  double _totalCost = 0.0; // Tracks total cost
  bool _selectedItems = false; // Tracks if additional tools are selected
  int? _employeeCount = 1;
  int _hoursCount = 1; // Tracks the number of employees
  @override
  void initState() {
    super.initState();
    _calculateTotalCost();

    for (int i = 0;
        i < (widget.provider?.serviceDetails?.cars?.length ?? 0);
        i++) {
      _textControllers[i] = TextEditingController(text: '0');
    }
  }

  @override
  void dispose() {
    _textControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _updateItemCount(int index, int count, int price) {
    setState(() {
      _itemCounts[index] = count;
      _textControllers[index]?.text = count.toString(); // Update the text field
      _calculateTotalCost(); // Recalculate the total cost
    });
  }

  void _calculateTotalCost() {
    double sum = 0.0;

    if (_employeeCount == null) {
      _employeeCount = widget.provider?.serviceDetails?.defaultNumOfEmployees;
    }
    // Calculate the cost of clothes
    List<Clothing>? clothes = widget.provider?.serviceDetails?.clothes;
    if (clothes != null) {
      for (int i = 0; i < clothes.length; i++) {
        int count = _itemCounts[i] ?? 0;
        if (count > 0) {
          sum += count * (clothes[i].price ?? 0);
        }
      }
    }

    // Calculate the total cost of car services
    if (widget.provider?.serviceDetails?.cars != null) {
      for (int i = 0;
          i < (widget.provider!.serviceDetails!.cars!.length);
          i++) {
        final item = widget.provider!.serviceDetails!.cars![i];
        final price = item.price ?? 0;
        int count = _itemCounts[i] ?? 0;
        sum += count * price;
      }
    }

    // Calculate the total cost of house service
    if (widget.provider?.serviceDetails?.house != null &&
        widget.provider?.serviceDetails?.defaultPrice != null) {
      sum += widget.provider!.serviceDetails!.defaultPrice! *
          _employeeCount! *
          _hoursCount;
      // int sumofPrices = selectedServices.values.fold(0, (previousValue, element) => previousValue + element);
      //  sum+=sumofPrices*_hoursCount;
    }

    // Add additional costs if applicable
    if (_selectedItems && widget.provider?.serviceDetails?.withTools != null) {
      sum += widget.provider!.serviceDetails!.withTools!;
    }

    setState(() {
      _totalCost = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Clothing>? clothes = widget.provider!.serviceDetails!.clothes;
        List<Car>? cars = widget.provider!.serviceDetails!.cars;
        List<House>? houses = widget.provider!.serviceDetails!.house;
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            var deliveryFee = clothes != null
                ? storeDetailsViewModel.selectedServiceType == 0
                    ? storeDetailsViewModel.selectedDelivery == 0
                        ? MenuCubit.get(context)
                            .settingsModel
                            ?.data
                            ?.shippingChargers
                            ?.deliveryBig
                        : MenuCubit.get(context)
                            .settingsModel
                            ?.data
                            ?.shippingChargers
                            ?.deliverySmall
                    : storeDetailsViewModel.selectedDelivery == 0
                        ? MenuCubit.get(context)
                            .settingsModel
                            ?.data
                            ?.shippingChargers
                            ?.pickupBig
                        : MenuCubit.get(context)
                            .settingsModel
                            ?.data
                            ?.shippingChargers
                            ?.pickupSmall
                : 0;

            return DefaultScaffold(
              backGround: cars != null
                  ? ImageResources.carBackGround
                  : houses != null
                      ? ImageResources.houseBackGround
                      : null,
              haveBackground: true,
              havePadding: false,
              child: NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  BaseAppBar(
                    isBackExist: true,
                    havePadding: true,
                  ),
                ],
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StoreImage(provider: widget.provider),
                      clothes != null
                          ? Padding(
                              padding: EdgeInsets.all(16.0.w),
                              child: Column(
                                children: [
                                  const Gap(30),
                                  PickStoreServiceType(
                                      storeDetailsViewModel:
                                          storeDetailsViewModel),
                                  const Gap(10),
                                  PickDeliveryService(
                                      storeDetailsViewModel:
                                          storeDetailsViewModel),
                                  const Gap(10)
                                ],
                              ),
                            )
                          : Container(),
                      cars != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0.w),
                                  child: Text(
                                    '${'service_type'.tr()} :',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                for (int i = 0; i < cars.length; i++)
                                  _buildCarItem(i),
                              ],
                            )
                          : Container(),
                      // Gap(20),
                      Padding(
                        padding: EdgeInsets.all(16.0.w),
                        child: Column(
                          children: [
                            houses != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        EmployeeCountSelector(
                                          start: widget
                                                  .provider!
                                                  .serviceDetails!
                                                  .defaultNumOfEmployees ??
                                              1,
                                          selectedEmployeeCount:
                                              _employeeCount ?? 1,
                                          onChanged: (count) {
                                            setState(() {
                                              _employeeCount = count;
                                              _calculateTotalCost();
                                            });
                                          },
                                        ),
                                        Gap(10),
                                        HoursCountSelector(
                                          selectedHourCount: _hoursCount,
                                          onChanged: (hours) {
                                            setState(() {
                                              _hoursCount = hours;
                                              _calculateTotalCost();
                                            });
                                          },
                                        ),

                                        // Gap(10),
                                        SizedBox(
                                          height: 150.h,
                                          child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 0,
                                              childAspectRatio:
                                                  2.8, // Adjust item size
                                            ),
                                            itemCount: houses.length,
                                            itemBuilder: (context, index) {
                                              return HouseItem(index);
                                            },
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.all(16.0.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 250.w,
                                                    child: Text(
                                                      'with Tools'.tr(),
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.w),
                                                  Checkbox(
                                                    activeColor: ColorResources
                                                        .primaryColor,
                                                    value: _selectedItems,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selectedItems = value!;
                                                        _calculateTotalCost();
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '${'with Tools'.tr()} : ${widget.provider!.serviceDetails!.withTools!} AED',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.grey[600],
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                '${'employee_cost'.tr()} : ${widget.provider!.serviceDetails!.extraEmployee!} AED',
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.grey[600],
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ])
                                : Container(),

                            clothes != null
                                ? SizedBox(
                                    height: 300.h,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: List.generate(
                                          (clothes.length / 4)
                                              .ceil(), // Number of rows needed
                                          (rowIndex) {
                                            // Extract 4 items per row
                                            int startIndex = rowIndex * 4;
                                            int endIndex = (startIndex + 4)
                                                .clamp(0, clothes.length);

                                            return Column(
                                              children: [
                                                // Row containing 4 items
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: clothes
                                                      .sublist(
                                                          startIndex, endIndex)
                                                      .map((item) => Expanded(
                                                            child: _buildClothingItem(
                                                                clothes.indexOf(
                                                                    item)),
                                                          ))
                                                      .toList(),
                                                ),
                                                // Divider after every row except the last one
                                                if (rowIndex <
                                                    (clothes.length / 4)
                                                            .ceil() -
                                                        1)
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 12.0.h,
                                                        right: 16.w,
                                                        left: 16.w),
                                                    child: Divider(
                                                      thickness: 2,
                                                      color: Colors.grey[400],
                                                    ),
                                                  ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),

                            SizedBox(height: 20),

                            // Total Cost Display
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                children: [
                                  Text(
                                    "laundry_fee".tr(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ": ${_totalCost.toStringAsFixed(2)} AED",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(30),
                      DateAndTimeWidget(
                          storeDetailsViewModel: storeDetailsViewModel),
                      const Gap(20),
                      if (token != null)
                        UserAddressWidget(
                            storeDetailsViewModel: storeDetailsViewModel),
                      if (token != null) const Gap(20),
                      PaymentMethod(
                          storeDetailsViewModel: storeDetailsViewModel),
                      const Gap(20),
                      couponAndNotes,
                      const Gap(20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ConditionalBuilder(
                          condition:
                              MenuCubit.get(context).settingsModel != null,
                          fallback: (c) =>
                              Center(child: CupertinoActivityIndicator()),
                          builder: (c) => TotalOrderWidget(
                            isDeliveryFee: clothes != null ? true : false,
                            deliveryFee: deliveryFee,
                            laundryFee: _totalCost.toInt(),
                            provider: widget.provider,
                          ),
                        ),
                      ),
                      const Gap(30),
                      Align(
                        alignment: Alignment.center,
                        child: ConditionalBuilder(
                          condition: state is! CreateOrderLoadingState,
                          fallback: (context) => CupertinoActivityIndicator(),
                          builder: (context) => CustomButton(
                            title: "Submit_request".tr(),
                            onTap: () {
                              final double transactionFees = (_totalCost) *
                                  ((widget.provider?.transactionFees ?? 0) /
                                      100);
                              if (token != null) {
                                if (MenuCubit.get(context)
                                        .userModel
                                        ?.data
                                        ?.phoneNumber
                                        ?.isNotEmpty ??
                                    false) {
                                  if (MenuCubit.get(context)
                                          .userModel
                                          ?.data
                                          ?.status ==
                                      2) {
                                    if (storeDetailsViewModel
                                            .selectPaymentMethod ==
                                        0) {
                                      // Show the payment options modal bottom sheet
                                      showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        builder: (context) {
                                          return BlocProvider(
                                            create: (context) => PaymentCubit(
                                                CheckoutRepoImpl()),
                                            child: BlocConsumer<PaymentCubit,
                                                PaymentState>(
                                              listener: (context, state) {
                                                if (state is PaymentSuccess) {
                                                  storeDetailsViewModel
                                                      .addRequest(
                                                    context: context,
                                                    storeDetailsViewModel:
                                                        storeDetailsViewModel,
                                                    providerId:
                                                        widget.provider?.id ??
                                                            '',
                                                    couponCode: cubit
                                                                .couponModel !=
                                                            null
                                                        ? couponAndNotes
                                                            .couponController
                                                            .text
                                                        : null,
                                                    additionalNotes:
                                                        couponAndNotes
                                                                .notesController
                                                                .text
                                                                .isNotEmpty
                                                            ? couponAndNotes
                                                                .notesController
                                                                .text
                                                            : null,
                                                  );
                                                  print(
                                                      "Total====>>>>${deliveryFee! + _totalCost.toInt() + transactionFees.toInt() + widget.provider!.taxes!}");
                                                }

                                                if (state is PaymentFailure) {
                                                  Navigator.pop(context);
                                                  print(
                                                      "Error=====>>>${state.errMessage}");
                                                }
                                              },
                                              builder: (context, state) {
                                                return CustomButtonBlocConsumer(
                                                  total: deliveryFee! +
                                                      _totalCost.toInt() +
                                                      transactionFees.toInt() +
                                                      widget.provider!.taxes!
                                                          .toInt(),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      // Handle cash submission directly
                                      storeDetailsViewModel.addRequest(
                                        context: context,
                                        storeDetailsViewModel:
                                            storeDetailsViewModel,
                                        providerId: widget.provider?.id ?? '',
                                        couponCode: cubit.couponModel != null
                                            ? couponAndNotes
                                                .couponController.text
                                            : null,
                                        additionalNotes: couponAndNotes
                                                .notesController.text.isNotEmpty
                                            ? couponAndNotes
                                                .notesController.text
                                            : null,
                                      );
                                    }
                                  } else {
                                    // User's phone number is not verified
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            VerifyPhoneDialog());
                                  }
                                } else {
                                  // User's phone number is empty
                                  showDialog(
                                      context: context,
                                      builder: (context) =>
                                          UpdatePhoneDialog());
                                }
                              } else {
                                // User is not logged in
                                navigateTo(
                                    context, LoginPage(fromLogin: false));
                              }
                            },
                            isSelected: true,
                          ),
                        ),
                      ),
                      const Gap(50),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildClothingItem(int index) {
    if (widget.provider?.serviceDetails?.clothes != null &&
        index < (widget.provider!.serviceDetails?.clothes?.length ?? 0)) {
      final item = widget.provider!.serviceDetails?.clothes?[index];
      final price = item?.price ?? 0;
      final iconPath = item?.icon ?? ''; // Assuming 'icon' holds the image path
      final name = item?.name ?? 'Item';
      final ar_name = item?.ar_name ?? 'غرض';

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Image.network(
            iconPath,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8),
          // Name
          Text(
            context.locale.languageCode == 'ar' ? ar_name : name,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          // Price
          Text(
            "$price AED",
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          SizedBox(height: 4),
          // Counter
          _textField(index, price),
        ],
      );
    } else {
      // Placeholder if item not available
      return SizedBox.shrink();
    }
  }

  Widget _buildCarItem(int index) {
    if (widget.provider?.serviceDetails?.cars != null &&
        index < (widget.provider!.serviceDetails?.cars?.length ?? 0)) {
      final item = widget.provider!.serviceDetails?.cars?[index];
      final price = item?.price ?? 0;
      final iconPath = item?.icon ?? '';
      final name = item?.name ?? 'Item';
      final ar_name = item?.ar_name ?? 'غرض';

      return Padding(
        padding: EdgeInsets.all(20.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon
            Image.network(
              iconPath,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 8.w),
            // Name and Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.locale.languageCode == 'ar' ? ar_name : name,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "$price AED",
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
              ],
            ),
            SizedBox(width: 4.w),
            // Counter
            Row(
              children: [
                // Decrement Button
                InkWell(
                  onTap: () {
                    int currentCount = _itemCounts[index] ?? 0;
                    if (currentCount > 0) {
                      _updateItemCount(index, currentCount - 1, price);
                    }
                  },
                  child: Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: ColorResources.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                SizedBox(width: 5.w),
                // Text Field to Display Current Count
                _textField(index, price),
                SizedBox(width: 5.w),
                // Increment Button
                InkWell(
                  onTap: () {
                    int currentCount = _itemCounts[index] ?? 0;
                    _updateItemCount(index, currentCount + 1, price);
                  },
                  child: Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: ColorResources.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      // Placeholder if item not available
      return SizedBox.shrink();
    }
  }

  Widget HouseItem(int index) {
    if (widget.provider?.serviceDetails?.house != null &&
        index < (widget.provider!.serviceDetails!.house?.length ?? 0)) {
      final serviceItem = widget.provider!.serviceDetails!.house![index];
      final price = serviceItem.price ?? 0;
      final iconPath = serviceItem.icon ?? '';
      final name = serviceItem.name ?? 'Item';
      final arName = serviceItem.ar_name ?? 'غرض';
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        width: context.width / 2 - 33.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: ColorResources.primaryColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Gap(5.w),
            Image.network(
              iconPath,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            Gap(5.w),
            SizedBox(
              width: 80.w,
              child: Text(
                context.locale.languageCode == 'ar' ? arName : name,
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Checkbox(
              activeColor: ColorResources.primaryColor,
              value: selectedServicesBool
                  .contains(index), // Default to false if not in the map
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    // When selected, store the service price in selectedServices map
                    selectedServicesBool
                        .add(index); // Mark the service as selected
                    selectedServices[index] =
                        price; // Save the price of the selected service in the map
                  } else {
                    // When deselected, remove the service price from selectedServices map
                    selectedServicesBool
                        .remove(index); // Mark the service as deselected
                    selectedServices.remove(
                        index); // Remove the price from the selectedServices map
                  }

                  // Recalculate the total cost
                  _calculateTotalCost();
                });
              },
            )
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _textField(int index, int price) {
    return SizedBox(
      width: 35, // Increased width for better visibility
      height: 35,
      child: TextField(
        controller: _textControllers[index], // Use controller for text field
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          final count = int.tryParse(value) ?? 0;
          _updateItemCount(index, count, price);
        },
      ),
    );
  }
}

class EmployeeCountSelector extends StatefulWidget {
  final ValueChanged<int> onChanged;
  final int start;
  final int selectedEmployeeCount;
  const EmployeeCountSelector({
    Key? key,
    required this.selectedEmployeeCount,
    required this.onChanged,
    required this.start,
  }) : super(key: key);

  @override
  _EmployeeCountSelectorState createState() => _EmployeeCountSelectorState();
}

class _EmployeeCountSelectorState extends State<EmployeeCountSelector> {
  late int _selectedEmployeeCount;

  @override
  void initState() {
    super.initState();
    _selectedEmployeeCount = widget.start; // Initialize with the `start` value
  }

  @override
  Widget build(BuildContext context) {
    // _selectedEmployeeCount =widget.start;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${'employee'.tr()} :',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = widget.start; i <= 20; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedEmployeeCount = i; // Update selected value
                    });
                    widget.onChanged(i); // Notify parent widget
                  },
                  child: Container(
                    height: 50.h,
                    width: 70.w,
                    margin: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorResources.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                      color: _selectedEmployeeCount == i
                          ? ColorResources.primaryColor // Highlight color
                          : ColorResources.white, // Default color
                    ),
                    child: Center(
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: _selectedEmployeeCount == i
                              ? ColorResources.white // Text color when selected
                              : ColorResources
                                  .primaryColor, // Default text color
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class HoursCountSelector extends StatefulWidget {
  final int selectedHourCount;
  final ValueChanged<int> onChanged;

  const HoursCountSelector({
    Key? key,
    required this.selectedHourCount,
    required this.onChanged,
  }) : super(key: key);

  @override
  _HoursCountSelectorState createState() => _HoursCountSelectorState();
}

class _HoursCountSelectorState extends State<HoursCountSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // 'Cleaning Hours',
          '${'hours'.tr()} :',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(5),
        SingleChildScrollView(
          // Added SingleChildScrollView for horizontal scrolling
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 1; i <= 14; i++)
                GestureDetector(
                  onTap: () => widget.onChanged(i),
                  child: Container(
                    height: 50.h,
                    width: 70.w,
                    margin: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorResources.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                      color: widget.selectedHourCount == i
                          ? ColorResources.primaryColor // Highlight color
                          : ColorResources.white, // Default color
                    ),
                    child: Center(
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: widget.selectedHourCount == i
                              ? ColorResources.white // Text color when selected
                              : ColorResources
                                  .primaryColor, // Default text color
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

///keytool -list -v -keystore "E:\work\daily_wash_client\key\daily_v1.jks"
