import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/interfaces/api/api.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../models/type_user/type_user_model.dart';

class TypesUserApi extends Api {
  final GenericService<TypeUserModel> _typesUserService;

  TypesUserApi(this._typesUserService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    router.get('v1/types_user', (Request req) async {
      final List<TypeUserModel> types = await _typesUserService.get();
      if (types.isEmpty) {
        return Response.notFound(
          jsonEncode(
            {
              'message': 'Nenhum tipo de usuário encontrado',
            },
          ),
        );
      } else {
        final typesMap = types.map((e) => e.toMap()).toList();
        final response = jsonEncode(typesMap);
        return Response.ok(response);
      }
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}
