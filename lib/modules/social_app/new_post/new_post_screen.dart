
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/cubit/cubit.dart';
import 'package:fproject/layout/social_app/cubit/states.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/styles/icon_broken.dart';
import 'package:fproject/shared/widgets/social_app/default_appbar.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';

class NewPostScreen extends StatelessWidget {
  var postController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: DefualtAppBar(
            title: "New Post",
            action: [
              defaultTextButton(function: (){
                {
                  if(SocialCubit.get(context).postImage==null) {
                    if(postController.text==''){
                      showMyDialog(
                          title: 'يمخراااييي',
                          body: 'أكتب بوست ينجم وحيات النبي',
                          context: context,
                          buttonText: 'اشطا'
                      );
                    }else {
                      SocialCubit.get(context).createPost(
                        dataTime: DateTime.now().toString(),
                        text: postController.text,
                      );
                    }
                  }else{
                    SocialCubit.get(context).uploadPostImage(
                      dataTime: DateTime.now().toString(),
                      text: postController.text,);
                  }
                }
              }, text: 'Post',size: 18)
            ],
          ),
      body:BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          return Padding(

            padding:  EdgeInsets.all(20.0),
            child: CustomScrollView(
             slivers: [
               SliverFillRemaining(
                 hasScrollBody: false,

                 child: Column(
                   children: [
                     if(state is SocialCreatePostLoadingState)
                       const LinearProgressIndicator(),
                     if(state is SocialCreatePostLoadingState)
                       const SizedBox(height: 10.0,),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         CircleAvatar(
                           backgroundImage:
                           NetworkImage(socialCircularAvatarImage),
                         ),
                         const SizedBox(
                           width: 10.0,
                         ),
                         const Expanded(
                           child: Row(
                             children: [
                               Text(
                                 'Mahmoud Sayed',
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
                         ),
                       ],
                     ),
                     TextFormField(
                       minLines: 1,
                       maxLines: null,
                       controller: postController,
                       keyboardType: TextInputType.multiline,
                       decoration: const InputDecoration(
                         hintText: 'what is on your mind...',
                         border: InputBorder.none,
                       ),
                     ),
                     if(SocialCubit.get(context).postImage!=null)
                       Stack(
                         alignment: Alignment.topRight,
                         children: [
                           SingleChildScrollView(
                             child: Container(
                               width: double.infinity,
                               height: 140.0,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(4.0),
                                 image: DecorationImage(
                                     image: FileImage(SocialCubit.get(context).postImage!),
                                     fit: BoxFit.cover
                                 ),),
                             ),
                           ),
                           IconButton(
                               onPressed: () {
                                 SocialCubit.get(context).removePostImage();
                               },
                               icon: const CircleAvatar(
                                   radius: 20.0,
                                   child: Icon(
                                     Icons.close,
                                     size: 20.0,
                                   ))),

                         ],
                       ),

                     Expanded(
                       child: Align(
                         alignment: Alignment.bottomCenter,
                         child: Row(
                           children: [
                             Expanded(
                               child: TextButton(onPressed: ()  {
                                 SocialCubit.get(context).getPostImage();
                               },
                                   child: const Row(
                                     mainAxisAlignment: MainAxisAlignment.center,

                                     children: [
                                       Icon(IconBroken.Image),
                                       SizedBox(width: 5,),
                                       Text('add photo')
                                     ],
                                   )
                               ),
                             ),
                             Expanded(
                               child: TextButton(onPressed: (){},
                                   child: const Text('# tags')
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),


                   ],
                 ),
               ),
             ],
            ),
          );
        },

      ),
    );
  }
}
