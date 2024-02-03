import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/shop_app/cubit/cubit.dart';
import 'package:fproject/layout/shop_app/cubit/states.dart';
import 'package:fproject/models/shop_models/categories_model.dart';
import 'package:fproject/models/shop_models/home_model.dart';
import 'package:fproject/modules/shop_app/product_details/product_details_screen.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (Context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status) {
            showToast(
              text: state.model.message!,
              state: ToastState.ERROR,
            );
          }
        }
      },
      builder: (Context, state) {
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoriesModel != null,
            builder: (context) => builderWidget(
                cubit.homeModel!, cubit.categoriesModel!, context),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );

      },
    );
  }
}

Widget builderWidget(
        HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            //Change to list of widget

            items: model.data?.banners
                .map((e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              height: 220.0,
              initialPage: 0,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              reverse: false,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesModel.data!.data[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 15.0,
                    ),
                    itemCount: categoriesModel.data!.data.length,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.60,
              children: List.generate(
                model.data!.products.length,
                (index) => productGridViewBuilder(
                    model.data!.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );
Widget productGridViewBuilder(ProductsModel model, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image(
                  image: NetworkImage(model.image!),
                  height: 175.0,
                  width: double.infinity,
                ),
              ),
              if (model.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: Text(
                    'discount'.toUpperCase(),
                    style: const TextStyle(fontSize: 11.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.1, fontSize: 14.0,fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 14.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context).favoriteChange(model.id!);
                        },
                        icon: ShopCubit.get(context).favorites[model.id]!
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 25,
                              )
                            : const Icon(
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
    );
Widget buildCategoryItem(DataModel model,) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(
            model.image!,
          ),
          fit: BoxFit.cover,
          height: 100.0,
          width: 100.0,
        ),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            model.name!,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
