import 'package:shelf/shelf.dart';

import 'apis/login/login_api.dart';
import 'apis/sobre/sobre_api.dart';
import 'apis/types_user/type_user.dart';
import 'apis/user/user_api.dart';
import 'infra/middleware/middleware_interceptor.dart';
import 'infra/server/custom_server.dart';
import 'services/client/dio_client.dart';
import 'services/interfaces/clients/http_client.dart';
import 'services/types_user/types_user_service.dart';
import 'utils/custom_env.dart';

Future<void> main() async {
  CustomEnv.fromFile('.env-dev');

  final HttpClient client = DioClient();

  var cascadeHandler = Cascade()
      .add((LoginApi().handler))
      .add(UserApi().handler)
      .add(SobreApi().handler)
      .add(
        TypesUserApi(TypesUserService(client)).handler,
      )
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterceptor().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: CustomEnv.get<String>(key: 'server_address'),
    port: CustomEnv.get<int>(key: 'server_port'),
  );
}
