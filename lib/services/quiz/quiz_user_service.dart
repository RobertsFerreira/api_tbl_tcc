import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/clients/http_client.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/errors/client/client_error.dart';
import '../../core/models/errors/generic_error/generic_error.dart';
import '../../core/models/quiz/quiz_default_model.dart';
import '../../models/quiz/quiz_model.dart';

class QuizUserService implements GenericService<QuizDefaultModel> {
  final HttpClient _client;

  QuizUserService(this._client);

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
              (q) => QuizModel.fromMap(q).copyWith(idGroup: idGroup),
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
}
