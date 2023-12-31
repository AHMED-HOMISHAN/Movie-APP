// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:movieapp/API/endPoints.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: BASEURL,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio.post(url, data: data);
  }

  static Future<Response> getDate({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    query = {'api_key': apiKey};

    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio.put(url, data: data);
  }
}
