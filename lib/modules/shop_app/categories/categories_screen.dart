import 'package:flutter/material.dart';
import 'package:fproject/layout/shop_app/cubit/cubit.dart';
import 'package:fproject/models/shop_models/categories_model.dart';
import 'package:fproject/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            builderCatItem(cubit.categoriesModel!.data!.data[index]),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: cubit.categoriesModel!.data!.data.length,

    );
  }

  Widget builderCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image!,
              ),
              fit: BoxFit.cover,
              height: 85.0,
              width: 85.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name!,
              style: TextStyle(
                fontSize: 21.0,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios_outlined),
            )
          ],
        ),
      );
}
