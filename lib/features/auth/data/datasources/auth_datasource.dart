import 'package:dio/dio.dart';

import '../../../../core/constants/api_routes.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResultModel> memberLogin(String memberId);
  Future<AuthResultModel> adminLogin(String memberId, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AuthResultModel> memberLogin(String memberId) {
    return _login(ApiRoutes.memberLogin, {'member_id': memberId});
  }

  @override
  Future<AuthResultModel> adminLogin(String memberId, String password) {
    return _login(ApiRoutes.adminLogin, {
      'member_id': memberId,
      'password': password,
    });
  }

  Future<AuthResultModel> _login(String url, Map<String, dynamic> body) async {
    try {
      final response = await dioClient.post(url, data: body);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] != null) {
          return AuthResultModel.fromJson(data['data'] as Map<String, dynamic>);
        }
        throw ServerException(message: data['message'] ?? 'Invalid response');
      } 
      throw ServerException(
        message: response.data['message'] ?? 'Login failed',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: 'Unexpected error: $e');
    }
  }

  ApiException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        final msg = e.response?.data?['message']?.toString();
        if (code == 401) {
          return UnauthorizedException(message: msg ?? 'Unauthorized');
        }
        if (code == 404) return NotFoundException(message: msg ?? 'Not found');
        return ServerException(message: msg ?? 'Request failed', statusCode: code);
      default:
        return ApiException(message: e.message ?? 'Unknown error');
    }
  }
}
