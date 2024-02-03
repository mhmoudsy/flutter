//https://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=3783d079ed4a4f33aa288ce6e123000e
//base :https://newsapi.org/
//method :v2/top-headlines?
//query :country=eg&category=business&apiKey=3783d079ed4a4f33aa288ce6e123000e


//search api
//https://newsapi.org/v2/everything?q=egypt&apiKey=3783d079ed4a4f33aa288ce6e123000e
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fproject/modules/shop_app/shop_login/shop_login_screen.dart';
import 'package:fproject/shared/components/components.dart';
import 'package:fproject/shared/network/local/chace_helper.dart';

String? token;
String? uId;
void signOut(context) {
  CachHelper.removeData(key: 'token').then((value) {
    if(value!){
      navigateAndRemove(context, ShopLoginScreen());
      print(token);
    }
  });
}
String socialCircularAvatarImage="https://img.freepik.com/free-photo/pink-haired-woman-looks-thoughtfully-isolated-wall_197531-24150.jpg?w=900&t=st=1688363546~exp=1688364146~hmac=e03b941884d2d4cab085af3f9a320199f384f59f99c68949c99ebd4a910fc46e";
String socialHomeImage="https://img.freepik.com/free-photo/influencer-marketing-job-concept_23-2150410561.jpg?w=900&t=st=1688362615~exp=1688363215~hmac=274f5d211a2730c29f65547ee5725032cd53deaa40995fdeff8a5f8875ed8255";
String socialPostImage="https://img.freepik.com/free-photo/laughing-asian-boy-glasses-shorts-embracing-charming-blonde-girls-front-outdoor-cafe-joyful-students-came-open-air-restaurant-celebrate-end-exams_197531-3870.jpg?t=st=1688363546~exp=1688364146~hmac=5807f168de270767acd291801cacdb0c29d179f4f813b912800dfad20f64e4ec";

