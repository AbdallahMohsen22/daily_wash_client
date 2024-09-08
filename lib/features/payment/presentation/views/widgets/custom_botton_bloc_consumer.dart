import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:on_express/features/payment/presentation/views/widgets/custom_button.dart';
import '../../../../../core/widget/ui.dart';
import '../../../../../cubits/app_cubit/app_cubit.dart';
import '../../../../../cubits/app_cubit/app_states.dart';
import '../../../../../cubits/menu_cubit/menu_cubit.dart';
import '../../../../../cubits/menu_cubit/menu_states.dart';
import '../../../../../models/providers_model.dart';
import '../../../../store_details/store_details_view_model.dart';
import '../../../../store_details/widget/coupon_notes_widget.dart';
import '../../../../store_details/widget/total_order.dart';
import '../../../api_keys.dart';
import '../../../data/models/amount_model.dart';
import '../../../data/models/item_list_model.dart';
import '../../../data/models/payment_intent_input_model.dart';
import '../../manager/cuibt/payment_cuibt.dart';
import '../../manager/cuibt/payment_state.dart';
import '../thank_you_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {

   CustomButtonBlocConsumer({super.key,  this.provider, this.total});

   final total;
  ProviderData? provider;

  StoreDetailsViewModel storeDetailsViewModel = StoreDetailsViewModel();

  CouponAndNotes couponAndNotes = CouponAndNotes();



  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<MenuCubit, MenuStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              // var total=storeDetailsViewModel.selectedServiceType == 0
              //     ?storeDetailsViewModel.selectedDelivery == 0
              //     ?MenuCubit.get(context).settingsModel?.data?.shippingChargers?.deliveryBig
              //     :MenuCubit.get(context).settingsModel?.data?.shippingChargers?.deliverySmall
              //     :storeDetailsViewModel.selectedDelivery == 0
              //     ?MenuCubit.get(context).settingsModel?.data?.shippingChargers?.pickupBig
              //     :MenuCubit.get(context).settingsModel?.data?.shippingChargers?.pickupSmall;
              return CustomButton(
                text: 'Pay Now',

                onTap: (){

                  print("Total amount====>>>${total}");
                  //For Paypal Method
                  // var transactionsData = getTransactionsData();
                  //
                  // exceutePaypalPayment(context,transactionsData);

                  //For Sripe Method
                  //Trigger payment cuibt
                  //بتشوف بيانات الاوردر وبتستخدمها هنا
                  PaymentIntentInputModel paymentIntentInputModel =
                  PaymentIntentInputModel(
                    amount: total.toString(),
                    currency: 'AED',
                    //customerId: 'cus_QaXWjZcVip7wwZ'
                  );   //خلي بالك ال amount هنا بيقسم علي 100
                  BlocProvider.of<PaymentCubit>(context).makePayment(paymentIntentInputModel: paymentIntentInputModel);
                },
              );
            }

        );
      }

    );

  }

  //paypal methods
  // void exceutePaypalPayment (BuildContext context, ({AmountModel amount, ItemListModel itemList}) transactionsData ){
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (BuildContext context) => PaypalCheckoutView(
  //       sandboxMode: true,
  //       clientId: ApiKeys.clientID,
  //       secretKey: ApiKeys.paypalSecretKey,
  //       transactions:  [
  //         {
  //           "amount": transactionsData.amount.toJson(),
  //           "description": "The payment transaction description.",
  //           "item_list": transactionsData.itemList.toJson(),
  //         }
  //       ],
  //       note: "Contact us for any questions on your order.",
  //       onSuccess: (Map params) async {
  //         log("onSuccess: $params");
  //         Navigator.pop(context);
  //       },
  //       onError: (error) {
  //         log("onError: $error");
  //         Navigator.pop(context);
  //       },
  //       onCancel: () {
  //         print('cancelled:');
  //         Navigator.pop(context);
  //       },
  //     ),
  //   ));
  // }
  // ({AmountModel amount, ItemListModel itemList}) getTransactionsData() {
  //   var amount = AmountModel(
  //     currency: 'USD',
  //     total: "100",
  //     details: AmountDetailsModel(
  //       shipping: '0',
  //       shippingDiscount: 0,
  //       subtotal: '100',
  //     ),
  //   );
  //
  //   List<ItemModel> items = [
  //     ItemModel(
  //       name: "computer",
  //       quantity: 10,
  //       price: "4",
  //       currency: "USD",
  //     ),
  //     ItemModel(
  //       name: "apple",
  //       quantity: 12,
  //       price: "5",
  //       currency: "USD",
  //     ),
  //     // Optional
  //     //   "shipping_address": {
  //     //     "recipient_name": "Tharwat samy",
  //     //     "line1": "tharwat",
  //     //     "line2": "",
  //     //     "city": "tharwat",
  //     //     "country_code": "EG",
  //     //     "postal_code": "25025",
  //     //     "phone": "+00000000",
  //     //     "state": "ALex"
  //     //  },
  //   ];
  //
  //   var itemList = ItemListModel(
  //     items: items,
  //   );
  //
  //   return (amount: amount, itemList: itemList);
  // }
}
