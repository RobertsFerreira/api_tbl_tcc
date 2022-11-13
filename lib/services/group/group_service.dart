import 'package:api_tbl_tcc/core/models/group/group_default.dart';
import 'package:api_tbl_tcc/models/group/group_model.dart';
import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/errors/arguments/invalid_argument_hasura.dart';
import '../../core/models/errors/client/client_error.dart';
import '../../core/models/errors/generic_error/generic_error.dart';
import '../../export/export_functions.dart';
import '../../models/group/new_group_model.dart';
import '../../utils/hasura/helper_hasura.dart';

class GroupService implements GenericService<GroupDefault> {
  final HttpClient _client;

  GroupService(this._client);

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<GroupDefault>> get({String? idCompany, String? idClass}) async {
    List<GroupDefault> listOfGroups = [];
    try {
      if (idClass == null) {
        throw InvalidIdClass(
          message: 'É necessário informar o id da turma',
        );
      }
      final result = await _client.get(
        'groups',
        queryParameters: {
          'id_class': idClass,
        },
      );

      if (result == {}) {
        return listOfGroups;
      }

      final map = MapFields.load(result);

      final listGroups = map.getList<Map<String, dynamic>>('group', []);

      final groups = listGroups.map((e) => GroupModel.fromMap(e)).toList();

      listOfGroups = groups;
    } on MapFieldsError {
      rethrow;
    } on InvalidIdClass {
      rethrow;
    } on ClientError {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return listOfGroups;
  }

  @override
  Future<GroupDefault> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(GroupDefault group) async {
    try {
      final groupMap = (group as NewGroupModel).toMap();

      var response = await _client.post(
        'groups',
        body: groupMap,
      );

      final idGroup = HelperHasura.returningHasura(
        response,
        keyHeaderMap: 'insert_group',
        keyValueSearch: 'id',
      );

      if (idGroup.isEmpty) {
        throw InvalidArgumentHasura(
          message: 'Erro ao buscar o código do grupo',
          key: 'insert_group.returning.id',
        );
      }

      final mapUsers = group.users
          .map((e) => {
                //verificar os dados montas aqui
                'id_group': idGroup,
                'id_user': e.id,
              })
          .toList();

      response = await _client.post(
        'groups/users',
        body: {
          'users': mapUsers,
        },
      );

      return HelperHasura.returnResponseBool(response, 'insert_users_groups');
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
  Future<bool> update(GroupDefault group) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
