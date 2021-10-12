import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/shop_cubit/cubit.dart';
import 'package:shop_app/shared/shop_cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    height /= 929.523809524;

    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessFavoritesState){
           if(!state.model.status){
             showToast(
                 text: state.model.message,
                 state: TaostState.ERROR
             );
           }
          }
        },
        builder: (context, state) {

          var cubit = ShopCubit.get(context);

          return cubit.homeModel != null && cubit.categoriesModel != null ?
          productsBuilder(cubit.homeModel, cubit.categoriesModel, context, height) :
          Center(child: CircularProgressIndicator(),);
        },
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel, context, height) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners.map((e){
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
                viewportFraction: 1.0,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(
                          categoriesModel!.data!.data![index]
                      ),
                      separatorBuilder: (context, index) =>  SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel!.data!.data!.length,
                      physics: BouncingScrollPhysics(),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
          height: 15,
        ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / height,
                children: List.generate(
                    model.data!.products.length,
                        (index) => buildGridProduct(model.data!.products[index], context)
                ),
          ),
        ),
        ],
      ),
  );

  Widget buildCategoryItem(DataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage('${model.image}'),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100,
        child: Text(
          '${model.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductsModel model, context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                model.image.toString(),
              ),
              height: 200.0,
              width: double.infinity,
            ),
            if(model.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}\n',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.4,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.4,
                      color: defaultColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5,),
                  if(model.discount != 0)
                    Text(
                    '${model.oldPrice.round()}',
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
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: ShopCubit.get(context).favorites[model.id]!?
                          Colors.red: Colors.grey,
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
  );
}

