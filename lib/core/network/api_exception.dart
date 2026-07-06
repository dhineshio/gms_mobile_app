/// Data-layer exceptions thrown by datasources. Repositories catch these and
/// map them to [Failure]s.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  const ApiException({required this.message, this.statusCode});
}

class ServerException extends ApiException {
  const ServerException({required super.message, super.statusCode});
}

class NetworkException extends ApiException {
  const NetworkException({super.message = 'No internet connection'});
}

class TimeoutException extends ApiException {
  const TimeoutException({super.message = 'Request timed out'});
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    super.message = 'Unauthorized',
    super.statusCode = 401,
  });
}

class NotFoundException extends ApiException {
  const NotFoundException({
    super.message = 'Not found',
    super.statusCode = 404,
  });
}
