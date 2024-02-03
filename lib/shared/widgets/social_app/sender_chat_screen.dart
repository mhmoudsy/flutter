import 'package:flutter/material.dart';
import 'package:fproject/models/social_models/chat_model.dart';
import 'package:fproject/shared/styles/colors.dart';

class SenderChatScreen extends StatelessWidget {
  ChatModel chatModel;
   SenderChatScreen({super.key,required this.chatModel});


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10
          ),
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.2),
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )
          ),
          child: Text('${chatModel.text}')),
    );
  }
}
