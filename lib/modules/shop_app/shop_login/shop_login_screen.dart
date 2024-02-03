import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/shop_app/shop_layout.dart';
import 'package:fproject/modules/shop_app/shop_login/cubit/cubit.dart';
import 'package:fproject/modules/shop_app/shop_login/cubit/states.dart';
import 'package:fproject/modules/shop_app/shop_register/shop_register_screen.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/components/constants.dart';
import 'package:fproject/shared/network/local/chace_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              CachHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) => {
                    token=state.loginModel.data?.token,
                        navigateAndRemove(context, ShopLayout()),
                      });
              print(state.loginModel.data?.token);
            } else {
              showToast(
                text: state.loginModel.message!,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
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
                          'Login now to browse our hot offers',
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
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            text: 'login',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, const ShopRegisterScreen());
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
