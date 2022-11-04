import 'dart:convert';

import 'package:api_tbl_tcc/services/user/user_service.dart';
import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/interfaces/api/api.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/user/user_default.dart';
import '../../models/user/new_user_model.dart';
import '../../models/user/user_model.dart';

class UserApi extends Api {
  final GenericService<UserDefault> _userService;

  UserApi(this._userService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    router.delete('/user/<id>', (Request req, String id) async {
      final deleted = await _userService.delete(id);
      if (deleted) {
        return Response(
          200,
          body: jsonEncode(
            {
              'message': 'Usuário deletado com sucesso',
            },
          ),
        );
      }
    });

    router.get('/users/<company>', (Request req, String company) async {
      final params = req.url.queryParameters;
      final map = MapFields.load(params);
      final typeUser = map.getString('type_user');
      final users = await (_userService as UserService).get(
        idCompany: company,
        typeUser: typeUser,
      );
      if (users.isEmpty) {
        return Response(204);
      } else {
        final userMap = users
            .map(
              (user) => (user as UserModel).toMap(),
            )
            .toList();
        final response = jsonEncode(
          {
            'users': userMap,
          },
        );
        return Response.ok(response);
      }
    });

    router.post('/user', (Request req) async {
      final body = await req.readAsString();
      final newUser = NewUserModel.fromJson(body);
      final inserted = await _userService.insert(newUser);
      if (inserted) {
        return Response(
          201,
          body: jsonEncode(
            {
              'message': 'Usuário inserido com sucesso',
            },
          ),
        );
      }
    });

    router.put('/user', (Request req) async {
      final body = await req.readAsString();
      final user = UserModel.fromJson(body);
      final updated = await _userService.update(user);
      if (updated) {
        return Response(
          200,
          body: jsonEncode(
            {
              'message': 'Usuário atualizado com sucesso',
            },
          ),
        );
      }
    });

    return createHandler(router: router, middlewares: middlewares);
  }
}
