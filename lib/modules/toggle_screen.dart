import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:payment_gateway_integration/modules/ref_code_screen.dart';
import 'package:payment_gateway_integration/modules/vias_screen.dart';
import 'package:payment_gateway_integration/shared/compenents/components.dart';
import 'package:payment_gateway_integration/shared/compenents/responsive.dart';
import 'package:payment_gateway_integration/shared/constances/constances.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, title: 'Choose Way', isback: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: rwidth(context) / 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ToggleButton(
              image:
                  'https://ae.visamiddleeast.com/dam/VCOM/regional/ve/romania/blogs/hero-image/visa-logo-800x450.jpg',
              onPressed: () {
                navigateto(context, VisaScreen());
              },
            ),
            SizedBox(
              height: 20,
            ),
            ToggleButton(
              image:
                  'https://cdn.searchenginejournal.com/wp-content/uploads/2020/03/the-top-10-most-popular-online-payment-solutions-5e9978d564973-1520x800.png',
              onPressed: () {
                navigateto(context, RefCodeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
