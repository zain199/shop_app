import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/loginscreen/login_screen.dart';
import 'package:shop_app/modules/settings_screen/cubit/settings_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/Cache_Helper.dart';

import 'cubit/settings_cubit_states.dart';

class SettingsScreen extends StatelessWidget {

  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  var formkey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ShopSettingsCubit()..userSettings(),
      child: BlocConsumer<ShopSettingsCubit,ShopSettingsStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = ShopSettingsCubit.get(context);

          if((cubit.model != null))
            {
              email.text = cubit.model.data.email;
              phone.text = cubit.model.data.phone;
              name.text  = cubit.model.data.name;
            }

          return SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if(state is ShopSettingsLoadingState)
                    Center(child: LinearProgressIndicator()),
                    SizedBox(height: 10.0,),
                    DefTextForm(
                      prefixicon: Icon(Icons.lock),
                      controller: name,
                      type: TextInputType.text,
                      hint: 'Name',
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Enter the Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0,),
                    DefTextForm(
                      type: TextInputType.emailAddress,
                      controller: email,
                      hint: 'Email Address',
                      prefixicon: Icon(Icons.email),
                      validate: (String value) {
                        if (value.isEmpty) return 'email must not be empty';

                        return null;
                      },
                    ),

                    SizedBox(
                      height: 10.0,
                    ),
                    DefTextForm(
                      type: TextInputType.phone,
                      controller: phone,
                      hint: 'Phone Number',
                      prefixicon: Icon(Icons.phone),
                      validate: (String value) {
                        if (value.isEmpty) return 'phone must not be empty';

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    DefButton(
                      child: Text('Update'),
                      fun: (){
                        if(formkey.currentState.validate())
                        {
                          cubit.userUpdate(name:name.text,email: email.text,phone:phone.text);
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DefButton(
                      child: Text('Sign Out'),
                      fun: (){

                            Cache_Helper.removeData('token');
                            NavigatorToAndKill(context, LoginScreen());

                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
