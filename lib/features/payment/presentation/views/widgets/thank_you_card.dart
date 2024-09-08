import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:on_express/features/payment/presentation/views/widgets/payment_info_item.dart';
import 'package:on_express/features/payment/presentation/views/widgets/total_price_widget.dart';
import '../../../../../core/utils/color_resources.dart';
import 'card_info_widget.dart';
import 'custom_check_icon.dart';

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thank you"),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Center(
            child: SvgPicture.asset(
              'assets/images/arrow.svg',
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color(0xFFEDEDED),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 22, right: 22),
          child: Column(
            children: [
              const CustomCheckIcon(),
               Text(
                'Thank you!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorResources.primaryColor
                ),
              ),
              Text(
                'Your transaction was successful',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorResources.primaryColor
                ),
              ),
              const SizedBox(
                height: 42,
              ),
              const PaymentItemInfo(
                title: 'Date',
                value: '01/24/2023',
              ),
              const SizedBox(
                height: 20,
              ),
              const PaymentItemInfo(
                title: 'Time',
                value: '10:15 AM',
              ),
              const SizedBox(
                height: 20,
              ),
              const PaymentItemInfo(
                title: 'To',
                value: 'Sam Louis',
              ),
              const Divider(
                height: 40,
                thickness: 2,
              ),
              const TotalPrice(title: 'Total', value: r'$50.97'),
              const SizedBox(
                height: 30,
              ),
              const CardInfoWidget(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    FontAwesomeIcons.barcode,
                    size: 64,
                  ),
                  Container(
                    width: 113,
                    height: 58,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1.50, color: Color(0xFF34A853)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'PAID',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorResources.primaryColor
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ((MediaQuery.sizeOf(context).height * .2 + 20) / 2) - 29,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
