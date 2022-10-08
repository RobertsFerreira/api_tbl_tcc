import 'package:api_tbl_tcc/core/models/errors/generic_error/generic_error.dart';
import 'package:dio/dio.dart';

import '../../core/interfaces/clients/http_client.dart';
import '../../core/models/errors/client/client_error.dart';
import '../../utils/custom_env.dart';

class DioClient implements HttpClient {
  late Dio _dio;

  DioClient() {
    final hostDatabase = CustomEnv.get<String>(key: 'host_database');
    final port = CustomEnv.get<String>(key: 'port_database');
    final hasuraSecretKey = CustomEnv.get<String>(key: 'hasura_secret_key');
    final hasuraSecret = CustomEnv.get<String>(key: 'hasura_secret');
    _dio = Dio(
      BaseOptions(
        headers: {hasuraSecretKey: hasuraSecret},
        baseUrl: 'http://$hostDatabase:$port/api/rest/',
      ),
    );
  }

  @override
  Future delete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      _getError(e);
    }
  }

  @override
  Future get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      _getError(e);
    }
  }

  @override
  Future post(String url, {body}) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
      );
      return response.data;
    } catch (e) {
      _getError(e);
    }
  }

  @override
  Future put(String url, {body}) async {
    try {
      final response = await _dio.put(
        url,
        data: body,
      );
      return response.data;
    } catch (e) {
      _getError(e);
    }
  }

  _getError(dynamic e) {
    if (e is DioError) {
      throw ClientError(
        message: e.response == null ? e.message : e.response?.data['error'],
        method: e.requestOptions.method,
        statusCode: e.response?.statusCode ?? -1,
      );
    } else {
      throw UnknownError(
        message: e.toString(),
      );
    }
  }
}
