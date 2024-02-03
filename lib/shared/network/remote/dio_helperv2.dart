import 'package:dio/dio.dart';

class DioHelperV2{
 static Dio? dio;

static init()
  {
   dio=Dio(
       BaseOptions(
       receiveDataWhenStatusError: true,
        baseUrl: 'https://newsapi.org/',
       ),
   );
  }

 static Future<Response>? getData({
 required String url,
 required Map<String,dynamic> query,
})
 async{
  return await dio!.get(url,queryParameters:query);

  }
}