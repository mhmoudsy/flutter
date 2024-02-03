import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/shop_app/cubit/cubit.dart';
import 'package:fproject/layout/shop_app/cubit/states.dart';
import 'package:fproject/models/shop_models/home_model.dart';

class ProductDetailsScreen extends StatelessWidget {
   ProductDetailsScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int? index=ShopCubit.get(context).homeModel!.data!.products[index].id;
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Center(child: Text('${ShopCubit.get(context).homeModel!.data!.products[0].id}')),
        );
      },

    );
  }
}
