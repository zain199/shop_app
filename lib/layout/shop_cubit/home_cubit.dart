import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/home_cubit_states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/category_screen/category_screen.dart';
import 'package:shop_app/modules/favorite_screen/favorite_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';

class ShopHomeCubit extends Cubit<ShopHomeStates>
{

  ShopHomeCubit() : super(ShopHomeInitalState());

  static ShopHomeCubit get(context) => BlocProvider.of(context);

  static int bottomNavItemIndex = 0 ;

  void setBottomNavItemIndex(int index)
  {
    bottomNavItemIndex = index;
    emit(ShopHomeBottomNavIndexState());
  }

  List screens =
  [
    HomeScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];



  HomeDataModel model;
  Map<int,Product> products = {};
  void getHomeData(String token)
  {
    products= {};
    emit(ShopHomeLoadingState());
    DioHelper.getData(
        path:HOME,
        token:token
    ).then((value){
      model = HomeDataModel.formJson(value.data);
      model.data.products.forEach((element) {
        products.addAll({element.id:element});
      });
      emit(ShopHomeSuccessState());
    }).catchError((onError){
        print(onError.toString());
        emit(ShopHomeErrorState());
    });
  }

  CategoryDataModel categoryDataModel;
  void getCategoryData()
  {
    DioHelper.getData(
        path:CATEGORYS,
    ).then((value){
      categoryDataModel = CategoryDataModel.fromJson(value.data);
      emit(ShopCategorySuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopCategoryErrorState());
    });
  }


  void changeFavorites(int product_id,String token,Product product)
  {

    product.inFavorite = !product.inFavorite;
    emit(ShopFavoritesReloadingState());

    DioHelper.setData(
        path: FAVORITES,
        data: {
          'product_id':product_id,
        },
      token: token
    ).then((value) {

      print(value.data['message'].toString());
      if(!value.data['status'])
        {
          product.inFavorite = !product.inFavorite;
          toastMessage(msg:value.data['message'].toString(),state: 2 );
        }else
          getFavoriteData(token);

      emit(ShopFavoritesSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopFavoritesErrorState());
    });
  }

 FavoritesDataModel favoritesDataModel;
  void getFavoriteData(String token)
  {

    DioHelper.getData(
      path:FAVORITES,
      token: token
    ).then((value){
      //print(value.data['data'].toString());
      favoritesDataModel = FavoritesDataModel.fromJson(value.data);
      emit(ShopGetFavoritesSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopGetFavoritesErrorState());
    });
  }


}