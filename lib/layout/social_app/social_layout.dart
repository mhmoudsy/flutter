import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/cubit/cubit.dart';
import 'package:fproject/layout/social_app/cubit/states.dart';
import 'package:fproject/modules/social_app/new_post/new_post_screen.dart';
import 'package:fproject/modules/social_app/social_login/social_login_screen.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/styles/icon_broken.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/local/chace_helper.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState){
          navigateTo(context,  NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
              IconButton(onPressed: () {
                print(uId);

              }, icon: Icon(IconBroken.Notification)),
            ],
            title: Text(cubit.title[cubit.currentIndex]),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(IconBroken.Home),
              ),
              BottomNavigationBarItem(
                label: "Chats",
                icon: Icon(IconBroken.Chat),
              ),
              BottomNavigationBarItem(
                label: "Post",
                icon: Icon(IconBroken.Paper_Upload),
              ),
              BottomNavigationBarItem(
                label: "Users",
                icon: Icon(IconBroken.User),
              ),
              BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(IconBroken.Setting),
              ),
            ],
          ),
        );
      },
    );
  }
}
