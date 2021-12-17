

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shoplayout.dart';
import 'package:shop_app/modules/loginscreen/cubit/login_cubit.dart';
import 'package:shop_app/modules/loginscreen/cubit/login_cubit_states.dart';
import 'package:shop_app/modules/register_screen/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/Cache_Helper.dart';

 class LoginScreen extends StatelessWidget {
   final TextEditingController email = TextEditingController();
   final  TextEditingController pass = TextEditingController();
   var keysss = GlobalKey<FormState>();




   @override
   Widget build(BuildContext context) {
     return BlocProvider(
       create: (context) => ShopLoginCubit(),
       child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
         listener: (context, state) {
           var cubit = ShopLoginCubit.get(context);
            if(state is ShopLoginSuccessState)
              {
                if(state.status)
                  {
                    Cache_Helper.setData('token', cubit.model.data.token);
                    token = cubit.model.data.token;
                    NavigatorToAndKill(context,ShopLayout(true));
                    toastMessage(msg: cubit.model.message,state: 0);
                  }else{
                  toastMessage(msg :cubit.model.message, state :2);
                }
              }
         },
         builder: (context, state) {
           var cubit = ShopLoginCubit.get(context);
           return Scaffold(
             appBar: AppBar(),
             body: Center(
               child: Form(
                 key: keysss,
                 child: SingleChildScrollView(

                   child: Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Login',
                           style: TextStyle(
                             fontSize: 30.0,
                             fontWeight: FontWeight.bold,
                           ),
                         ),

                         SizedBox(
                           height: 30.0,
                         ),
                         DefTextForm(
                           hint: 'Email',
                           validate: (value){
                             if(value.isEmpty)
                             {
                               return 'Enter the Email';
                             }
                             return null;
                           },
                           prefixicon: Icon(Icons.email),
                           controller: email
                           ,type: TextInputType.emailAddress,

                         ),
                         SizedBox(
                           height: 15.0,
                         ),
                         DefTextForm(
                           suffixicon: cubit.isPassword ? Icons.visibility : Icons.visibility_off ,
                           sufOnPressed: (){
                                cubit.setVis();
                           },
                           onSubmitted: (value){
                             if(keysss.currentState.validate())
                             {
                               cubit.userLogin(email: email.text, password: pass.text);
                             }
                           },
                           isPassword: cubit.isPassword,
                           prefixicon: Icon(Icons.lock),
                           controller: pass
                           ,type: TextInputType.emailAddress,
                           hint: 'password',
                           validate: (value){
                             if(value.isEmpty)
                             {
                               return 'Enter the Password';
                             }
                             return null;
                           },
                         ),
                         SizedBox(
                           height: 20.0,
                         ),
                         ConditionalBuilder(
                           condition: state is !ShopLoginLoadingState,
                           builder:(context) =>  Container(
                             width: double.infinity,
                             height: 45.0,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(18.0)
                             ),
                             child: DefButton(
                                 color: Colors.amber,
                                 fun: (){
                                   if(keysss.currentState.validate())
                                     cubit.userLogin(email: email.text, password: pass.text);
                                 },
                                 child: Text('LOGIN')
                             ),
                           ),
                           fallback:(context) => Center(child: CircularProgressIndicator(),) ,
                         ),
                         SizedBox(
                           height: 20.0,
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text('Don\'t Have an Account?'),
                             TextButton(onPressed: (){
                               NavigatorTo(context,RegisterScreen());
                             }, child: Text('Register Now'))

                           ],
                         ),
                       ],
                     ),
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



