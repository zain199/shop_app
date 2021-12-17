import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/home_cubit.dart';
import 'package:shop_app/layout/shop_cubit/home_cubit_states.dart';

import 'package:shop_app/modules/loginscreen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/Cache_Helper.dart';

class ShopLayout extends StatelessWidget {

  bool first = true;

  ShopLayout(bool first)
  {
    this.first= first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(first)
          {
            first = false;
            ShopHomeCubit.bottomNavItemIndex=0;
          }

        var cubit = ShopHomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.search),iconSize: 25.0,)
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
                cubit.setBottomNavItemIndex(index);
            },
            currentIndex: ShopHomeCubit.bottomNavItemIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
          body: cubit.screens[ShopHomeCubit.bottomNavItemIndex],
        );
      },
    );
  }

}
