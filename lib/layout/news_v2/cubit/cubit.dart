import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/news_v2/cubit/states.dart';
import 'package:fproject/modules/news_app/businessv2/bussinessv2_screen.dart';
import 'package:fproject/modules/news_app/sciencev2/sciencev2_screen.dart';
import 'package:fproject/modules/news_app/sportsv2/sportsv2_screen.dart';

import '../../../shared/network/remote/dio_helperv2.dart';

class NewsCubit extends Cubit<NewsStateV2>{
  NewsCubit():super(NewInitialStatesV2());
  static NewsCubit? get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sport',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),

  ];
  List<Widget>Screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
   // SettingsScreen(),
  ];
  OnBottomNavigationChange (index){
    if (index==1)
      getSport();
    else if(index==2)
      getScience();
    currentIndex=index;
    emit(BottomNavigationChange());
  }
//Business
List<dynamic>Business=[];
  void getBusiness(){

    emit(BussinessLoadingState());
    DioHelperV2.getData(
      url: 'v2/top-headlines',
      query:{
        'country':'eg',
        'category':'business',
        'apiKey':'3783d079ed4a4f33aa288ce6e123000e'
      } ,
    )?.then((value) {
      Business=value.data['articles'];
      print(Business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print('error${error.toString()}');
      emit(NewsGetBusinessErrorState(error));
    });
  }
//sport

  List<dynamic>Sport=[];
  void getSport(){
    if(Sport.length==0){
      emit(SportLoadingState());
      DioHelperV2.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'sport',
          'apiKey':'3783d079ed4a4f33aa288ce6e123000e'
        } ,
      )?.then((value) {
        Sport=value.data['articles'];
        print(Sport[0]['title']);
        emit(NewsGetSportSuccessState());
      }).catchError((error){
        print('error${error.toString()}');
        emit(NewsGetSportErrorState(error));
      });
    }else{

      emit(NewsGetSportSuccessState());

    }

  }
//Science
  List<dynamic>Science=[];
  void getScience(){
    if (Science.length==0){
      emit(ScienceLoadingState());
      DioHelperV2.getData(
        url: 'v2/top-headlines',
        query:{
          'country':'eg',
          'category':'science',
          'apiKey':'3783d079ed4a4f33aa288ce6e123000e'
        } ,
      )?.then((value) {
        Science=value.data['articles'];
        print(Science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print('error${error.toString()}');
        emit(NewsGetScienceErrorState(error));
      });
    }else{
      emit(NewsGetScienceSuccessState());

    }

  }
  List<dynamic>Search=[];
  void getSearch(String value){

      emit(SearchLoadingState());
      DioHelperV2.getData(
        url: 'v2/everything',
        query:{
          'q':'$value',
          'apiKey':'3783d079ed4a4f33aa288ce6e123000e'
        } ,
      )?.then((value) {
        Search=value.data['articles'];
        print(Search[0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print('error${error.toString()}');
        emit(NewsGetSearchErrorState(error));
      });


  }
  void searchClear(){
    Search=[];
    emit(NewsClearSearchState());
  }
}