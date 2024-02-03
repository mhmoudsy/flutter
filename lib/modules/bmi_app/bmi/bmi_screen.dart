import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fproject/modules/bmi_app/bmi_result/result_bmi_screen.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  bool IsMale=true;
  double height=120.0;
  double weight=40;
  int age=10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'BMI Calculator',
          ),
        ),
      ),
      body:Container(
        color: Colors.grey[600],
        child: Column(

          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                        IsMale=true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: IsMale ? Colors.blue :Colors.grey[400],
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                  image: AssetImage('assets/images/male.png'),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Male',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                          IsMale=false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color:IsMale? Colors.grey[400]:Colors.blue,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image(
                                  image: AssetImage('assets/images/female.png'),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Female',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HEIGHT',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${height.round()}',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w900
                            ),
                          ),
                          Text(
                            'cm',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                          value: height,
                          max: 200.0,
                          min: 80.0,
                          onChanged: (value){
                            setState(() {
                              height=value;
                            });
                            print(height);
                          },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'WEIGHT',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${weight.round()}',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: '-weight',
                                    onPressed: (){
                                      setState(() {
                                        weight--;
                                      });
                                    },
                                  mini:true ,
                                  child: Icon(
                                    Icons.remove,
                                  ),
                                ),
                                FloatingActionButton(
                                  mini: true,
                                  heroTag: '+weight',
                                  onPressed: (){
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Age',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$age',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                FloatingActionButton(
                                  heroTag: '-age',
                                  onPressed: (){
                                    setState(() {
                                      age--;
                                    });
                                  },
                                  mini:true ,
                                  child: Icon(
                                    Icons.remove,
                                  ),
                                ),
                                FloatingActionButton(
                                  heroTag: '+age',
                                  mini: true,
                                  onPressed: (){
                                    setState(() {
                                      age++;
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: MaterialButton(
                  onPressed: (){
                double result =weight / pow(height / 100, 2);
                print(result.round());
                Navigator.push(
                  context,
                    MaterialPageRoute(
                        builder: (context)=>ResultBMIScreen(
                         age: age,
                          result: result.round(),
                          IsMale: IsMale,
                        ),

                    ),
                );
                  },
                child: Text(
                  'BMI Calculator',
                  style: TextStyle(
                    color: Colors.white,

                  ),
                ),

              ),
            )

          ],
        ),
      ) ,
    );
  }
}
