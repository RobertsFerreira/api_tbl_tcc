import 'package:api_tbl_tcc/apis/login/login_api.dart';
import 'package:api_tbl_tcc/apis/sobre/sobre_api.dart';
import 'package:api_tbl_tcc/apis/types_user/type_user.dart';
import 'package:api_tbl_tcc/apis/user/user_api.dart';
import 'package:api_tbl_tcc/core/interfaces/clients/http_client.dart';
import 'package:api_tbl_tcc/infra/middleware/middleware_interceptor.dart';
import 'package:api_tbl_tcc/infra/server/custom_server.dart';
import 'package:api_tbl_tcc/services/client/dio_client.dart';
import 'package:api_tbl_tcc/services/types_user/types_user_service.dart';
import 'package:api_tbl_tcc/utils/custom_env.dart';
import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';

Future<void> main() async {
  MapFieldsSettings.instance.setLanguage(MapFieldsLanguages.ptBr);

  CustomEnv.fromFile('.env-dev');

  final HttpClient client = DioClient();

  var cascadeHandler = Cascade()
      .add((LoginApi().handler))
      .add(UserApi().handler)
      .add(SobreApi().handler)
      .add(
        TypesUserApi(TypesUserService(client)).getHandler(),
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
