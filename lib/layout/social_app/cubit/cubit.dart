import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/cubit/states.dart';
import 'package:fproject/models/social_models/chat_model.dart';
import 'package:fproject/models/social_models/post_model.dart';
import 'package:fproject/models/social_models/social_user_model.dart';
import 'package:fproject/modules/social_app/chats/chats_screen.dart';
import 'package:fproject/modules/social_app/feeds/feeds_screen.dart';
import 'package:fproject/modules/social_app/new_post/new_post_screen.dart';
import 'package:fproject/modules/social_app/settings/settings_screen.dart';
import 'package:fproject/modules/social_app/users/users_screen.dart';
import 'package:fproject/shared/components/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../shared/network/local/chace_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;
  PostModel? postModel;
  bool isUpdatedProfile = false;
  final postRef = FirebaseFirestore.instance.collection('post');

  bool isUpdatedCover = false;
  bool isLiked = false;

  Future<void> getUserData() async {
    uId = CachHelper.getData(key: 'uId');

    emit(SocialGetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      // print(value.data());
      print(SocialUserModel.fromJson(value.data()!));

      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialGetUserErrorState(e.toString()));
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> title = [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];
  int currentIndex = 0;

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }

    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImageSuccessState());
      isUpdatedProfile = true;
    } else {
      print('No image selected.');
      emit(SocialProfileImageErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialProfileImageSuccessState());
      isUpdatedCover = true;
    } else {
      print('No image selected.');
      emit(SocialProfileImageErrorState());
    }
  }

  File? postImage;

  Future getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostPickImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostPickImageErrorState());
    }
  }

  Future removePostImage() async {
    postImage = null;
    emit(SocialPostRemoveImageSuccessState());
  }

  String profileImageUrl = '';

  void uploadProfileImage({
    required String username,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        updateUser(phone: phone, bio: bio, username: username, image: value);
        emit(SocialUploadProfileImageSuccessState());
        isUpdatedProfile = false;
        emit(SocialHideBtUpdateProfileState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage({
    required String username,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateCoverLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        coverImageUrl = value;
        updateUser(phone: phone, bio: bio, username: username, cover: value);
        emit(SocialUploadCoverImageSuccessState());
        isUpdatedCover = false;
        emit(SocialHideBtUpdateCoverState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser(
      {required String username,
      required String phone,
      required String bio,
      String? image,
      String? cover}) {
    SocialUserModel model = SocialUserModel(
      name: username,
      email: userModel!.email,
      phone: phone,
      bio: bio,
      uId: userModel!.uId,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();

      emit(SocialUpdateUserSuccessState());

      //
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }

  String postImageUrl = '';

  void uploadPostImage({
    required String dataTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        postImageUrl = value;
        createPost(text: text, dataTime: dataTime, postImage: value);

        emit(SocialCreatePostSuccessState());
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    String? dataTime,
    String? postImage,
    String? text,
    String? profile,
    String? uId,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dataTime: dataTime,
      postImage: postImage ?? '',
      text: text,
    );
    FirebaseFirestore.instance
        .collection('post')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
      //
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }
  //
  // List<PostModel> posts = [];
  // List<int> likes = [];
  //
  //
  // void getPosts() {
  //   postRef.get().
  //   then((value) {
  //     value.docs.forEach((element) {
  //       element.reference.collection('likes').get().then((value) {
  //         postId.add(element.id);
  //         posts.add(PostModel.fromDocument(element));
  //         likes.add(value.docs.length);
  //         print(posts);
  //       }).catchError((error) {
  //
  //       });
  //     });
  //     emit(SocialGetPostSuccessState());
  //   }).catchError((error) {
  //     emit(SocialGetPostErrorState(error.toString()));
  //     print(error.toString());
  //   });
  // }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  Future<void> getPosts() async {
    await FirebaseFirestore.instance.collection('post').get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          posts.add(PostModel.fromJson(element.data()));
          likes.add(value.docs.length);
          postId.add(element.id);
        }).catchError((error) {});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialGetPostErrorState(e.toString()));
    });
  }

  void likePost({
    String? postId,
  }) {
    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'isLiked': true,
    }).then((value) {
      emit(SocialPostLikeSuccessState());
    }).catchError((error) {
      emit(SocialPostLikeErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() async {
    if (users.isEmpty) {
      await FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    String? receiverId,
    String? text,
    String? dateTime,
  }) {
    ChatModel model = ChatModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(
          model.toMap(),
        )
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(
          model.toMap(),
        )
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }
List<ChatModel> messages=[];
  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
        messages=[];
          event.docs.forEach((element) {
            messages.add(ChatModel.fromJson(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });
  }
}
