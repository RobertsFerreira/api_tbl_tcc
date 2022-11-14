import 'dart:convert';

import 'package:api_tbl_tcc/core/models/quiz/quiz_default_model.dart';
import 'package:api_tbl_tcc/models/group/group_model.dart';
import 'package:api_tbl_tcc/services/quiz/quiz_service.dart';
import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/infra/bind_injectors/bind_injectors.dart';
import '../../core/interfaces/api/api.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../models/quiz/answer/answer_user_model.dart';
import '../../models/quiz/new_quiz_model.dart';
import '../../models/quiz/quiz_model.dart';
import 'quiz_sub_api.dart';

class QuizApi extends Api {
  final GenericService<QuizDefaultModel> _quizService;

  final quizSubApi = BindInjectors().get<QuizSubApi>();

  QuizApi(this._quizService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    router.get('/quizzes/<idCompany>/<idUser>', (
      Request req,
      String idCompany,
      String idUser,
    ) async {
      final quizzes = await (_quizService as QuizService).get(
        idCompany: idCompany,
        idUser: idUser,
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

    // router.get('/quizzes/user/<idCompany>/<idUser>', (
    //   Request req,
    //   String idCompany,
    //   String idUser,
    // ) async {
    //   final queryParams = req.url.queryParameters;

    //   final map = MapFields.load(queryParams);

    //   final quizzes = await (_quizService as QuizService).getUserOfStudent(
    //     idCompany: idCompany,
    //     idUser: idUser,
    //     from: map.getDateTime('from'),
    //     to: map.getDateTime('to'),
    //   );

    //   if (quizzes.isEmpty) {
    //     return Response(204);
    //   } else {
    //     final quizMap = quizzes
    //         .map(
    //           (quiz) => (quiz as QuizModel).toMap(),
    //         )
    //         .toList();
    //     final response = jsonEncode(
    //       {
    //         'quizzes': quizMap,
    //       },
    //     );
    //     return Response.ok(response);
    //   }
    // });

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

    router.post('/quizzes/answers/users', (Request req) async {
      final body = await req.readAsString();

      final maps = MapFields.load(jsonDecode(body));

      final answers = maps.getList<Map<String, dynamic>>('answers');

      final answersUser = answers
          .map(
            (answer) => AnswerUserModel.fromMap(answer),
          )
          .toList();

      final inserted =
          await (_quizService as QuizService).insertAnswersUser(answersUser);

      if (inserted) {
        return Response(
          201,
          body: jsonEncode(
            {
              'message': 'Respostas inseridas com sucesso',
            },
          ),
        );
      } else {
        return Response(
          400,
          body: jsonEncode(
            {
              'message': 'Erro ao inserir as respostas',
            },
          ),
        );
      }
    });

    router.post('/quizzes/vincule', (Request req) async {
      final body = await req.readAsString();

      final map = MapFields.load(body);

      final idQuiz = map.getString('id_quiz');

      final date = map.getDateTime('date');

      final groupsMap = map.getList<Map<String, dynamic>>('groups');

      final groups = groupsMap
          .map(
            (group) => GroupModel.fromMap(group),
          )
          .toList();

      final inserted =
          await (_quizService as QuizService).insertQuizLinkedGroups(
        groups,
        idQuiz,
        date,
      );

      if (inserted) {
        return Response(
          201,
          body: jsonEncode(
            {
              'message': 'Quiz vinculado com sucesso',
            },
          ),
        );
      } else {
        return Response(
          400,
          body: jsonEncode(
            {
              'message': 'Erro ao vincular o quiz',
            },
          ),
        );
      }
    });

    router.get('/quiz/group/linked', (Request req) async {
      final queryParams = req.url.queryParameters;

      final map = MapFields.load(queryParams);

      final dataIni = map.getDateTime('data_ini');

      final dataFim = map.getDateTime('data_fim');

      final listVinculos =
          await (_quizService as QuizService).getAllVinculoQuizzes(
        dataIni,
        dataFim,
      );

      if (listVinculos.isEmpty) {
        return Response(204);
      } else {
        final quizMap = listVinculos
            .map(
              (quiz) => quiz.toMap(),
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

    router.get('/user/quizzes/<idUser>', (Request req, String idUser) async {
      //params = intervalo de datas da pesquisa e
      //o tipo de quiz quer ver: Somente respondidos ou somente a responder
      final params = req.url.queryParameters;

      final quizzes = await quizSubApi.getQuizzesUser(
        queryParams: params,
        idUser: idUser,
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

    router.post('/quizzes/answers/group', (Request req) async {
      final inserted = await quizSubApi.insertAnswersGroup(request: req);
      if (inserted) {
        return Response(
          201,
          body: jsonEncode(
            {
              'message': 'Respostas inseridas com sucesso',
            },
          ),
        );
      } else {
        return Response(
          400,
          body: jsonEncode(
            {
              'message': 'Erro ao inserir as respostas',
            },
          ),
        );
      }
    });

    router.get('/quizzes/result', (Request req) async {
      final result = await quizSubApi.getQuizResults(request: req);

      if (result.isEmpty) {
        return Response(204);
      } else {
        final quizMap = result.map((quiz) => quiz.toMap()).toList();

        final response = jsonEncode(
          {
            'quizzes': quizMap,
          },
        );

        return Response.ok(response);
      }
    });

    return createHandler(router: router, middlewares: middlewares);
  }
}
