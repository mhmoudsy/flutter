import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/cubit/cubit.dart';
import 'package:fproject/layout/social_app/cubit/states.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/styles/icon_broken.dart';
import 'package:fproject/shared/widgets/social_app/default_appbar.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel!.bio!;
        phoneController.text = userModel!.phone!;
        return Scaffold(
          appBar: DefualtAppBar(
            title: "EditProfile",
            action: [
              defaultTextButton(
                  function: () {
                    SocialCubit.get(context).updateUser(
                        username: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text);
                  },
                  text: "UPDATE",
                  size: 18),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 140.0,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage('${userModel!.cover}')
                                            : FileImage(coverImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 20.0,
                                      ))),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel!.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 20.0,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                    Row(
                    children: [
                      if(SocialCubit.get(context).isUpdatedProfile)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                              function: () {
                                SocialCubit.get(context).uploadProfileImage(username:nameController.text ,
                                    phone: phoneController.text,
                                    bio: bioController.text
                                );
                              },
                              text: 'Upload Profile Image',
                              isUpperCase: true,
                              height: 40,
                              radius: 5
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if(state is  SocialUpdateImageLoadingState)
                              const LinearProgressIndicator()
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if(SocialCubit.get(context).isUpdatedCover)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                              function: () {
                                SocialCubit.get(context).uploadCoverImage(username:nameController.text ,
                                    phone: phoneController.text,
                                    bio: bioController.text
                                );
                              },
                              text: 'Upload Cover Image',
                              isUpperCase: true,
                                height: 40,
                                radius: 5
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            if(state is  SocialUpdateCoverLoadingState)
                            const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if(SocialCubit.get(context).profileImage !=null ||SocialCubit.get(context).coverImage !=null)
                  const SizedBox(
                    height: 10,
                  ),

                  defaultTextField(
                      Controller: nameController,
                      LableText: 'Name',
                      prefix: IconBroken.User,
                      Type: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'name must be not empty';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextField(
                      Controller: bioController,
                      LableText: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      Type: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'bio must be not empty';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextField(
                      Controller: phoneController,
                      LableText: 'Phone',
                      prefix: IconBroken.Call,
                      Type: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'phone must be not empty';
                        } else {
                          return null;
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
