import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/shop_app/cubit/states.dart';
import 'package:fproject/models/shop_models/categories_model.dart';
import 'package:fproject/models/shop_models/change_favorites_model.dart';
import 'package:fproject/models/shop_models/get_favorites_model.dart';
import 'package:fproject/models/shop_models/home_model.dart';
import 'package:fproject/models/shop_models/shop_login_model.dart';
import 'package:fproject/modules/shop_app/categories/categories_screen.dart';
import 'package:fproject/modules/shop_app/favorites/favorites_screen.dart';
import 'package:fproject/modules/shop_app/products/products_screen.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/components/constants.dart';
import 'package:fproject/shared/network/end_points.dart';
import 'package:fproject/shared/network/remote/dio_helper.dart';
import 'package:image_picker/image_picker.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  var currentIndex = 0;
  List<Widget> shopScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    // SettingsScreen(),
  ];
  Map<int, bool> favorites = {};

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingDataHomeState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data?.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites,
        });
      });
      printAll(favorites.toString());
      emit(ShopSuccessDataHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorDataHomeState(error));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessDataCategoriesState());
    }).catchError((error) {
      print(error.toString());
      printAll('error');
      emit(ShopErrorDataCategoriesState(error));
    });
  }

  ChangeFavorites? changeFavorites;
  void favoriteChange(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {"product_id": productId},
      token: token,
    ).then((value) {
      changeFavorites = ChangeFavorites.fromJson(value.data);
      if (!changeFavorites!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavorites!));
      printAll(value.data.toString());
    }).catchError((error) {
      print(error.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState(error));
      print(error.toString());
    });
  }

  ShopLoginModel? userData;
  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState(userData!));
    }).catchError((error) {
      emit(ShopErrorGetUserDataState(error));
      print(error.toString());
    });
  }
  void updateUserData({
    required String name,
    required String email,
    required String phone,
     String? image,
}) {
    emit(ShopLoadingUpdataUserDataState());
    DioHelper.putData(
      url: UPDATA_PROFILE,
      token: token,
      data: {
      'name':name,
      'email':email,
      'phone':phone,
      'image':image,
    },
    ).then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdataUserDataState(userData!));
    }).catchError((error) {
      emit(ShopErrorUpdataUserDataState(error));
      print(error.toString());
    });
  }
  PickedFile? imageFile;
  Future pickImage() async {
    final imagePicker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      imageFile = PickedFile(imagePicker.path);
      print(File(imageFile!.path));
      emit(ShopPickImageState());

    }
  }

}
