import 'dart:convert';

import 'package:api_tbl_tcc/services/login/login.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/interfaces/api/api.dart';
import '../../models/user/login_user_model.dart';

class LoginApi extends Api {
  final LoginService _loginService;

  LoginApi(this._loginService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    final Router router = Router();

    router.post('/login', (Request req) async {
      final body = await req.readAsString();
      final user = LoginUserModel.fromJson(body);
      final userLogged = await _loginService.login(user);
      final returnUser = {'user': userLogged.toMap()};
      return Response.ok(jsonEncode(returnUser));
    });

    return createHandler(router: router, middlewares: middlewares);
  }
}
