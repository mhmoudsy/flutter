import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fproject/layout/shop_app/cubit/cubit.dart';
import 'package:fproject/layout/shop_app/cubit/states.dart';
import 'package:fproject/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var userNameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var cubit = ShopCubit.get(context);
    userNameController.text = cubit.userData!.data!.name!;
    emailController.text = cubit.userData!.data!.email!;
    phoneController.text = cubit.userData!.data!.phone!;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: cubit.userData != null,
            builder: (context) => Scaffold(
                  appBar: AppBar(),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: cubit.imageFile != null
                                      ? NetworkImage(
                                          cubit.userData!.data!.image!)
                                      : null,
                                ),
                                Container(
                                    child: IconButton(
                                  onPressed: () {
                                    cubit.pickImage();

                                  },
                                  icon: Icon(Icons.camera_alt_outlined),
                                  color: Colors.white,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultTextField(
                              Controller: userNameController,
                              LableText: 'User Name',
                              prefix: Icons.account_circle,
                              Type: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Valid Name';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 15.0),
                            defaultTextField(
                              Controller: emailController,
                              LableText: 'Email Address',
                              prefix: Icons.email,
                              Type: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Valid Email';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 15.0),
                            defaultTextField(
                              Controller: phoneController,
                              LableText: 'Phone',
                              prefix: Icons.phone,
                              Type: TextInputType.phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Enter Valid Phone';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.updateUserData(
                                      name: userNameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      image: FileImage(File(cubit.imageFile!.path)).toString(),
                                    );
                                  }
                                },
                                text: 'UPDATA'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
}
