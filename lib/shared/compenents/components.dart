import 'package:flutter/material.dart';
import 'package:payment_gateway_integration/bloc/cubit.dart';
import 'package:payment_gateway_integration/models/food_model.dart';
import 'package:payment_gateway_integration/modules/payment_screen.dart';
import 'package:payment_gateway_integration/shared/compenents/responsive.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onpressed;
  MyButton({
    required this.icon,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 45,
      onPressed: onpressed,
      shape: CircleBorder(side: BorderSide(color: Colors.deepPurple.shade900)),
      child: Icon(
        icon,
        color: Colors.deepPurple.shade900,
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  Food food;
  int quantity;
  VoidCallback add;
  VoidCallback remove;

  FoodCard({
    required this.food,
    required this.quantity,
    required this.add,
    required this.remove,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 4,
                offset: Offset(5, 5),
                color: Colors.black.withOpacity(.4)),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.deepPurple.shade600,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 3.5,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(food.image),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                      width: 1, color: Colors.purpleAccent.shade700)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    food.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Price :${food.price} LE',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(icon: Icons.remove, onpressed: remove),
                      Text(
                        '$quantity',
                        style: TextStyle(fontSize: 18),
                      ),
                      MyButton(icon: Icons.add, onpressed: add),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final dynamic price;
  BuyButton({required this.text, required this.onPressed, this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: MaterialButton(
        height: 50,
        padding: EdgeInsets.zero,
        color: Colors.deepPurpleAccent.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              width: 5,
            ),
            if (price != null)
              Text(
                '$price' r'$',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
          ],
        ),
      ),
    );
  }
}

class FloatingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PaymentScreen();
        }));
      },
      elevation: 20,
      backgroundColor: Colors.deepPurpleAccent.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      icon: Icon(
        Icons.shopping_cart_outlined,
        color: Colors.white,
      ),
      label: Row(
        children: [
          Text(
            'Buy',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          SizedBox(
            width: 5,
          ),
          if (AppCubit.get(context).finalPrice != null &&
              AppCubit.get(context).finalPrice > 0)
            Text(
              '${AppCubit.get(context).finalPrice}' r'$',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )
        ],
      ),
    );
  }
}

class MyFormField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String errorText;
  final TextInputType? keyboard;

  MyFormField(
      {required this.text,
      required this.controller,
      required this.errorText,
      this.keyboard});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.deepPurple.shade800),
          enabledBorder: OutlineInputBorder(
              gapPadding: 6,
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.deepPurple.shade800)),
          labelText: text,
          focusedBorder: OutlineInputBorder(
              gapPadding: 6,
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.deepPurple.shade800)),
          border: OutlineInputBorder(
              gapPadding: 6,
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.deepPurple.shade800))),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}

class ToggleButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  ToggleButton({Key? key, required this.image, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      clipBehavior: Clip.antiAlias,
      splashColor: Colors.red,
      child: FadeInImage(
        placeholder: AssetImage('assets/images/loading.jpeg'),
        fit: BoxFit.cover,
        placeholderFit: BoxFit.cover,
        height: rhight(context) / 4,
        width: rwidth(context) / 1.1,
        image: NetworkImage(
          image,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.deepPurple.shade700, width: 3),
      ),
    );
  }
}

PreferredSizeWidget myAppBar(
  context, {
  required String title,
  bool isback = false,
}) {
  return AppBar(
    centerTitle: true,
    title: Text(title),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 5,
    backgroundColor: Colors.deepPurpleAccent.shade700,
    leading: isback
        ? IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : null,
  );
}
