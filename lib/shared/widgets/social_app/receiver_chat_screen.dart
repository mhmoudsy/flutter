import 'package:flutter/material.dart';
import 'package:fproject/models/social_models/chat_model.dart';

class ReceiverChatScreen extends StatelessWidget {
  ChatModel chatModel;
   ReceiverChatScreen({super.key,required this.chatModel});


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )
          ),
          child:  Text('${chatModel.text}')),
    );
  }
}
