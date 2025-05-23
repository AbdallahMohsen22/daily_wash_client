import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static late Dio dio;
  static late Response response;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://daily-wash.com/api/',
        receiveTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60),
        receiveDataWhenStatusError: true,
        validateStatus: (status) => true,
        followRedirects: true,
      ),
    );

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String? lang,
  }) async {
    dio.options.headers = {
      'Accept-Language': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return response = await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    String? token,
    String? lang,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
      'Accept-Language': lang,
    };

    return response = await dio.post(
      url,
      data: data,
    );
  }

  static Future<Response> postData2({
    required String url,
    Map<String, dynamic>? data,
    String? token,
    String? lang,
    FormData? formData,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
      'Accept-Language': lang,
    };

    return response = await dio.post(
      url,
      data: formData,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
    String? token,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'Accept-Language': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return response = await dio.put(url, data: data);
  }

  static Future<Response> putData2({
    required String url,
    Map<String, dynamic>? data,
    String? token,
    String lang = 'en',
    FormData? formData,
  }) async {
    dio.options.headers = {
      'Accept-Language': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return response = await dio.put(url, data: data ?? formData);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    String? token,
    String lang = 'en',
  }) async {
    dio.options.headers = {
      'Accept-Language': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return response = await dio.delete(url, data: data);
  }
}
