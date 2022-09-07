import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_gateway_integration/modules/home_screen.dart';
import 'package:payment_gateway_integration/shared/compenents/responsive.dart';
import 'package:payment_gateway_integration/shared/constances/constances.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this);

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
    });

    // controller.addStatusListener((status) async {
    //   if (status == AnimationStatus.completed) {
    //     Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder: (context) {
    //       return HomeScreen();
    //     }));
    //   }
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade700,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/splash.json',
              //  controller: controller,
              //     onLoaded: (composition) {
              //   controller
              //     ..duration = composition.duration
              //     ..forward();
              // },
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Payment',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
