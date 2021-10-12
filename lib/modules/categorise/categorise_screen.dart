import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/shop_cubit/cubit.dart';
import 'package:shop_app/shared/shop_cubit/states.dart';

class CategoriseScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit = ShopCubit.get(context);

        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(
              cubit.categoriesModel!.data!.data![index]
          ),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: cubit.categoriesModel!.data!.data!.length,
          physics: BouncingScrollPhysics(),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios
        ),
      ],
    ),
  );
}
