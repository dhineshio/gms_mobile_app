class ApiRoutes {
  ApiRoutes._();

  // 10.0.2.2 is the Android emulator's loopback to the host machine.
  // Use your machine's LAN IP for a physical device (e.g. http://192.168.1.50:8000).
  static const String baseUrl = 'http://192.168.1.7:8000';

  // Profile pics come back as /media/... paths on the same host.
  static const String imageBaseUrl = baseUrl;

  // ===== Auth =====
  static const String memberLogin = '$baseUrl/api/v1/auth/login';
  static const String adminLogin = '$baseUrl/api/v1/auth/admin/login';
  static const String refreshToken = '$baseUrl/api/v1/auth/refresh';

  // ===== Sample feature =====
  static const String getSampleList = '$baseUrl/user/app/sample/list';

  // ===== Helpers =====
  static String withQueryParams(String endpoint, Map<String, dynamic> params) {
    if (params.isEmpty) return endpoint;
    final query = params.entries
        .where((e) => e.value != null)
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
    return query.isEmpty ? endpoint : '$endpoint?$query';
  }

  static String withPagination(String endpoint, {int page = 1, int limit = 10}) =>
      withQueryParams(endpoint, {'page': page, 'limit': limit});
}
