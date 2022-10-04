import 'dart:async';

import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/clients/http_client.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../models/type_user/type_user_model.dart';

class TypesUserService implements GenericService<TypeUserModel> {
  final HttpClient _client;

  TypesUserService(this._client);

  @override
  Future<TypeUserModel> add(TypeUserModel t) {
    throw UnimplementedError();
  }

  @override
  Future<TypeUserModel> delete(int id) {
    throw UnimplementedError();
  }

  @override
  Future<TypeUserModel> get(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<TypeUserModel>> getAll() async {
    List<TypeUserModel> listTypes = [];
    try {
      final result = await _client.get('get/types_users/all');

      final map = MapFields.load(result);

      final listTypesUser = map.getList<Map<String, dynamic>>('types_user', []);

      final types = listTypesUser.map((e) => TypeUserModel.fromMap(e)).toList();

      listTypes = types;
    } on InvalidMapStringObjectError {
      rethrow;
    } on MapFieldsErrorMissingRequiredField {
      rethrow;
    } on UnknownErrorMapFieldsError {
      rethrow;
    } on ConvertMapStringFieldError {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return listTypes;
  }

  @override
  Future<TypeUserModel> update(TypeUserModel t) {
    throw UnimplementedError();
  }

  @override
  Future<List<TypeUserModel>> getAllForCompany({required String idCompany}) {
    throw UnimplementedError();
  }
}
