import 'package:flutter/material.dart';

class homescreen extends StatelessWidget {
   homescreen({Key? key}) : super(key: key);
  var emailControl=TextEditingController();
  var PasswordControl=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading:Icon(
            Icons.menu,
        ),
        title: Center(
          child: Text(
              'TODO APP',
            style: TextStyle(
              shadows:[
                Shadow(
                  blurRadius: 40.0,
                )
              ] ,
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                print("Have A Nice Day ..");
              },
              icon:Icon(
              Icons.account_circle_rounded,
                size: 30.0,
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 15.0
                ),
                child: Text(

                  'Login',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black45,
                    shadows: [
                      Shadow(
                        blurRadius: 30.0,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: emailControl,
                onFieldSubmitted: (_){
                  print(_);
                },
                onChanged: (_){
                  print(_);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',

                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                  ),

              ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: PasswordControl,
                onFieldSubmitted: (_){
                  print(_);
                },
                onChanged: (_){
                  print(_);
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText:true ,
                obscuringCharacter: '*',
                decoration:InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon:Icon(
                      Icons.remove_red_eye
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )

                ) ,
              ),
              SizedBox(
                height: 20.0,
              ),

              Container(
                color: Colors.blue,
                width: double.infinity,

                child: MaterialButton(onPressed: (){
                  print(emailControl.text);
                  print(PasswordControl.text);
                },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
              ),

              Row(
                children: [
                  Text(
                    'Don\'t Have An Account',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  TextButton(
                    onPressed: (){

                  },
                    child: Text(
                    'Register',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                  ),)
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}