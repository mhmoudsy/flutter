

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/cubit/cubit.dart';
import 'package:fproject/layout/social_app/cubit/states.dart';
import 'package:fproject/models/social_models/post_model.dart';
import 'package:fproject/shared/styles/colors.dart';
import 'package:fproject/shared/styles/icon_broken.dart';

import '../../../models/social_models/social_user_model.dart';
import '../../components/constants.dart';



class PostItem extends StatelessWidget {
  PostModel model;
  SocialUserModel userMode;
   int index;


  PostItem(
      {super.key,
      required this.model,
      required this.userMode,
       required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=SocialCubit.get(context);

        return Card(
          elevation: 6.0,
          margin: const EdgeInsets.all(6.0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${model.name}',
                                style: TextStyle(
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(
                                width: 3.0,
                              ),
                              Icon(Icons.check_circle,
                                  size: 15.0, color: defaultColor),
                            ],
                          ),
                          Text(
                            '${model.dataTime}',
                            style:
                            Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz,
                          size: 18.0,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
                Text(
                  '${model.text}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(color: Colors.black),
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5.0),
                        child: Container(
                          height: 20.0,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              '',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: defaultColor),
                            ),
                            padding: EdgeInsets.zero,
                            minWidth: 1.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5.0),
                        child: Container(
                          height: 20.0,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              '',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: defaultColor),
                            ),
                            padding: EdgeInsets.zero,
                            minWidth: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (model.postImage != '')
                  Container(
                    width: double.infinity,
                    height: 140.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                            image: NetworkImage('${model.postImage}'),
                            fit: BoxFit.cover)),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        highlightColor: Colors.white,
                        splashColor: Colors.white,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              Container(
                                color: Colors.red, // Color
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // SocialCubit.get(context).createComment(
                          //     postId: SocialCubit.get(context).postId[index],
                          //     text: 'Ahmed',
                          //     dataTime: '10');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              size: 16.0,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              '0 comment',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18.0,
                              backgroundImage: NetworkImage(userMode.image!),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'write comment....',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                        onTap: () {
                          // navigateTo(context, CommentScreenItem());
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cubit.likePost(postId: SocialCubit.get(context).postId[index]);
                      },
                      child: Row(
                        children: [

                          Icon(
                            //
                            // (!snapshot.data!.exists)?
                            //
                            // Icons.favorite:
                            IconBroken.Heart,
                            size: 16,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),

                    /////,
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
