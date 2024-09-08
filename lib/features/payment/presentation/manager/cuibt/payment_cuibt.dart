
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_express/features/payment/presentation/manager/cuibt/payment_state.dart';
import '../../../data/models/payment_intent_input_model.dart';
import '../../../data/repos/checkout_repo.dart';


class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());

  final CheckoutRepo checkoutRepo;

  Future makePayment ({required PaymentIntentInputModel paymentIntentInputModel}) async{

    emit(PaymentLoading());

    var data = await checkoutRepo.makePayment(paymentIntentInputModel: paymentIntentInputModel);

    data.fold(
            (l) => emit(PaymentFailure(l.errMessage)),
            (r) => emit(PaymentSuccess(),
            ));

  }

  @override
  void onChange (Change<PaymentState> change) {    //بيعرفني الstate اللي انا فيها
    log(change.toString());
    super.onChange(change);
  }

}