import 'dart:convert';

import 'package:api_tbl_tcc/core/models/quiz/quiz_default_model.dart';
import 'package:api_tbl_tcc/services/quiz/quiz_service.dart';
import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/interfaces/api/api.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../models/quiz/new_quiz_model.dart';
import '../../models/quiz/quiz_model.dart';

class QuizApi extends Api {
  final GenericService<QuizDefaultModel> _quizService;

  QuizApi(this._quizService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    router.get('/quizzes/<idCompany>/<idClass>', (
      Request req,
      String idCompany,
      String idClass,
    ) async {
      final queryParams = req.url.queryParameters;

      final map = MapFields.load(queryParams);

      final quizzes = await (_quizService as QuizService).get(
        idCompany: idCompany,
        idClass: idClass,
        from: map.getDateTime('from'),
        to: map.getDateTime('to'),
      );

      if (quizzes.isEmpty) {
        return Response(204);
      } else {
        final quizMap = quizzes
            .map(
              (quiz) => (quiz as QuizModel).toMap(),
            )
            .toList();
        final response = jsonEncode(
          {
            'quizzes': quizMap,
          },
        );
        return Response.ok(response);
      }
    });

    router.post('/quizzes', (Request req) async {
      final body = await req.readAsString();
      final newQuiz = NewQuizModel.fromJson(body);
      final inserted = await _quizService.insert(newQuiz);
      if (inserted) {
        return Response(
          201,
          body: jsonEncode(
            {
              'message': 'Quiz inserido com sucesso',
            },
          ),
        );
      }
      return Response.ok('Quiz');
    });

    router.put('/quizzes/answered/<idCompany>/<idGroup>', (
      Request req,
      String idCompany,
      String idGroup,
    ) {
      final updated =
          (_quizService as QuizService).updateQuizAnswered(idCompany, idGroup);

      if (updated) {
        return Response.ok(
          jsonEncode(
            {
              'message': 'Quiz atualizado com sucesso',
            },
          ),
        );
      } else {
        return Response(
          400,
          body: jsonEncode(
            {
              'message': 'Erro ao atualizar o quiz',
            },
          ),
        );
      }
    });

    return createHandler(router: router, middlewares: middlewares);
  }
}
