import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {
        @required String path,
        Map<String, dynamic> query,
        String lang = 'en',
        String token
      }) async {
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang':lang,
      'Authorization':token??''
    };
    return await dio.get(path, queryParameters: query??null);
  }

  static Future<Response> setData(
      {
        @required String path,
        Map<String, dynamic> query,
        @required data,
        String lang = 'en',
        String token,
      }) async {
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang':lang,
      'Authorization':token??''
    };

    return await dio.post(
        path,
        data:data,
        queryParameters: query??null,
    );
  }

  static Future<Response> putData(
      {
        @required String path,
        Map<String, dynamic> query,
        @required data,
        String lang = 'en',
        String token,
      }) async {
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang':lang,
      'Authorization':token??''
    };

    return await dio.put(
      path,
      data:data,
      queryParameters: query??null,
    );
  }


}
