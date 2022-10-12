import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/interfaces/api/api.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/group/group_default.dart';
import '../../models/group/new_group_model.dart';

class GroupApi extends Api {
  final GenericService<GroupDefault> _groupService;

  GroupApi(this._groupService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

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
