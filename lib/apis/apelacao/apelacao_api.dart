import 'dart:convert';

import 'package:api_tbl_tcc/core/interfaces/api/api.dart';
import 'package:api_tbl_tcc/models/apelacao/new_apelacao_model.dart';
import 'package:api_tbl_tcc/services/apelacao/apelacao_service.dart';
import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ApelacaoApi extends Api {
  final ApelacaoService apelacaoService;

  ApelacaoApi(this.apelacaoService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    final router = Router();

    router.post(
      '/apelacao',
      (Request request) async {
        final body = await request.readAsString();

        final mapFields = MapFields.load(body);

        final mapApelacao = mapFields.getMap<String, String>('apelacao');

        final apelacao = NewApelacaoModel.fromMap(mapApelacao);

        final inserted = await apelacaoService.insert(apelacao);

        if (inserted) {
          return Response(
            201,
            body: jsonEncode(
              {
                'message': 'Apelação inserida com sucesso!',
              },
            ),
          );
        } else {
          return Response.internalServerError(
            body: 'Erro ao inserir apelação!',
          );
        }
      },
    );

    return createHandler(
      router: router,
      middlewares: middlewares,
    );
  }
}
