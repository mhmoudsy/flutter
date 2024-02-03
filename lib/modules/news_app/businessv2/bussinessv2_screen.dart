import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/news_v2/cubit/cubit.dart';
import 'package:fproject/layout/news_v2/cubit/states.dart';
import 'package:fproject/shared/components/components.dart';



class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStateV2>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context)?.Business;
        return ArticalCategory(list,context);
      },

    );
  }
}
