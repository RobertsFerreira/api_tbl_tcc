import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../services/interfaces/generic_service/generic_service.dart';

class TypesUserApi {
  final GenericService typesUserService;

  TypesUserApi(this.typesUserService);

  Handler get handler {
    Router router = Router();

    router.get('/types_user', (Request req) async {
      final types = await typesUserService.getAll();
      return Response.ok('types_user get');
    });

    return router;
  }
}
