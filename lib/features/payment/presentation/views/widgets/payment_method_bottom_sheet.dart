import 'package:flutter/material.dart';
import 'package:on_express/features/payment/presentation/views/widgets/payment_methods_list_view.dart';
import 'custom_botton_bloc_consumer.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(),
          SizedBox(
            height: 32,
          ),
          // CustomButtonBlocConsumer(),
        ],
      ),
    );
  }
}