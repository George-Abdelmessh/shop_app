import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categorise/categorise_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/shop_cubit/states.dart';

class ShopCubit extends Cubit<ShopStates> {

  int currentIndex = 0;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  ChangeFavoritesModel? changeFavoritesModel;
  FavoritesModel? favoritesModel;
  LoginModel? userModel;

  Map<int, bool> favorites = {};

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriseScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  void changeBottom (int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void getHomeData(){
    emit(ShopLoadingHomeDateState());
    DioHelper.getDate(
        url: HOME,
        token: token,
    ).then((value){
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());
      emit(ShopSuccessHomeDateState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDateState());
    });
  }

  void getCategoriesData(){
    DioHelper.getDate(
        url: GET_CATEGORIES,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.status);
      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  void changeFavorites(int productId){

    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postDate(
        url: FAVORITES,
        data: {
          'product_id': productId
        },
        token: token
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.formJson(value.data);

      if(!changeFavoritesModel!.status){
        favorites[productId] = !favorites[productId]!;
      }else {
        getFavoritesData();
      }

      emit(ShopSuccessFavoritesState(changeFavoritesModel!));
      print(value.data);
    }).catchError((error){
      print(error.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorFavoritesState());
    });
  }

  void getFavoritesData(){
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getDate(
      url: FAVORITES,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel!.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  void getUserData(){
    emit(ShopLoadingUserDataState());
    DioHelper.getDate(
      url: PROFILE,
      token: token,
    ).then((value){
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }
}