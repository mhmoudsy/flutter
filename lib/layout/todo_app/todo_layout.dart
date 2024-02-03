import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/shared/cubit/cubit.dart';
import 'package:fproject/shared/cubit/states.dart';
import 'package:intl/intl.dart';
import '../../shared/components/components.dart';
class HomeLayout extends StatelessWidget {


  // void initState() {
  //   super.initState();
  //   createDataBase();
  // }

  var Scaffoldkey=GlobalKey<ScaffoldState>();
  var FormKey=GlobalKey<FormState>();

  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dataController=TextEditingController();

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit,Appstates>(
        listener: (context,state){
          if(state is AppInsertDataBase){
            Navigator.pop(context);
          }
        },
        builder: (context,state){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            key:Scaffoldkey ,
            appBar: AppBar(
              title:Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),

            body:ConditionalBuilder(
              condition: state is! AppGetDataBaseLoading,
              builder: (context)=>cubit.Screens[cubit.currentIndex],
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {

                if(cubit.isBottomSheetShown){
                  if(FormKey.currentState!.validate())
                  {
                    cubit.insertDataBase(title: titleController.text, time: timeController.text, data: dataController.text);
                    // insertDataBase(
                    //   title:titleController.text,
                    //   time: timeController.text,
                    //   data: dataController.text,
                    // )!.then((value) {
                    //   getDataFromDataBase(database).then((value) {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   isBottomSheetShown=false;
                    //     //   Fbi=Icons.edit;
                    //     //   tasks=value;
                    //     //   print(tasks);
                    //     // });
                    //
                    //
                    //
                    //   });
                    //
                    // });

                  }
                }else
                {
                  Scaffoldkey.currentState?.showBottomSheet(
                    elevation: 15.0,
                        (context) => Container(

                      padding: EdgeInsets.all(20.0),
                      color: Colors.grey[200],
                      child: Form(
                        key: FormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextField(
                                Controller: titleController,
                                LableText: 'Title',
                                prefix: Icons.title,
                                Type: TextInputType.text,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'Title Must Be Not Empty';
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultTextField(
                                ontap: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text=value!.format(context).toString();
                                  });
                                },
                                Controller: timeController,
                                LableText: 'Time',
                                prefix: Icons.watch_later_outlined,
                                Type: TextInputType.text,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'Time Must Be Not Empty';
                                  }
                                  return null;
                                }

                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            defaultTextField(
                                ontap: (){
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-05-03'),
                                  ).then((value)  {
                                    dataController.text=DateFormat.yMMMd().format(value!);
                                  });
                                },
                                Controller: dataController,
                                LableText: 'Data',
                                prefix: Icons.calendar_month_outlined,
                                Type: TextInputType.text,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'Data Must Be Not Empty';
                                  }
                                  return null;
                                }

                            ),


                          ],
                        ),
                      ),
                    ),
                  ).closed.then((value) {
                   cubit.ChangeBottomSheetState(
                       IsShown: false,
                       icon: Icons.edit,
                   );
                  });
                  cubit.ChangeBottomSheetState(
                    IsShown: true,
                    icon: Icons.add,
                  );
                }

              },
              child: Icon(
                cubit.Fbi,
              ),
            ),
            bottomNavigationBar:BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.change(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check,
                    ),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'Archived',
                  ),
                ]) ,
          );
        },

      ),
    );
  }



}



