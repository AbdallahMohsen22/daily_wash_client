
import 'package:flutter/material.dart';
import 'package:on_express/features/payment/presentation/views/widgets/my_cart_view_body.dart';
class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Cart')
      ),
      body: const MyCartViewBody(),
    );
  }
}
