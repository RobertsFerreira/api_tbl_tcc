import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class SobreApi {
  Handler get handler {
    Router router = Router();

    router.get('/sobre', (Request req) {
      return Response.ok('API VERSION - 0.0.1');
    });

    return router;
  }
}
