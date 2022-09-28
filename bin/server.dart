import 'package:shelf/shelf.dart';

import 'api/login/login_api.dart';
import 'api/user/user.dart';
import 'infra/server/custom_server.dart';
import 'utils/custom_env.dart';

// Configure routes.
// final _router = Router()..get('/sobre', _rootHandler);

// Response _rootHandler(Request req) {
//   return Response.ok('API VERSION - 0.0.1');
// }

Future<void> main() async {
  // Configure a pipeline that logs requests.
  // final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  var cascadeHandler =
      Cascade().add((LoginApi().handler)).add(User().handler).handler;

  var handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: CustomEnv.get<String>(key: 'server_address'),
    port: CustomEnv.get<int>(key: 'server_port'),
  );
}
