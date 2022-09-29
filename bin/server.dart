import 'package:shelf/shelf.dart';

import 'apis/login/login_api.dart';
import 'apis/user/user.dart';
import 'infra/server/custom_server.dart';
import 'utils/custom_env.dart';

Future<void> main() async {
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
