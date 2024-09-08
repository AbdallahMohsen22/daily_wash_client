import 'package:dio/dio.dart';

class ApiService{
  final Dio dio =Dio();

  Future<Response> post (
      {required body,
        required String url,
        required String token,
        Map<String,String>? headers,
        String? contentType}) async{

    var response= await dio.post(url,
        data: body,  // body is x-www-form-urlencoded   and is not form-data
        options: Options(
        contentType: Headers.formUrlEncodedContentType,     // 'Content-Type' : 'application/x-www-form-urlencoded'
        headers: headers ??
        {
          'Authorization' : 'Bearer $token'
        },

    ));
    return response;
  }
}

//paymentIntentObject create payment intent (amount , currency, customerId)
//KeySecret createEphemeralKey(stripeVersion, customerId)
//initPaymentSheet (merchantDisplayName , intentClientSecret, ephemeralKeySecret)
//presentPaymentSheet()