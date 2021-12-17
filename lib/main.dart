import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/layout/shop_cubit/home_cubit.dart';
import 'package:shop_app/layout/shop_cubit/home_cubit_states.dart';
import 'package:shop_app/layout/shoplayout.dart';
import 'package:shop_app/modules/loginscreen/login_screen.dart';
import 'package:shop_app/modules/onboarder_screen/onboarder_screen.dart';
import 'package:shop_app/shared/blocobcerver.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/Cache_Helper.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';
import 'package:shop_app/shared/styles/theme.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await Cache_Helper.init();

  Widget screen ;

  if(Cache_Helper.getData('onBoarding')!= null)
    {
      if(Cache_Helper.getData('token')!=null)
        {
          token = Cache_Helper.getData('token');
          screen = ShopLayout(true);
        }
      else
        screen = LoginScreen();

    }else screen = onBoarderScreen();

  runApp(MyApp(screen));
}

class MyApp extends StatelessWidget {
  Widget screen ;


  MyApp(this.screen);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) {
       if( Cache_Helper.getData('token')!=null)
         return  ShopHomeCubit()..getHomeData(Cache_Helper.getData('token').toString())..getCategoryData()..getFavoriteData(Cache_Helper.getData('token').toString());
       else
         return ShopHomeCubit();
      },
      child: BlocConsumer<ShopHomeCubit,ShopHomeStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: screen,
          );
        },
      ),
    );
  }
}
