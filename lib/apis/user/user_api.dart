import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class UserApi {
  Handler get handler {
    Router router = Router();

    router.get('/user', (Request req) {
      return Response.ok('Funcionando');
    });

    router.post('/user', (Request req) {
      return Response.ok('user post');
    });

    return router;
  }
}
