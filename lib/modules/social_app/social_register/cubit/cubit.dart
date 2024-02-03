import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/models/social_models/social_user_model.dart';
import 'package:fproject/modules/social_app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        username: username,
        email: email,
        uId: value.user!.uid,
        phone: phone,
      );
      emit(SocialRegisterSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialRegisterErrorState(e.toString()));
    });
  }

  void userCreate({
    required String username,
    required String email,
    required String uId,
    required String phone,
  }) {
    SocialUserModel model = SocialUserModel(
      uId: uId,
      name: username,
      email: email,
      phone: phone,
      bio: 'bio ....',
      image: 'https://img.freepik.com/premium-photo/marbled-greek-goddess-with-gold-headdress_52683-102859.jpg?w=360',
      cover: 'https://img.freepik.com/premium-photo/magical-alien-planet-world-with-different-buildings_670008-168.jpg?w=1060',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(SocialCreateErrorState(e.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterPasswordVisibilityState());
  }
}
