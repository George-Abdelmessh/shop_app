import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
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
      print(homeModel!.status);
      emit(ShopSuccessHomeDateState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDateState());
    });
  }

}