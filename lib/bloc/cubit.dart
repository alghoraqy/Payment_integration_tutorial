import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_gateway_integration/bloc/states.dart';
import 'package:payment_gateway_integration/models/food_model.dart';
import 'package:payment_gateway_integration/shared/constances/constances.dart';
import 'package:payment_gateway_integration/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitState());

  static AppCubit get(context) => BlocProvider.of(context);

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  List<Food> foodList = [
    Food(
      id: 1,
      title: 'Pepsi',
      image:
          'https://cdnprod.mafretailproxy.com/sys-master-root/hab/hc0/14539671011358/3818_main.jpg_480Wx480H',
      price: 10,
      quantity: 0,
    ),
    Food(
      id: 2,
      title: 'Cola',
      image:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/CocaColaBottle_background_free.jpg/220px-CocaColaBottle_background_free.jpg',
      price: 20,
      quantity: 0,
    ),
  ];
  Map<int, dynamic> finalPriceMap = {};
  dynamic finalPrice;

  void changequantity(bool add, Food food) {
    if (add) {
      food.quantity++;
      getFinalPrice(food);
      emit(ChangeSuccess());
    } else {
      if (food.quantity > 0) {
        food.quantity--;
        getFinalPrice(food);
        emit(ChangeSuccess());
      } else {
        food.quantity;
        getFinalPrice(food);
        emit(ChangeSuccess());
      }
    }
  }

  void getFinalPrice(Food food) {
    finalPriceMap.addAll({food.id: food.price * food.quantity});
    finalPrice =
        finalPriceMap.values.reduce((value, element) => value + element);
  }

  void getToken({
    required String email,
    required String firstname,
    required String lastname,
    required dynamic phone,
    required String price,
  }) {
    emit(LoadingState());
    DioHelper.postData(path: '/auth/tokens', data: {
      'api_key': apikey,
    }).then((value) {
      token = value.data['token'];
      getOrderId(
        token: token,
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone,
        price: price,
      );
      print(token);
    }).catchError((error) {
      print(error.toString());
      emit(GetTokenError());
    });
  }

  void getOrderId({
    required String token,
    required String email,
    required String firstname,
    required String lastname,
    required dynamic phone,
    required String price,
  }) {
    DioHelper.postData(path: '/ecommerce/orders', data: {
      "auth_token": token,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      'items': [],
    }).then((value) {
      orderId = value.data['id'].toString();
      print(orderId);
      getPaymentToken(
          email: email,
          firstname: firstname,
          lastname: lastname,
          phone: phone,
          price: price);
    }).catchError((error) {
      print(error.toString());
      emit(GetOrderIdError());
    });
  }

  void getPaymentToken({
    required String email,
    required String firstname,
    required String lastname,
    required dynamic phone,
    required String price,
  }) {
    DioHelper.postData(path: '/acceptance/payment_keys', data: {
      "auth_token": token,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": orderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstname,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastname,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integerationIdCard,
    }).then((value) {
      paymentToken = value.data['token'];
      getRefCode();
      print(paymentToken);
    }).catchError((error) {
      print(error.toString());
      emit(GetPaymentTokenSuccess());
    });
  }

  void getRefCode() {
    DioHelper.postData(path: '/acceptance/payments/pay', data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": paymentToken,
    }).then((value) {
      refCode = value.data['id'].toString();
      emit(GetRefCodeSuccess());
    }).catchError((error) {
      emit(GetRefCodeError());
      print(error.toString());
    });
  }
}
