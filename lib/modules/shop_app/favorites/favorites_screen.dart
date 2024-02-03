import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/shop_app/cubit/states.dart';
import 'package:fproject/models/shop_models/get_favorites_model.dart';
import 'package:fproject/shared/components/components.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition:state is! ShopLoadingGetFavoritesState ,
            builder: (context)=> ListView.separated(
              itemBuilder: (context, index) {
                return buildFavoriteItem(
                    cubit.favoritesModel!.data!.data[index], context);
              },
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.favoritesModel!.data!.data.length,

            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),

          ),
        );
      },
    );
  }

  buildFavoriteItem(FavoritesProductData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(model.product!.image!),
                    height: 120.0,
                    width: 120,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      color: Colors.red,
                      child: Text(
                        'discount'.toUpperCase(),
                        style: TextStyle(fontSize: 11.0, color: Colors.white),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      model.product!.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.1,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product!.oldPrice}',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: defaultColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 14.0,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.price}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .favoriteChange(model.product!.id!);
                            },
                            // icon: Icon(Icons.favorite_outline),
                            icon: ShopCubit.get(context)
                                    .favorites[model.product!.id!]!
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 25,
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red,
                                    fill: 0.1,
                                    size: 25,
                                  ),
                            iconSize: 17.0,
                          ),
                        )
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
