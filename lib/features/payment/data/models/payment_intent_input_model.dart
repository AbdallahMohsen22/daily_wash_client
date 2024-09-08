class PaymentIntentInputModel{
  final String amount;
  final String currency;
   final String? customerId;

  PaymentIntentInputModel({
     this.customerId,
    required this.amount,
    required this.currency});

  // to send amount, currency
  toJson(){
    return {
      'amount' : '${amount}00',  //ماينفعش تعمل كدا غيير لو كان رقم صحيح غير كدا لازم تحوله وبعدين تضرب ف 100
      'currency' : currency,
       'customer' : customerId,
    };
  }
}