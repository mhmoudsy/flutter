import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/social_layout.dart';
import 'package:fproject/modules/social_app/social_login/cubit/cubit.dart';
import 'package:fproject/modules/social_app/social_login/cubit/states.dart';
import 'package:fproject/modules/social_app/social_register/social_register_screen.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/network/local/chace_helper.dart';

import '../../../shared/components/constants.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
         if(state is SocialLoginErrorState){
            showToast(text: state.error, state: ToastState.WARNING);
          }
         if(state is SocialLoginSuccessState){
           CachHelper.saveData(
               key: 'uId',
               value:state.uId )
               .then((value) => {

             navigateAndRemove(context, const SocialLayout()),
           });
         }
        },
        builder: (context, state) {
          var cubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to communicate with ur friends ',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextField(
                          Controller: emailController,
                          validator: (value) {
                            try {
                              if (value!.isEmpty) {
                                return 'please enter the email';
                              }
                              return null;
                            } catch (e) {
                              print('error In Email Validator');
                            }
                          },
                          Type: TextInputType.text,
                          LableText: 'Email Address',
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextField(
                            Controller: passwordController,
                            validator: (value) {
                              try {
                                if (value!.isEmpty) {
                                  return 'please enter the password';
                                }
                                return null;
                              } catch (e) {
                                print('error In Password Validator');
                              }
                            },
                            Type: TextInputType.visiblePassword,
                            LableText: 'Password',
                            prefix: Icons.lock,
                            isPassword: cubit.isPassword,
                            suffix: cubit.suffix,
                            suffixPressed: () {
                              cubit.changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                            text: 'login',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                print('${uId} lolllllllllllllllllllllllllllllllllllllllllll');
                              }
                            },
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, const SocialRegisterScreen());
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
