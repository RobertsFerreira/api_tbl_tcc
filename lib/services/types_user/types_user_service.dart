import 'dart:async';

import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/clients/http_client.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/errors/client/client_error.dart';
import '../../models/type_user/type_user_model.dart';

class TypesUserService implements GenericService<TypeUserModel> {
  final HttpClient _client;

  TypesUserService(this._client);

  @override
  Future<bool> insert(TypeUserModel t) {
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<TypeUserModel> getById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<TypeUserModel>> get({String? idCompany}) async {
    List<TypeUserModel> listTypes = [];
    try {
      final result = await _client.get('types_users');

      final map = MapFields.load(result);

      final listTypesUser = map.getList<Map<String, dynamic>>('types_user', []);

      final types = listTypesUser.map((e) => TypeUserModel.fromMap(e)).toList();

      listTypes = types;
    } on MapFieldsError {
      rethrow;
    } on ClientError {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return listTypes;
  }

  @override
  Future<bool> update(TypeUserModel t) {
    throw UnimplementedError();
  }
}
