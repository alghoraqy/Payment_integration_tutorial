import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_gateway_integration/bloc/cubit.dart';
import 'package:payment_gateway_integration/bloc/states.dart';
import 'package:payment_gateway_integration/modules/toggle_screen.dart';
import 'package:payment_gateway_integration/shared/compenents/components.dart';
import 'package:payment_gateway_integration/shared/constances/constances.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetRefCodeSuccess) {
          navigateto(context, ToggleScreen());
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        cubit.priceController.text = cubit.finalPrice != null
            ? (cubit.finalPrice * 100).toString()
            : 0.toString();
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Payment Screen'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back_ios_new, size: 30, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.deepPurpleAccent.shade700,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyFormField(
                        text: 'First name',
                        controller: cubit.firstnameController,
                        errorText: 'First name Must not be empty'),
                    SizedBox(
                      height: 10,
                    ),
                    MyFormField(
                        text: 'Last name',
                        controller: cubit.lastnameController,
                        errorText: 'Last name Must not be empty'),
                    SizedBox(
                      height: 10,
                    ),
                    MyFormField(
                        keyboard: TextInputType.emailAddress,
                        text: 'E-mail',
                        controller: cubit.emailController,
                        errorText: 'E-mail must not be empty'),
                    SizedBox(
                      height: 10,
                    ),
                    MyFormField(
                        keyboard: TextInputType.phone,
                        text: 'Phone',
                        controller: cubit.phoneController,
                        errorText: 'Phone is required'),
                    SizedBox(
                      height: 10,
                    ),
                    MyFormField(
                        text: 'Price',
                        controller: cubit.priceController,
                        errorText: 'Price must not be empty'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: MaterialButton(
                        height: 50,
                        color: Colors.deepPurpleAccent.shade200,
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.getToken(
                                email: cubit.emailController.text,
                                firstname: cubit.firstnameController.text,
                                lastname: cubit.lastnameController.text,
                                phone: cubit.phoneController.text,
                                price: cubit.priceController.text);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: state is LoadingState
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.payment_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Pay',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
