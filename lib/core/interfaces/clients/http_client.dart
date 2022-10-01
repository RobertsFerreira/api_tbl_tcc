abstract class HttpClient {
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String url, {dynamic body});
  Future<dynamic> put(String url, {dynamic body});
  Future<dynamic> delete(String url, {Map<String, dynamic>? queryParameters});
}
