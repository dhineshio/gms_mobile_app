import 'package:dio/dio.dart';

import 'auth_interceptor.dart';
import 'logger_interceptor.dart';

class DioClient {
  late final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
          ),
        )..interceptors.addAll([
            AuthInterceptor(),
            LoggerInterceptor(),
          ]);

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(url,
          queryParameters: queryParameters, options: options);
    } on DioException {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(url,
          data: data, queryParameters: queryParameters, options: options);
    } on DioException {
      rethrow;
    }
  }

  Future<Response> put(String url, {dynamic data, Options? options}) async {
    try {
      return await _dio.put(url, data: data, options: options);
    } on DioException {
      rethrow;
    }
  }

  Future<Response> delete(String url, {dynamic data, Options? options}) async {
    try {
      return await _dio.delete(url, data: data, options: options);
    } on DioException {
      rethrow;
    }
  }
}
