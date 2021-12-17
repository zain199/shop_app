import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/modules/register_screen/cubit/register_cubit_states.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/local/Cache_Helper.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitalState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void setVis() {
    isPassword = !isPassword;
    emit(ShopRegisterChangeVisPassState());
  }

  RegisterDataModel model;

  void getRegisterResponse({@required String name,@required String phone,@required String email,@required String password,}) {

    emit(ShopRegisterLoadingState());
    DioHelper.setData(
      path: REGISTER,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
        'password':password
      },
    ).then((value) {

      model = RegisterDataModel.fromJson(value.data);
      if(model.status)
        {
          token = model.data.token;
          Cache_Helper.setData('token', token);
        }
      emit(ShopRegisterSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopRegisterErrorState());
    });
  }
}
