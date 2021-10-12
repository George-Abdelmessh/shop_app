import 'package:shop_app/models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDateState extends ShopStates {}

class ShopSuccessHomeDateState extends ShopStates {}

class ShopErrorHomeDateState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessFavoritesState(this.model);

}

class ShopErrorFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserState extends ShopStates {}
class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {}