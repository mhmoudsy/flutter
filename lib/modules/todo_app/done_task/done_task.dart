import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/components/constants.dart';
import 'package:fproject/shared/cubit/cubit.dart';
import 'package:fproject/shared/cubit/states.dart';


class DoneTask extends StatelessWidget {
  const DoneTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,Appstates>(
      listener: (context,state){},
      builder: (context,state){
        var task=AppCubit.get(context).donetasks;
        return  tasksBuilder(task: task,);
      },
    );
  }
}
