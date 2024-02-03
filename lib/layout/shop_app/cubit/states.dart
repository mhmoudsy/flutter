import 'package:fproject/models/shop_models/change_favorites_model.dart';

import '../../../models/shop_models/shop_login_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates {}
class ShopChangeBottomNavState extends ShopStates {}
class ShopLoadingDataHomeState extends ShopStates {}
class ShopSuccessDataHomeState extends ShopStates {}
class ShopErrorDataHomeState extends ShopStates {
  final error;
  ShopErrorDataHomeState(this.error);
}

class ShopSuccessDataCategoriesState extends ShopStates {}
class ShopErrorDataCategoriesState extends ShopStates {
  final error;
  ShopErrorDataCategoriesState(this.error);
}
class ShopChangeFavoritesState extends ShopStates {



}
class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavorites model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates {
  final error;
  ShopErrorChangeFavoritesState(this.error);
}
class ShopSuccessGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {
  final error;
  ShopErrorGetFavoritesState(this.error);
}
class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ShopLoginModel userData;

  ShopSuccessGetUserDataState(this.userData);

}
class ShopErrorGetUserDataState extends ShopStates {
  final error;
  ShopErrorGetUserDataState(this.error);
}
class ShopLoadingGetUserDataState extends ShopStates {}
class ShopSuccessUpdataUserDataState extends ShopStates {
  final ShopLoginModel userData;

  ShopSuccessUpdataUserDataState(this.userData);

}
class ShopErrorUpdataUserDataState extends ShopStates {
  final error;
  ShopErrorUpdataUserDataState(this.error);
}
class ShopLoadingUpdataUserDataState extends ShopStates {}
class ShopPickImageState extends ShopStates {}
