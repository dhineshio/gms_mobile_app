import 'package:dio/dio.dart';

import '../../../../core/constants/api_routes.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../models/sample_model.dart';

abstract class SampleRemoteDataSource {
  Future<List<SampleModel>> getSamples({int page, int limit});
}

class SampleRemoteDataSourceImpl implements SampleRemoteDataSource {
  final DioClient dioClient;
  SampleRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<SampleModel>> getSamples({int page = 1, int limit = 10}) async {
    try {
      final response = await dioClient.get(
        ApiRoutes.withPagination(ApiRoutes.getSampleList,
            page: page, limit: limit),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true && data['data'] is List) {
          return (data['data'] as List)
              .map((json) => SampleModel.fromJson(json))
              .toList();
        }
        throw ServerException(message: data['message'] ?? 'Invalid response');
      }
      throw ServerException(
        message: response.data['message'] ?? 'Failed to fetch',
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
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
