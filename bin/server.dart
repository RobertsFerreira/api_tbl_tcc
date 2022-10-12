import 'package:api_tbl_tcc/apis/group/group_api.dart';
import 'package:api_tbl_tcc/export/export_functions.dart';
import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';

Future<void> main() async {
  MapFieldsSettings.instance.setLanguage(MapFieldsLanguages.ptBr);
  CustomEnv.fromFile('.env-dev');

  final port = CustomEnv.get<int>(key: 'server_port');

  print('netstat -a -o | find "$port');

  final i = Injects.init();

  var cascadeHandler = Cascade()
      .add(i.get<LoginApi>().handler)
      .add(i.get<SobreApi>().handler)
      .add(i.get<TypesUserApi>().getHandler())
      .add(i.get<UserApi>().getHandler())
      .add(i.get<GroupApi>().getHandler())
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterceptor.middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    handler: handler,
    address: CustomEnv.get<String>(key: 'server_address'),
    port: port,
  );
}
