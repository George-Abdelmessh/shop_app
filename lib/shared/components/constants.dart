import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'components.dart';

String token = '';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value){
    if(value)
      navigateAndFinish(context, ShopLoginScreen());
  });
}
