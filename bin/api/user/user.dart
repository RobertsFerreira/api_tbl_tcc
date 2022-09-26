import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class User {
  Handler get handler {
    Router router = Router();

    router.get('/user', (Request req) {
      return Response.ok('Funcionando');
    });

    return router;
  }
}
