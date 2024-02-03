import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/cubit/cubit.dart';
import 'package:fproject/layout/social_app/cubit/states.dart';
import 'package:fproject/models/social_models/social_user_model.dart';
import 'package:fproject/shared/components/constants.dart';
import 'package:fproject/shared/styles/colors.dart';
import 'package:fproject/shared/styles/icon_broken.dart';
import 'package:fproject/shared/widgets/social_app/receiver_chat_screen.dart';
import 'package:fproject/shared/widgets/social_app/sender_chat_screen.dart';

class ChatDetails extends StatelessWidget {
  SocialUserModel userModel;
  ChatDetails({super.key, required this.userModel});

  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessage(receiverId: userModel.uId!);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userModel.image!),
                  ),
                  const SizedBox(width: 10.0),
                  Text('${userModel.name}'),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConditionalBuilder(
                      condition: SocialCubit.get(context).messages.isNotEmpty,
                      builder: (context) => Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var message =
                                      SocialCubit.get(context).messages[index];
                                  if (SocialCubit.get(context).userModel!.uId ==
                                      message.senderId) {
                                    return SenderChatScreen(
                                      chatModel: message,
                                    );
                                  }
                                  return ReceiverChatScreen(
                                    chatModel: message,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                itemCount:
                                    SocialCubit.get(context).messages.length),
                          ),
                      fallback: (context) => const AutoSizeText(
                            "there is no message to appear,send message..",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                  if (SocialCubit.get(context).messages.isEmpty)
                     const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here....'),
                            ),
                          ),
                        ),
                        MaterialButton(
                          minWidth: 10,
                          onPressed: () {
                            SocialCubit.get(context).sendMessage(
                                receiverId: userModel.uId,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text);
                            messageController.clear();
                          },
                          child: const Icon(
                            IconBroken.Send,
                            color: Colors.blue,
                          ),
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
    });
  }
}
