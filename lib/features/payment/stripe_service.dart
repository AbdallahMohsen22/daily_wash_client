import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'api_keys.dart';
import 'api_service_payment.dart';
import 'data/models/customer_payment_model.dart';
import 'data/models/ephemeral_key_model.dart';
import 'data/models/init_payment_sheet_input_model.dart';
import 'data/models/payment_intent_input_model.dart';
import 'data/models/payment_intent_model.dart';

class StripeService {
  final ApiService apiService =ApiService();

  //Create Payment Intent
  Future<PaymentIntentModel> createPaymentIntent (PaymentIntentInputModel paymentIntentInputModel) async{

    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),  //toJson is function to convert my body to (amount,currency) to json
      contentType: Headers.formUrlEncodedContentType,   // 'application/x-www-form-urlencoded'
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretKeyLive,
    );

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  //setup Payment Sheet using Stripe
  Future initPaymentSheet (
      {required String paymentIntentClientSecret}) async{

   await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,

          // customerEphemeralKeySecret: initPaymentSheetInputModel.ephemeralKeySecret,
          // customerId: initPaymentSheetInputModel.customerId,
        merchantDisplayName: 'Daily Wash', // Your business name
        // applePay: PaymentSheetApplePay(merchantCountryCode: 'DE'),
        // Enable Google Pay
        googlePay: PaymentSheetGooglePay(
          merchantCountryCode: 'AE', // Set your merchant's country code
          currencyCode: 'AED',        // Set your currency code for the transaction
          testEnv: true,              // Use test environment during development
        ),
      ),
    );


  }



  //display Payment Sheet
  Future displayPaymentSheet () async {
   await Stripe.instance.presentPaymentSheet();
  }




  //نقطة بداية اقدر استدعيها وتنفذ كل عملية ال payment
  Future makePayment({required PaymentIntentInputModel paymentIntentInputModel}) async{

    //create (createPaymentIntent)
    var paymentIntentModel= await createPaymentIntent(paymentIntentInputModel);

    //var ephemeralKeyModel= await createEphemeralKey(customerId: paymentIntentInputModel.customerId);


    //var initPaymentSheetInputModel = InitPaymentSheetInputModel(clientSecret: paymentIntentModel.clientSecret, customerId: paymentIntentInputModel.customerId, ephemeralKeySecret: ephemeralKeyModel.secret);

    // var customerPaymentModel= await createCustomer(customerPaymentInputModel);


    //initialize
    await initPaymentSheet(
        paymentIntentClientSecret: paymentIntentModel.clientSecret);

    //display
    await displayPaymentSheet();



  }
  //
  // Future<EphemeralKeyModel> createEphemeralKey ({required String customerId}) async{
  //
  //   var response = await apiService.post(
  //     body: {
  //       'customer' : customerId,
  //     },  //toJson is function to convert my body to (amount,currency) to json
  //     contentType: Headers.formUrlEncodedContentType,   // 'application/x-www-form-urlencoded'
  //     url: 'https://api.stripe.com/v1/ephemeral_keys',
  //     token: ApiKeys.secretKey,
  //     headers:
  //     {
  //       'Authorization' : 'Bearer ${ApiKeys.secretKey}',
  //       'Stripe-Version' : '2024-06-20',
  //     },
  //   );
  //
  //   var ephemeralKey = EphemeralKeyModel.fromJson(response.data);
  //   return ephemeralKey;
  // }
  //
  // Future<PaymentIntentModel> createCustomer (CustomerPaymentInputModel customerPaymentInputModel) async{
  //
  //   var response = await apiService.post(
  //     body: customerPaymentInputModel.toJson(),  //toJson is function to convert my body to (amount,currency) to json
  //     contentType: Headers.formUrlEncodedContentType,   // 'application/x-www-form-urlencoded'
  //     url: 'https://api.stripe.com/v1/customers',
  //     token: ApiKeys.secretKey,
  //   );
  //
  //   var customerInputModel = PaymentIntentModel.fromJson(response.data);
  //   return customerInputModel;
  // }



}