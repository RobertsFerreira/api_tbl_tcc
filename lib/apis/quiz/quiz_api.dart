import 'dart:convert';

import 'package:api_tbl_tcc/models/quiz/quiz_default_model.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/interfaces/api/api.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../models/quiz/new_quiz_model.dart';

class QuizApi extends Api {
  final GenericService<QuizDefaultModel> _quizService;

  QuizApi(this._quizService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    router.post('/quiz', (Request req) async {
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

    return createHandler(router: router, middlewares: middlewares);
  }
}