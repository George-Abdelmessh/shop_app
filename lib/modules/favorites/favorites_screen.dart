import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/shop_cubit/cubit.dart';
import 'package:shop_app/shared/shop_cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit = ShopCubit.get(context);

        return state is ShopLoadingGetFavoritesState ?
          Center(child: CircularProgressIndicator(),) :
            ListView.separated(
          itemBuilder: (context, index) => buildFavItem(
              cubit.favoritesModel!.data.data[index], context
          ),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: cubit.favoritesModel!.data.data.length,
          physics: BouncingScrollPhysics(),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model, context) =>  Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.product.image.toString()
                ),
                height: 120.0,
                width: 120.0,
              ),
              if( model.product.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.4,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.product.price.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.4,
                        color: defaultColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if(model.product.discount != 0)
                      Text(
                        model.product.oldPrice.toString(),
                        style: TextStyle(
                            fontSize: 12.0,
                            height: 1.4,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.product.id);
                      },
                      icon: CircleAvatar(
                        radius: 20.0,
                        backgroundColor:
                          ShopCubit.get(context).favorites[model.product.id]! ?
                            Colors.red : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}