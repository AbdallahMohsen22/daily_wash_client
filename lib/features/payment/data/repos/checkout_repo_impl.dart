

import 'package:dartz/dartz.dart';

import '../../errors.dart';
import '../../stripe_service.dart';
import '../models/payment_intent_input_model.dart';
import 'checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment({required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
