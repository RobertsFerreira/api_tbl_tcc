import 'package:api_tbl_tcc/core/models/errors/arguments/invalid_argument_hasura.dart';
import 'package:api_tbl_tcc/core/models/errors/generic_error/generic_error.dart';
import 'package:api_tbl_tcc/core/models/user/user_default.dart';
import 'package:api_tbl_tcc/models/user/new_user_model.dart';
import 'package:api_tbl_tcc/models/user/user_model.dart';
import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/clients/http_client.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/errors/client/client_error.dart';
import '../../utils/hasura/helper_hasura.dart';

class UserService implements GenericService<UserDefault> {
  final HttpClient _client;

  UserService(this._client);

  @override
  Future<bool> insert(UserDefault user) async {
    try {
      final userMap = (user as NewUserModel).toMap();
      final response = await _client.post(
        'user',
        body: userMap,
      );

      return HelperHasura.returnResponseBool(response, 'insert_user');
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on InvalidArgumentHasura {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      final response = await _client.delete(
        'user',
        queryParameters: {
          'id': id,
        },
      );
      return HelperHasura.returnResponseBool(response, 'update_user');
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on InvalidArgumentHasura {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDefault> getById(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<UserDefault>> get({
    String? idCompany,
    String? typeUser,
  }) async {
    List<UserDefault> listOfUsers = [];
    try {
      if (idCompany == null) {
        throw InvalidIdCompany(
          message: 'É necessário informar o id da empresa',
        );
      }

      if (typeUser == null) {
        throw UnknownError(
          message: 'É necessário informar o tipo de usuário',
        );
      }
      final result = await _client.get(
        'user',
        queryParameters: {
          'id_company': idCompany,
          'type_user': typeUser,
        },
      );

      final map = MapFields.load(result);

      final listUsers = map.getList<Map<String, dynamic>>('user', []);

      final users = listUsers.map((e) => UserModel.fromMap(e)).toList();

      listOfUsers = users;
    } on MapFieldsError {
      rethrow;
    } on ClientError {
      rethrow;
    } on UnknownError {
      rethrow;
    } on InvalidIdCompany {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return listOfUsers;
  }

  @override
  Future<bool> update(UserDefault user) async {
    try {
      final userMap = (user as UserModel).toUpdate();

      final response = await _client.put(
        'user',
        body: userMap,
      );

      return HelperHasura.returnResponseBool(response, 'update_user');
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on InvalidArgumentHasura {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
