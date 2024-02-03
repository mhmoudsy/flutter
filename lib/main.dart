import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/shop_app/cubit/cubit.dart';
import 'package:fproject/layout/social_app/cubit/cubit.dart';
import 'package:fproject/layout/social_app/social_layout.dart';
import 'package:fproject/modules/social_app/social_login/social_login_screen.dart';
import 'package:fproject/shared/bloc_observer.dart';
import 'package:fproject/shared/components/constants.dart';
import 'package:fproject/shared/cubit/cubit.dart';
import 'package:fproject/shared/cubit/states.dart';
import 'package:fproject/shared/network/local/chace_helper.dart';
import 'package:fproject/shared/styles/themes.dart';

import 'layout/news_v2/cubit/cubit.dart';
import 'modules/shop_app/shop_login/shop_login_screen.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

   DioHelper.init();
 // DioHelperV2.init();
  await CachHelper.init();
  bool? isDark=CachHelper.getData(key:'isDark');
  uId=CachHelper.getData(key: "uId");
  // bool? onBoarding=CachHelper.getData(key:'onBoarding');
  // token=CachHelper.getData(key:'token');
  // print(token);
  Widget? widget;
// if(onBoarding!=null){
//   if(token!=null) {
//     widget=ShopLayout();
//   } else {
//     widget=ShopLoginScreen();
//   }
// }else{
//   widget=OnBoardingScreen();
// }
 // print(onBoarding);
  if(uId!=null){
    widget=SocialLayout();
  }else{
    widget=SocialLoginScreen();
  }

  runApp(MyApp(isDark,widget));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startWidget;
  MyApp(
      this.isDark,
      this.startWidget
      );
  //final bool isDark=false;

  @override
  //constructor
  //build
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>NewsCubit()..getBusiness()),
        BlocProvider(create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData()),
        BlocProvider(create: (BuildContext context)=>AppCubit()),
        BlocProvider(create: (BuildContext context)=>SocialCubit()..getUserData()..getPosts()),
//..changeMode(
    // fromShared: isDark,

    ],

      child: BlocConsumer<AppCubit,Appstates>(
        listener: (context,state){
        },
        builder: (context,state){
         return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            // themeMode:ThemeMode.light, //AppCubit.get(context).isDark ? ThemeMode.light :ThemeMode.dark,
           // darkTheme: darkTheme,
            home:ShopLoginScreen(),
          );
        },
      ),
    );
  }
}
