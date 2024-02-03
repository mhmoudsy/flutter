import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/models/shop_models/shop_login_model.dart';
import 'package:fproject/modules/shop_app/shop_login/cubit/states.dart';
import 'package:fproject/shared/network/end_points.dart';
import 'package:fproject/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({
  required String email,
  required String password,
}){
  emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }
    ).then((value) {
      print(value.data['status']);
      loginModel=ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword ?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopLoginPasswordVisibilityState());
  }
}