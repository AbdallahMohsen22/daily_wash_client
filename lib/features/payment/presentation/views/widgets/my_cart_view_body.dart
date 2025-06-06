
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_express/features/payment/presentation/views/widgets/custom_button.dart';
import 'package:on_express/features/payment/presentation/views/widgets/payment_method_bottom_sheet.dart';
import 'package:on_express/features/payment/presentation/views/widgets/total_price_widget.dart';
import '../../../data/repos/checkout_repo_impl.dart';
import '../../manager/cuibt/payment_cuibt.dart';
import 'cart_info_item.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Expanded(child: Image.asset('assets/images/basket_image.png')),
            const SizedBox(
              height: 25,
            ),
            const OrderInfoItem(
              title: 'Order Subtotal',
              value: r'42.97$',
            ),
            const SizedBox(
              height: 3,
            ),
            const OrderInfoItem(
              title: 'Discount',
              value: r'0$',
            ),
            const SizedBox(
              height: 3,
            ),
            const OrderInfoItem(
              title: 'Shipping',
              value: r'8$',
            ),
            const Divider(
              thickness: 2,
              height: 34,
              color: Color(0xffC7C7C7),
            ),
            const TotalPrice(title: 'Total', value: r'$50.97'),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
              text: 'Complete Payment',
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                //   return const PaymentDetailsView();
                // }));

                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => PaymentCubit(CheckoutRepoImpl()),
                          child: const PaymentMethodsBottomSheet());
                    });
              },
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}


