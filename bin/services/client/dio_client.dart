import 'package:dio/dio.dart';

import '../../utils/custom_env.dart';
import '../interfaces/clients/http_client.dart';

class DioClient implements HttpClient {
  late Dio _dio;

  DioClient() {
    final hostDatabase = CustomEnv.get<String>(key: 'host_database');
    final port = CustomEnv.get<String>(key: 'port');
    final hasuraSecretKey = CustomEnv.get<String>(key: 'hasura_secret_key');
    final hasuraSecret = CustomEnv.get<String>(key: 'hasura_secret');
    _dio = Dio(
      BaseOptions(
        headers: {hasuraSecretKey: hasuraSecret},
        baseUrl: 'http://$hostDatabase:$port',
      ),
    );
  }

  @override
  Future delete(String url, {Map<String, dynamic>? queryParameters}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future post(String url, {body}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future put(String url, {body}) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
