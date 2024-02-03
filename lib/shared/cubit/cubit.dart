import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/modules/todo_app/archived_task/Archived_task.dart';
import 'package:fproject/modules/todo_app/done_task/done_task.dart';
import 'package:fproject/modules/todo_app/new_task/new_task.dart';

import 'package:fproject/shared/cubit/states.dart';
import 'package:fproject/shared/network/local/chace_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<Appstates> {
  AppCubit() :super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget>Screens =
  [
    NewTask(),
    DoneTask(),
    ArchivedTask(),
  ];
  List<String>titles =
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks'
  ];

  void change(int index) {
    currentIndex = index;
    emit(AppBottomNavigationBarChange());
  }

  bool isBottomSheetShown = false;

  IconData Fbi = Icons.edit;

  void ChangeBottomSheetState({
    required bool IsShown, required IconData icon}) {
    Fbi = icon;
    isBottomSheetShown = IsShown;
    emit(AppBottomSheetStateChange());
  }

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archtasks = [];
  Database? database;

  void createDataBase() {
    //1.id integer
    //2.title String
    //3.data String
    //4.time String
    // status String
    openDatabase
      (
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          print('Db Created');
          database.execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,data TEXT ,time TEXT,status TEXT)')
              .then((value) {
            print("table Created");
          }).catchError((error) {
            print("Error When Creating Table ${error.toString()}");
          });
        },
        onOpen: (database) {
          getDataFromDataBase(database);
          print('Db Opened');
        }

    ).then((value) {
      database = value;
      emit(AppCreateDataBase());
    });
  }

  insertDataBase({
    required String title,
    required String time,
    required String data,
  }) async {
    await database!.transaction((txn) =>
        txn.rawInsert(
            'INSERT INTO tasks (title,data,time,status) VALUES ("${title}","${data}","${time}","new")')
            .then((value) {
          print('${value} Done Successfully');
          emit(AppInsertDataBase());

          getDataFromDataBase(database);
        }).catchError((error) {
          print("Error When Creating Table ${error.toString()}");
        })
    );
    return null;
  }

  void getDataFromDataBase(database) {
    newtasks = [];
    donetasks = [];
    archtasks = [];
    emit(AppGetDataBaseLoading());
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newtasks.add(element);
        else if (element['status'] == 'Done')
          donetasks.add(element);
        else
          archtasks.add(element);
      });
      emit(AppGetDataBase());
    });
  }


  void updataDataBase({
    required String status,
    required int id
  }) async
  {
    database?.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(AppUpDataDataBase());
    });
  }


  void deleteDataBase({
    required int id
  }) async
  {
    database?.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
        .then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDataBase());
    });
  }


  //
  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());

    }
    else {
      isDark = !isDark;
      CachHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());

      });
    }
  }
}