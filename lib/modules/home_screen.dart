import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_gateway_integration/bloc/cubit.dart';
import 'package:payment_gateway_integration/bloc/states.dart';
import 'package:payment_gateway_integration/shared/compenents/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingAction(),
            appBar: myAppBar(context, title: 'Payment Tutorial'),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: cubit.foodList.length,
                      itemBuilder: (context, index) {
                        return FoodCard(
                          food: cubit.foodList[index],
                          quantity: cubit.foodList[index].quantity,
                          add: () {
                            cubit.changequantity(true, cubit.foodList[index]);
                          },
                          remove: () {
                            cubit.changequantity(false, cubit.foodList[index]);
                          },
                        );
                      }),
                ),
              ),
            ),
          );
        });
  }
}
