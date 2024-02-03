import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/cubit/cubit.dart';
import 'package:fproject/layout/social_app/cubit/states.dart';
import 'package:fproject/models/social_models/social_user_model.dart';
import 'package:fproject/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/components/constants.dart';

class ChatsScreenItem extends StatelessWidget {
  SocialUserModel userModel;
   ChatsScreenItem({super.key,required this.userModel});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=SocialCubit.get(context);
          return InkWell(
            onTap: (){
              navigateTo(context, ChatDetails(userModel: userModel,));
            },
            child: Padding(
              padding:  EdgeInsets.all(20.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(userModel.image!),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                   Expanded(
                    child: Row(
                      children: [
                        AutoSizeText(
                          '${userModel.name}',
                          style: TextStyle(
                              height: 1.3,
                              fontSize: 18
                          ),
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
    );
  }
}
