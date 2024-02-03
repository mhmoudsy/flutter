import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/social_app/social_layout.dart';
import 'package:fproject/modules/social_app/social_login/social_login_screen.dart';
import 'package:fproject/modules/social_app/social_register/cubit/cubit.dart';
import 'package:fproject/modules/social_app/social_register/cubit/states.dart';
import 'package:fproject/shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
  const SocialRegisterScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var userNameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) =>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is SocialCreateSuccessState){
            showToast(text: "Done Create Account", state: ToastState.SUCCESS);
            navigateTo(context, SocialLoginScreen());
          }
          else if(state is SocialCreateErrorState){
            showToast(text: state.error, state: ToastState.ERROR);
          } else if(state is SocialRegisterErrorState){
            showToast(text: state.error, state: ToastState.ERROR);
          }
        },
        builder: (context,state){
          var cubit=SocialRegisterCubit.get(context);

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
                          'REGISTER',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to communicate with ur friends',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextField(
                          Controller: userNameController,
                          validator: (value) {
                            try {
                              if (value!.isEmpty) {
                                return 'please enter the username';
                              }
                              return null;
                            } catch (e) {
                              print('error In username Validator');
                            }
                          },
                          Type: TextInputType.text,
                          LableText: 'UserName',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15.0,
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
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  username: userNameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            }),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextField(
                          Controller: phoneController,
                          validator: (value) {
                            try {
                              if (value!.isEmpty) {
                                return 'please enter the phone';
                              }
                              return null;
                            } catch (e) {
                              print('error In phone Validator');
                            }
                          },
                          Type: TextInputType.phone,
                          LableText: 'Phone',
                          prefix: Icons.phone,
                        ),

                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                            text: 'Register',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  username: userNameController.text,
                                  phone: phoneController.text,
                                );
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
