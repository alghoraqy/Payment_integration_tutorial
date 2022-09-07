import 'package:flutter/material.dart';

String apikey =
    'ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SnVZVzFsSWpvaWFXNXBkR2xoYkNJc0luQnliMlpwYkdWZmNHc2lPalEwTWpNME1Dd2lZMnhoYzNNaU9pSk5aWEpqYUdGdWRDSjkueW9vYkc4NnViX3JnVUZtcmM0U09oN3BNSmN3SzFZaDh3Tl9tQ1ZidjdteUZ1YWJRdzlObXZ3c2FWMGFvZWZobXROU2FYSldCeXE1c0Qtc3NwMzZsYVE=';

String token = '';
String orderId = '';

int integerationIdCard = 2700885;
String paymentToken = '';

String refCode = '';

Future navigateto(context, Widget screen) {
  return Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}
