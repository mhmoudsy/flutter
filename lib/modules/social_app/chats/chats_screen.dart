import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/cubit/cubit.dart';
import 'package:fproject/layout/social_app/cubit/states.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/widgets/social_app/chats_screen_item.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          return ConditionalBuilder(
            condition: SocialCubit.get(context).users.isNotEmpty,
            builder: (context)=>ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>ChatsScreenItem(userModel: SocialCubit.get(context).users[index],),
                separatorBuilder: (context,index)=>myDivider(),
                itemCount: SocialCubit.get(context).users.length),
            fallback:(context)=> Center(child: CircularProgressIndicator()),

          );
        },
    );
  }
}
