import 'package:flutter/material.dart';
import 'package:fproject/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/network/local/chace_helper.dart';
import 'package:fproject/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoadingModel {
  final String image;
  final String title;
  final String body;

  onBoadingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardingController = PageController();

  bool isLast=false;

  List<onBoadingModel> board = [
    onBoadingModel
      (
      image: 'assets/images/onBoarding1.jpeg',
      title: 'OnBoarding Title 1',
      body: 'OnBoarding Body 1',
    ),
    onBoadingModel
      (
      image: 'assets/images/onBoarding1.jpeg',
      title: 'OnBoarding Title 2',
      body: 'OnBoarding Body 2',
    ),
    onBoadingModel
      (
      image: 'assets/images/onBoarding1.jpeg',
      title: 'OnBoarding Title 3',
      body: 'OnBoarding Body 3',
    ),

  ];
  void submit(){
    CachHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value!){
        navigateAndRemove(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
         defaultTextButton(
             function: submit,
             text: 'SKIP',
         )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: onBoardingController,
                onPageChanged: (int index){
                  if(index==board.length-1) {
                    setState((){
                      isLast=true;
                    });

                  } else {
                   setState(() {
                     isLast=false;
                    });
                  }

                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildOnBoardingItem(board[index]),
                itemCount: board.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: onBoardingController,
                    count: board.length,
                    effect:JumpingDotEffect(
                      dotHeight: 16,
                      dotWidth: 16,
                      jumpScale: .7,
                      verticalOffset: 15,
                      dotColor:Colors.grey,
                      activeDotColor: defaultColor,

                    )

                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      submit();
                    }
                    onBoardingController.nextPage(
                        duration: Duration(
                            milliseconds: 750
                        ),
                        curve:Curves.linearToEaseOut );
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(onBoadingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child:
                  Image(image: AssetImage('${model.image}'),),),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
          ),
        ],
      );
}
