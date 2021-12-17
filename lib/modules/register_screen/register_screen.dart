import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shoplayout.dart';
import 'package:shop_app/modules/register_screen/cubit/register_cubit.dart';
import 'package:shop_app/modules/register_screen/cubit/register_cubit_states.dart';
import 'package:shop_app/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();

  final TextEditingController pass = TextEditingController();
  var keysss = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: keysss,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      DefTextForm(
                        hint: 'User Name',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter the Username';
                          }
                          return null;
                        },
                        prefixicon: Icon(Icons.person),
                        controller: name,
                        type: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      DefTextForm(
                        hint: 'Email',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter the Email';
                          }
                          return null;
                        },
                        prefixicon: Icon(Icons.email),
                        controller: email,
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      DefTextForm(
                        isPassword: cubit.isPassword,
                        suffixicon: cubit.isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        sufOnPressed: () {
                          cubit.setVis();
                        },
                        prefixicon: Icon(Icons.lock),
                        controller: pass,
                        type: TextInputType.emailAddress,
                        hint: 'password',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter the Password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      DefTextForm(
                        prefixicon: Icon(Icons.phone),
                        controller: phone,
                        type: TextInputType.phone,
                        hint: 'Phone',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Enter the Phone';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

                      DefButton(
                          color: Colors.amber,
                          fun: () {
                            if (keysss.currentState.validate()) {
                              cubit.getRegisterResponse(
                                name: name.text,
                                phone: phone.text,
                                email: email.text,
                                password: pass.text,
                              );

                                if (cubit.model.status) {
                                  toastMessage(
                                      msg: cubit.model.message, state: 0);
                                  NavigatorToAndKill(context, ShopLayout(true));
                                } else
                                  toastMessage(
                                      msg: cubit.model.message, state: 2);

                            }
                          },
                          child: Text('Register')),
                      // ConditionalBuilder(
                      //   condition: cubit.model.status,
                      //   builder: (context) =>
                      //
                      //   fallback: (context) => toastMessage(msg: cubit.model.message, state: 2);
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
