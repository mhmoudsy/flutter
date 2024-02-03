import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/news_v2/cubit/cubit.dart';
import 'package:fproject/layout/news_v2/cubit/states.dart';
import 'package:fproject/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
var textFieldController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStateV2>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context)?.Search;
        return  Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextField(
                  suffix: Icons.cleaning_services_rounded,
                  suffixPressed:(){
                    NewsCubit.get(context)?.searchClear();
                    textFieldController.clear();
                  } ,
                  Controller: textFieldController,
                  LableText: 'Search',
                  onChang: (value){
                    NewsCubit.get(context)?.getSearch(value);
                  },
                  prefix: Icons.search,
                  Type: TextInputType.text,
                  validator: (value){
                    if(value.isEmpty){
                      return 'must be not empty';
                    }
                    return null;
                  },
                ),
              ),

              Expanded(child: ArticalCategory(list,context,isSearch: true))
            ],
          ),
        );
      },

    );
  }
}
