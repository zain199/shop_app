import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/loginscreen/cubit/login_cubit_states.dart';
import 'package:shop_app/modules/settings_screen/cubit/settings_cubit_states.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/remote/diohelper.dart';

class ShopSettingsCubit extends Cubit<ShopSettingsStates> {
  ShopSettingsCubit() : super(ShopSettingsInitState());

  static ShopSettingsCubit get(context) => BlocProvider.of(context);

  LoginModel model;

  void userSettings() {

    emit(ShopSettingsLoadingState());
    DioHelper.getData(
      path: PROFILE,
      token: token,
    ).then((value) {

      model = LoginModel.fromJson(value.data);
      emit(ShopSettingsSuccessState(model.status));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopSettingsErrorState());
    });
  }


  void userUpdate({@required String name ,@required String email, @required String phone}) {
    emit(ShopSettingsLoadingState());
    DioHelper.putData(
      path: UPDATE,
      data: {
        'name': name,
        'email':email,
        'phone':phone
      },
      token: token
    ).then((value) {
      model = LoginModel.fromJson(value.data);
      print(model.data.email);
      emit(ShopSettingsUpdateSuccessState(model.status));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopSettingsUpdateErrorState());
    });
  }
}
