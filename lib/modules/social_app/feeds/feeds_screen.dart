import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/cubit/cubit.dart';
import 'package:fproject/layout/social_app/cubit/states.dart';
import 'package:fproject/shared/components/constants.dart';
import 'package:fproject/shared/widgets/social_app/build_post_item.dart';

//
// if( SocialCubit.get(context).posts.isEmpty || SocialCubit.get(context).userModel == null )
// {
// SocialCubit.get(context)..getUserData()..getPosts();
// }


class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return   ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty ,
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
          builder: (context){
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(6.0),
                    elevation: 12.0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image(
                          image: NetworkImage(socialHomeImage),
                          height: 200.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics:const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=> PostItem(model:SocialCubit.get(context).posts[index],
                          userMode: SocialCubit.get(context).userModel!,index: index),
                      separatorBuilder: (context,index)=>const SizedBox(height: 8.0,),
                      itemCount: SocialCubit.get(context).posts.length)
                ],
              ),
            );
          },
        );
      },
    );






  }
}
