//https://newsapi.org/v2/top-headlines?country=us&apiKey=7ce48a7bff0c4cb98475a703a3e942b2

//base url : https://newsapi.org/v2/?country=us&apiKey=7ce48a7bff0c4cb98475a703a3e942b2

import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();
  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async{
    return await dio.get(url, queryParameters: query);
  }
}
