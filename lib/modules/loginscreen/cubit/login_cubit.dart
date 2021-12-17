import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/loginscreen/cubit/login_cubit_states.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void setVis() {
    isPassword = !isPassword;
    emit(ShopLoginChangeVisPassState());
  }

  LoginModel model;

  void userLogin({@required email, @required password}) {
    emit(ShopLoginLoadingState());
    DioHelper.setData(
      path: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      model = LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(model.status));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopLoginErrorState());
    });
  }
}
