import 'package:flutter/material.dart';
import 'package:fproject/shared/components/components.dart';

class loginScreen extends StatefulWidget {
  loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultTextField(
                    onChang: (value) {
                      print(value);
                    },
                    onSubmit: (value) {
                      print(value);
                    },
                    LableText: "Email Address",
                    Controller: emailController,
                    prefix: Icons.email,
                    Type: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Email Address Must Be Not Empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultTextField(
                    onChang: (value) {
                      print(value);
                    },
                    onSubmit: (value) {
                      print(value);
                    },
                    LableText: "Password",
                    Controller: passwordController,
                    prefix: Icons.lock,
                    Type: TextInputType.visiblePassword,
                    isPassword: isPassword,
                    suffix: isPassword? Icons.visibility : Icons.visibility_off,
                    suffixPressed: () {
                      setState(() {
                        isPassword=!isPassword;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Email Address Must Be Not Empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultButton(
                      radius: 10.0,
                      isUpperCase: true,
                      function: () {
                        if (formkey.currentState!.validate()) {
                          print(emailController.text);
                          print(passwordController.text);
                        }
                      },
                      text: 'login'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Register'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
