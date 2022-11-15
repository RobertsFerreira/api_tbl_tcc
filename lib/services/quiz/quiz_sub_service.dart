import 'package:api_tbl_tcc/models/quiz/answer/new_answer_group_model.dart';
import 'package:api_tbl_tcc/models/quiz_result/quiz_result.dart';
import 'package:api_tbl_tcc/utils/hasura/helper_extensions.dart';
import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/clients/http_client.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/errors/client/client_error.dart';
import '../../core/models/errors/generic_error/generic_error.dart';
import '../../core/models/quiz/quiz_default_model.dart';
import '../../models/quiz/quiz_model.dart';
import '../../utils/hasura/helper_hasura.dart';

class QuizSubService implements GenericService<QuizDefaultModel> {
  final HttpClient _client;

  QuizSubService(this._client);

  @override
  Future<bool> delete(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<QuizDefaultModel>> get({
    String? idCompany,
    String? userId,
    String? dataIni,
    String? dataFim,
    bool? answered,
  }) async {
    final listOfQuizzes = <QuizModel>[];
    try {
      if (userId == null) {
        throw UnknownError(message: 'userId is null');
      }

      if (dataIni == null) {
        throw UnknownError(message: 'dataIni is null');
      }

      if (dataFim == null) {
        throw UnknownError(message: 'dataFim is null');
      }

      if (answered == null) {
        throw UnknownError(message: 'answered is null');
      }

      final queryParams = {
        'id_user': userId,
        'dateI': dataIni,
        'dateF': dataFim,
        'answered': answered,
      };

      final results = await _client.get(
        '/quizzes/ids',
        queryParameters: queryParams,
      );

      final mapFields = MapFields.load(results);

      final listMapIds = mapFields.getList<Map<String, dynamic>>(
        'quiz_vincule',
      );

      final idsQuizzes = listMapIds
          .map(
            (e) {
              final mapFields = MapFields.load(e);
              final idQuiz = mapFields.getString('id_quiz');
              return idQuiz;
            },
          )
          .toSet()
          .toList();

      if (idsQuizzes.isEmpty) {
        return [];
      }

      final dateQuiz = listMapIds
          .map(
            (e) {
              final mapFields = MapFields.load(e);
              final dateQuiz = mapFields.getDateTime('date');
              return dateQuiz;
            },
          )
          .toSet()
          .toList()
          .first;

      for (final id in idsQuizzes) {
        final response = await _client.get(
          '/user/quizzes',
          queryParameters: {
            'id_quiz': id,
          },
        );
        final mapFields = MapFields.load(response);
        final quizMap = mapFields.getList<Map<String, dynamic>>('quiz_header');
        final mapIdGroup = listMapIds.firstWhere(
          (element) {
            final mapFields = MapFields.load(element);
            final idQuiz = mapFields.getString('id_quiz');
            return idQuiz == id;
          },
        );

        final mapF = MapFields.load(mapIdGroup);
        final idGroup = mapF.getString('id_group');
        final List<QuizModel> quizzes = quizMap
            .map(
              (q) => QuizModel.fromMap(q)
                  .copyWith(idGroup: idGroup, date: dateQuiz),
            )
            .toList();
        listOfQuizzes.addAll(quizzes);
      }
    } on MapFieldsError {
      rethrow;
    } on InvalidIdClass {
      rethrow;
    } on ClientError {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return listOfQuizzes;
  }

  @override
  Future<QuizDefaultModel> getById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(QuizDefaultModel t) {
    throw UnimplementedError();
  }

  @override
  Future<bool> update(QuizDefaultModel t) {
    throw UnimplementedError();
  }

  Future<bool> insertAnswersGroup(
    List<NewAnswerGroupModel> answersGroup,
    String idUser,
    String idQuiz,
    DateTime date,
  ) async {
    try {
      final idGroup = answersGroup.first.idGroup;

      final listAnswers = answersGroup
          .map(
            (e) => e.toMap(),
          )
          .toList();

      if (listAnswers.isEmpty) {
        throw UnknownError(
          message:
              'Erro ao inserir respostas do grupo, lista de respostas esta vazia',
        );
      }

      final response = await _client.post(
        '/questions/answers/group',
        body: {
          'answers': listAnswers,
        },
      );

      final resultHasura = HelperHasura.returnResponseBool(
        response,
        'insert_answer_group',
        multipleAffectedRows: true,
      );

      if (!resultHasura) {
        throw UnknownError(
          message: 'Erro ao inserir respostas do grupo',
        );
      }

      final updateStatusQuiz = await updateQuizAnswered(idQuiz, idGroup, date);

      return updateStatusQuiz;
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateQuizAnswered(
      String idQuiz, String idGroup, DateTime date) async {
    try {
      final body = {
        'id_quiz': idQuiz,
        'id_group': idGroup,
        'date': date.toDateHasura(),
      };

      final response = await _client.put(
        '/quizzes/answered',
        body: body,
      );

      final result =
          HelperHasura.returnResponseBool(response, 'update_quiz_vincule');
      return result;
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QuizResult>> getAllQuizResults(String idQuiz) async {
    try {
      final response = await _client.get(
        '/quizzes/result',
        queryParameters: {
          'id_quiz': idQuiz,
        },
      );

      final mapFields = MapFields.load(response);

      final listResults =
          mapFields.getList<Map<String, dynamic>>('quiz_header');

      final listQuizResults = listResults
          .map(
            (result) => QuizResult.fromMap(result),
          )
          .toList();

      return listQuizResults;
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QuizResult>> getAllQuizResultsUser(
      String idQuiz, String idUser) async {
    try {
      final response = await _client.get(
        '/quizzes/result/user',
        queryParameters: {
          'id_quiz': idQuiz,
          'id_user': idUser,
        },
      );

      final mapFields = MapFields.load(response);

      final listResults =
          mapFields.getList<Map<String, dynamic>>('quiz_header');

      final listQuizResults = listResults
          .map(
            (result) => QuizResult.fromMap(result),
          )
          .toList();

      return listQuizResults;
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
