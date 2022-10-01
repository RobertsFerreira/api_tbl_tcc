import 'dart:convert';

import 'package:map_fields/map_fields.dart';
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

    router.get('/types_user', (Request req) async {
      try {
        final List<TypeUserModel> types = await _typesUserService.getAll();
        if (types.isEmpty) {
          return Response.notFound(
            jsonEncode(
              {'message': 'Nenhum tipo de usuário encontrado'},
            ),
          );
        } else {
          final typesMap = types.map((e) => e.toMap()).toList();
          final response = jsonEncode(typesMap);
          // final response = types.map((e) => e.toMap()).toList();
          return Response.ok(response);
        }
      } on MapFieldsError catch (e) {
        return Response.internalServerError(
          body: jsonEncode(
            {
              'message': e.toString(),
            },
          ),
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode(
            {'message': 'Erro interno desconhecido no servidor'},
          ),
        );
      }
    });

    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}
