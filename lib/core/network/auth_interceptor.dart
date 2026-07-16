import 'package:dio/dio.dart';

import '../services/local_storage_service.dart';

/// Attaches the stored auth token to every request and handles 401s.
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = LocalStorageService.accessToken;
    if (token != null && token.isNotEmpty) {
      // ninja-jwt expects a standard Bearer token.
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token expired / invalid → clear session.
      // Hook a refresh-token flow or a global logout redirect here.
      LocalStorageService.clearToken();
    }
    handler.next(err);
  }
}
