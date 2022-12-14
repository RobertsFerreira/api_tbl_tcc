import 'dart:convert';

import 'package:api_tbl_tcc/core/interfaces/api/api.dart';
import 'package:api_tbl_tcc/core/models/apelacao/apelacao_default.dart';
import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/interfaces/generic_service/generic_service.dart';
import '../../models/apelacao/new_apelacao_model.dart';
import '../../services/apelacao/apelacao_service.dart';

class ApelacaoApi extends Api {
  final GenericService<ApelacaoDefault> apelacaoService;

  ApelacaoApi(this.apelacaoService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    final router = Router();

    router.get(
      '/apelacao',
      (Request request) async {
        final params = request.url.queryParameters;

        final maps = MapFields.load(params);

        final date = maps.getDateTime('data');
        final idQuiz = maps.getString('id_quiz');

        final result = await (apelacaoService as ApelacaoService).getApelacao(
          date: date,
          idQuiz: idQuiz,
        );

        final apelacoesMap = result
            .map(
              (apelacao) => (apelacao).toMap(),
            )
            .toList();

        final response = {
          'apelacoes': apelacoesMap,
        };

        return Response.ok(jsonEncode(response));
      },
    );

    router.post(
      '/apelacao',
      (Request request) async {
        final body = await request.readAsString();

        final mapFields = MapFields.load(body);

        final mapApelacao = mapFields.getMap<String, dynamic>('apelacao');

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
