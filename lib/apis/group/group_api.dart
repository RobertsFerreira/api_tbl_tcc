import 'dart:convert';

import 'package:api_tbl_tcc/services/group/group_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/interfaces/api/api.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/group/group_default.dart';
import '../../models/group/group_model.dart';
import '../../models/group/new_group_model.dart';

class GroupApi extends Api {
  final GenericService<GroupDefault> _groupService;

  GroupApi(this._groupService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    router.get('/group/<idClass>', (Request req, String idClass) async {
      final groups = await (_groupService as GroupService).get(
        idClass: idClass,
      );
      if (groups.isEmpty) {
        return Response(204);
      } else {
        final groupMap = groups
            .map(
              (group) => (group as GroupModel).toMap(),
            )
            .toList();
        final response = jsonEncode(
          {
            'groups': groupMap,
          },
        );
        return Response.ok(response);
      }
    });

    router.post('/group', (Request req) async {
      final body = await req.readAsString();
      final newGroup = NewGroupModel.fromJson(body);
      final inserted = await _groupService.insert(newGroup);
      if (inserted) {
        return Response(
          201,
          body: jsonEncode(
            {
              'message': 'Grupo inserido com sucesso',
            },
          ),
        );
      }
    });

    return createHandler(router: router, middlewares: middlewares);
  }
}
