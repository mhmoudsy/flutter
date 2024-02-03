import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/news_v2/cubit/cubit.dart';
import 'package:fproject/layout/news_v2/cubit/states.dart';
import 'package:fproject/modules/news_app/search/search_screen.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/cubit/cubit.dart';


class NewsV2_Layout extends StatelessWidget {
  const NewsV2_Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit,NewsStateV2>(
      listener:(context,state){},
        builder: (context,state){
       var cubit=NewsCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(
              "News App",
            ),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                  icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: (){
                  AppCubit.get(context).changeMode();
                },
                  icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              items:cubit!.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.OnBottomNavigationChange(index);
              },
          ),
          body: cubit.Screens[cubit.currentIndex],

        );
        },
      ),
    );
  }
}
