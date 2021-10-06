import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/shop_cubit/cubit.dart';
import 'package:shop_app/shared/shop_cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = ShopCubit.get(context);

          return cubit.homeModel != null ? productsBuilder(cubit.homeModel) :
            Center(child: CircularProgressIndicator(),);
        },
    );
  }

  Widget productsBuilder(model) => Column(
    children: [
      CarouselSlider(
        items: model.data!.banners.map((e){
          print(e.image);
          return Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          );
        }).toList(),
        options: CarouselOptions(
          height: 250.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ),
    ],
  );
}

