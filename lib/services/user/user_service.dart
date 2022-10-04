import 'package:api_tbl_tcc/core/models/errors/generic_error/generic_error.dart';
import 'package:api_tbl_tcc/core/models/user/user_default.dart';
import 'package:api_tbl_tcc/models/user/user_model.dart';
import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/clients/http_client.dart';
import '../../core/interfaces/generic_service/generic_service.dart';

class UserService implements GenericService<UserDefault> {
  final HttpClient _client;

  UserService(this._client);

  @override
  Future<UserDefault> insert(UserDefault user) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<UserDefault> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<UserDefault> get(int id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<UserDefault>> getAll() {
    throw UnimplementedError();
  }

  @override
  Future<List<UserDefault>> getAllForCompany({
    required String idCompany,
  }) async {
    List<UserDefault> listOfUsers = [];
    try {
      final result = await _client.get(
        'get/users',
        queryParameters: {
          'id_company': idCompany,
        },
      );

      final map = MapFields.load(result['data'] ?? {});

      final listUsers = map.getList<Map<String, dynamic>>('users', []);

      final users = listUsers.map((e) => UserModel.fromMap(e)).toList();

      listOfUsers = users;
    } on InvalidMapStringObjectError {
      rethrow;
    } on MapFieldsErrorMissingRequiredField {
      rethrow;
    } on UnknownErrorMapFieldsError {
      rethrow;
    } on ConvertMapStringFieldError {
      rethrow;
    } on InvalidIdCompany {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return listOfUsers;
  }

  @override
  Future<UserDefault> update(UserDefault user) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
