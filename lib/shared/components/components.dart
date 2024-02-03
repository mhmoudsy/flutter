


import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fproject/modules/news_app/web_view/web_view_screen.dart';
import 'package:fproject/shared/cubit/cubit.dart';

import '../../layout/news_v2/cubit/states.dart';
import '../../layout/social_app/cubit/cubit.dart';

Widget defaultButton({
  double width =double.infinity,
  double? height,
  Color background = Colors.blue,
  bool isUpperCase = false,
  double radius = 0.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: function,
        child: AutoSizeText(
          isUpperCase ? text.toUpperCase() : text,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextField({
  required TextEditingController Controller,
  ValueChanged? onSubmit,
  ValueChanged? onChang,
  required String LableText,
  required IconData prefix,
  required TextInputType Type,
  required FormFieldValidator validator,
  String obScureChar='*',
  bool isPassword = false,
  IconData? suffix,
  GestureTapCallback? ontap,
  VoidCallback? suffixPressed ,

}) =>
    TextFormField(
      controller: Controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChang,
      keyboardType: Type,
      obscuringCharacter: obScureChar,
      obscureText: isPassword ,
      decoration: InputDecoration(
        labelText: LableText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffix,
          ),
          onPressed: suffixPressed,
        ),

      ),
      onTap:ontap ,
      validator: validator,
    );
Widget defaultTextButton({
  required  VoidCallback function,
  required String text,
  double? size,
})=> TextButton(onPressed: function, child: Text(text,style:TextStyle(fontSize: size),));
Widget buildTaskItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  child:Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40.0,

          child: Text('${model['time']}'),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${model['title']}',

                style: TextStyle(

                    fontSize: 15.0,

                    fontWeight: FontWeight.bold,

                    fontStyle: FontStyle.italic

                ),

              ),

              Text(

                '${model['data']}',

                style: TextStyle(

                    color: Colors.grey

                ),



              ),

            ],

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updataDataBase(status: 'Done', id: model['id']);

            },

            icon: Icon(Icons.check_box,

            color: Colors.green,

            ),

        ),

        SizedBox(

          width: 5.0,

        ),

        IconButton(

          onPressed: (){

            AppCubit.get(context).updataDataBase(status: 'Archived', id: model['id']);

          },

          icon: Icon(Icons.archive,

            color: Colors.black45,

          ),

        ),

      ],

    ),



  ),
  onDismissed: (direction) {
    AppCubit.get(context).deleteDataBase(id: model['id']);
  } ,
);

Widget tasksBuilder({
  required List<Map>task,
})=>ConditionalBuilder(
  condition: task.length>0,
  builder: (context)=>ListView.separated(
      itemBuilder: (context,index)=>buildTaskItem(task[index],context),
      separatorBuilder:  (context,index)=>Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 20.0,end:20.0
        ),
        child: Container(
          width: double.infinity,
          color: Colors.grey,
          height: 1.0,
        ),
      ),
      itemCount: task.length),
  fallback: (context)=>Center(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Icon(Icons.menu,
          size: 60.0,
          color: Colors.grey,
        ),
        Text("No Tasks Yet! ,Please Add Some Tasks ♥",
          maxLines: 2,
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),),

      ],
    ),
  ),
);

Widget myDivider ()=>Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 20.0,end:20.0
  ),
  child: Container(
    width: double.infinity,
    color: Colors.grey,
    height: 1.0,
  ),
);

Widget buildArticalItem(article,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        height: 120.0,
        width: 120.0,
        decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(20.0),
            image: DecorationImage(
                image: NetworkImage('${article['urlToImage']==null ? 'https://cdn5-ss12.sharpschool.com/UserFiles/Servers/Server_1023780/Image/News.jpg':article['urlToImage']}'),
                fit:BoxFit.cover
            )
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(
                  color:Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget ArticalBuilder(list,Context)=>ConditionalBuilder(
  condition: list.length > 0 ,
  builder: (context)=>ListView.separated(
    physics:BouncingScrollPhysics(),
    itemBuilder: (BuildContext context, int index)=>buildArticalItem(list[index],Context),
    separatorBuilder: (BuildContext context, int index) =>myDivider(),
    itemCount: 14,

  ),
  fallback: (context)=>Center(child: CircularProgressIndicator()),
);


///////v2
Widget buildCategory(Artical, context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(url: Artical['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          height: 120.0,

          width: 120.0,

          decoration: BoxDecoration(

            image: DecorationImage

              (

              image: NetworkImage('${Artical['urlToImage']==null? 'https://media-cldnry.s-nbcnews.com/image/upload/newscms/2019_01/2705191/nbc-social-default.png':'${Artical['urlToImage']}'}'),

              fit: BoxFit.cover,

            ),

            borderRadius: BorderRadiusDirectional.circular(20.0),

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${Artical['title']}',

                    maxLines: 4,

                    overflow: TextOverflow.ellipsis,

                    style:Theme.of(context).textTheme.bodyText1,

                  ),

                ),

                Text(

                  '${Artical['publishedAt']}',

                  style: TextStyle(

                      color: Colors.grey,

                      fontWeight: FontWeight.w300

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

//v2
Widget ArticalCategory(list,Context,{isSearch=false})=>ConditionalBuilder(
  condition:list!.length>0 ,
  builder:(context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder:(BuildContext context,index)=>buildCategory(list[index],Context) ,
    separatorBuilder:(BuildContext context,index)=>myDivider() ,
    itemCount:list.length,) ,



  fallback:(context)=>isSearch? Container() : Center(child: CircularProgressIndicator()),
);
void navigateTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)=>widget,

  ),
);
void navigateAndRemove(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
    builder: (context)=>widget,
),
        (route) => false
);
//flutter toast
void showToast({
  required String text,
  required ToastState state,


})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState{SUCCESS , ERROR , WARNING }
Color chooseToastColor(ToastState state){
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color=Colors.green;
      break;

    case ToastState.ERROR:
      color=Colors.red;
      break;

      case ToastState.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}
//print all of the content
void printAll(String text){
  final pattern =RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

Future<void> showMyDialog({
  required BuildContext context,
  required String title,
  required String body,
  required String buttonText,

}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content:  SingleChildScrollView(
          child: AutoSizeText(body),
          ),
        actions: <Widget>[
          TextButton(
            child:  Text(buttonText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

//
// Future<int> photoDimensions({
//   required BuildContext context,
//   bool? isHeight=false,
//   bool? isWidth=false,
//   required var image,
// }) async {
//   var photoLink=image;
//   var decodedImage = await decodeImageFromList(photoLink!.readAsBytesSync());
//
//   bool choose=true;
//   int width;
//   if(choose==isHeight){
//     width=decodedImage.width;
//   }
//   return width;
//
// }