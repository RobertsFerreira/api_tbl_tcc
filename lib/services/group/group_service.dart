import 'package:api_tbl_tcc/core/models/group/group_default.dart';
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
  Future<List<GroupDefault>> get({String? idCompany}) {
    // TODO: implement get
    throw UnimplementedError();
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
      final response = await _client.post(
        'group',
        body: groupMap,
      );

      return HelperHasura.returnResponseBool(response, 'insert_group');
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
