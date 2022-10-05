import 'package:api_tbl_tcc/core/models/errors/arguments/invalid_argument_hasura.dart';
import 'package:api_tbl_tcc/core/models/errors/generic_error/generic_error.dart';
import 'package:api_tbl_tcc/core/models/user/user_default.dart';
import 'package:api_tbl_tcc/models/user/new_user_model.dart';
import 'package:api_tbl_tcc/models/user/user_model.dart';
import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/clients/http_client.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/errors/client/client_error.dart';

class UserService implements GenericService<UserDefault> {
  final HttpClient _client;

  UserService(this._client);

  @override
  Future<bool> insert(UserDefault user) async {
    try {
      final userMap = (user as NewUserModel).toJson();
      final response = await _client.post(
        'users',
        body: userMap,
      );

      final data = response['data'];

      if (data == null) {
        final errors = response['errors'];
        final mapErrors = MapFields.load(errors);
        final listErros = mapErrors.getList<Map<String, dynamic>>("errors");
        String messageError = "";
        for (var error in listErros) {
          final mapError = MapFields.load(error);
          final message = mapError.getString("message");
          final index = listErros.indexOf(error);
          messageError += "Erro $index: $message\n";
        }
        throw InvalidArgumentHasura(message: messageError);
      }

      final mapResponse = MapFields.load(data['insert_user'] ?? {});
      final result = mapResponse.getInt('affected_rows', -1);
      if (result == -1) {
        throw MapFieldsErrorMissingRequiredField('affected_rows');
      } else if (result == 1) {
        return true;
      } else {
        throw UnknownError(
          message:
              'Erro ao inserir usuário, houve mais de um usuário inserido: $result',
        );
      }
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on InvalidArgumentHasura {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<UserDefault> getById(int id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<UserDefault>> get({
    String? idCompany,
  }) async {
    List<UserDefault> listOfUsers = [];
    try {
      final result = await _client.get(
        'users',
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
  Future<bool> update(UserDefault user) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
