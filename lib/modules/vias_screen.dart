import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:payment_gateway_integration/shared/compenents/components.dart';
import 'package:payment_gateway_integration/shared/constances/constances.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen({Key? key}) : super(key: key);

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, title: 'Visa Card'),
      body: WebView(
        initialUrl:
            'https://accept.paymob.com/api/acceptance/iframes/670781?payment_token=$paymentToken',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
