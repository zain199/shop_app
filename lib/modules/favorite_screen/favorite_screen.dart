import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/home_cubit.dart';
import 'package:shop_app/layout/shop_cubit/home_cubit_states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/network/local/Cache_Helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = ShopHomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.favoritesDataModel!=null && state is !ShopFavoritesReloadingState ,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => favoriteItem(cubit.favoritesDataModel.data.data[index].product,context),
              separatorBuilder: (context, index) => Divider(
                height: 10.0,
              ),
              itemCount: cubit.favoritesDataModel.data.data.length
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget favoriteItem(ProductData product,context)
  {
    return  Container(
      height: 120.0,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(product.image),
                width: 120.0,
                height: 120.0,
                //fit: BoxFit.cover,
              ),
              if (product.discount != 0)
                Container(
                  color: Colors.red,
                  height: 15.0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 5.0,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    children: [
                      Text(
                        '${product.price}EGP',
                        style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: defColor),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      if (product.discount != 0)
                        Text(
                          '${product.oldPrice}EGP',
                          style: TextStyle(
                              fontSize: 8.0, decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 15.0,
                        child: IconButton(
                          color: defColor,
                          icon:  Icon(Icons.favorite_rounded) ,
                          onPressed: () {
                            ShopHomeCubit.get(context).changeFavorites(product.id,Cache_Helper.getData('token'),ShopHomeCubit.get(context).products[product.id]);
                          },
                          iconSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
