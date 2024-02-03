import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/cubit/cubit.dart';
import 'package:fproject/shared/cubit/states.dart';



class ArchivedTask extends StatelessWidget {
  const ArchivedTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener: (context,state){},
      builder: (context,state){
        var task=AppCubit.get(context).archtasks;
        return tasksBuilder(task: task,);
      },
    );
  }
}
