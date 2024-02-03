import 'package:flutter/material.dart';

class ResultBMIScreen extends StatelessWidget {
   bool? IsMale;
   int? result;
   final int ? age;

   ResultBMIScreen({Key? key,
    required this.IsMale,
    required this.result,
    required this.age,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Result BMI',
          ),
        ),
        leading: IconButton(
            onPressed: (){
            Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
            ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender:${IsMale! ? 'Male' : 'Female'}',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'Result :$result',
                style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold
            ),
            ),
            Text(
              'Age:$age',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold
              ),
            ),


          ],
        ),
      ),
    );
  }
}
