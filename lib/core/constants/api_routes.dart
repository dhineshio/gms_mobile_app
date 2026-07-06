class ApiRoutes {
  ApiRoutes._();

  static const String baseUrl = 'https://api.example.com';

  // Image / CDN base URLs
  static const String imageBaseUrl = 'https://cdn.example.com/uploads';

  // ===== Auth =====
  static const String logout = '$baseUrl/user/auth/logout';

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
