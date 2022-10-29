import 'package:api_tbl_tcc/export/export_functions.dart';
import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';

Future<void> main() async {
  MapFieldsSettings.instance.setLanguage(MapFieldsLanguages.ptBr);
  CustomEnv.fromFile('.env-dev');

  final port = CustomEnv.get<int>(key: 'server_port');

  print('netstat -a -o | find "$port" para windows');

  print('lsof -w -n -i tcp:"$port" para Linux');
  print('kill -9 PID para Linux');

  final i = Injects.init();

  var cascadeHandler = Cascade()
      .add(i.get<LoginApi>().getHandler())
      .add(i.get<SobreApi>().handler)
      .add(i.get<TypesUserApi>().getHandler())
      .add(i.get<UserApi>().getHandler())
      .add(i.get<GroupApi>().getHandler())
      .add(i.get<QuizApi>().getHandler())
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
