import 'package:api_tbl_tcc/core/interfaces/clients/http_client.dart';
import 'package:api_tbl_tcc/core/interfaces/generic_service/generic_service.dart';
import 'package:api_tbl_tcc/core/models/errors/arguments/invalid_argument_hasura.dart';
import 'package:api_tbl_tcc/core/models/quiz/quiz_default_model.dart';
import 'package:api_tbl_tcc/models/group/group_model.dart';
import 'package:api_tbl_tcc/models/quiz/new_quiz_model.dart';
import 'package:api_tbl_tcc/models/quiz/question/new_question_model.dart';
import 'package:api_tbl_tcc/utils/hasura/helper_extensions.dart';
import 'package:map_fields/map_fields.dart';

import '../../core/models/errors/client/client_error.dart';
import '../../core/models/errors/generic_error/generic_error.dart';
import '../../models/quiz/answer/answer_user_model.dart';
import '../../models/quiz/answer/new_answer_model.dart';
import '../../models/quiz/quiz_model.dart';
import '../../utils/hasura/helper_hasura.dart';

class QuizService implements GenericService<QuizDefaultModel> {
  final HttpClient _client;

  QuizService(this._client);

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<QuizDefaultModel>> get({
    String? idCompany,
  }) async {
    List<QuizDefaultModel> listOfQuizzes = [];
    try {
      if (idCompany == null) {
        throw InvalidIdCompany(
          message: 'É necessário informar o id da empresa',
        );
      }
      final queryParams = {
        'id_company': idCompany,
      };

      final result = await _client.get(
        '/quizzes',
        queryParameters: queryParams,
      );

      final map = MapFields.load(result);

      final listQuizzes = map.getList<Map<String, dynamic>>('quiz_header');

      final quizzes = listQuizzes.map((e) => QuizModel.fromMap(e)).toList();

      listOfQuizzes = quizzes;
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

  Future<List<QuizDefaultModel>> getUserOfStudent({
    String? idCompany,
    String? idUser,
    DateTime? from,
    DateTime? to,
  }) async {
    List<QuizDefaultModel> listOfQuizzes = [];
    try {
      if (idCompany == null) {
        throw InvalidIdCompany(
          message: 'É necessário informar o id da empresa',
        );
      }

      if (idUser == null) {
        throw InvalidIdClass(
          message: 'É necessário informar o id da turma',
        );
      }

      if (from == null) {
        throw UnknownError(message: 'É necessário informar a data de início');
      }

      if (to == null) {
        throw UnknownError(message: 'É necessário informar a data de fim');
      }

      final queryParams = {
        'id_company': idCompany,
        'id_user': idUser,
        'dataIni': from.toDateHasuraWithoutTime(),
        'dataFim': to.toDateHasuraWithoutTime(),
      };

      final result = await _client.get(
        '/quizzes/user',
        queryParameters: queryParams,
      );

      final map = MapFields.load(result);

      final listQuizzes = map.getList<Map<String, dynamic>>('quiz_header');

      final quizzes = listQuizzes.map((e) => QuizModel.fromMap(e)).toList();

      listOfQuizzes = quizzes;
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
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(QuizDefaultModel quiz) async {
    try {
      final quizMap = (quiz as NewQuizModel).toMap();

      final body = {
        'quiz': [
          quizMap,
        ],
      };

      var response = await _client.post(
        'quizzes',
        body: body,
      );

      final idQuiz = HelperHasura.returningHasura(
        response,
        keyMap: 'insert_quiz_header',
        keyValueSearch: 'id',
      );

      if (idQuiz.isEmpty) {
        throw InvalidArgumentHasura(
          message: 'Erro ao buscar código do quiz',
          key: 'insert_quiz_header.returning.id',
        );
      }

      final inserted = await _insertQuestionsQuiz(
        idQuiz,
        (quiz.questions as List<NewQuestionModel>),
      );

      if (!inserted) {
        throw InvalidArgumentHasura(
          message: 'Erro ao inserir o quiz',
          key: 'insert_quiz_question',
        );
      }

      return inserted;
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on InvalidArgumentHasura {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> insertQuizLinkedGroups(
    List<GroupModel> groups,
    String idQuiz,
    DateTime date,
  ) async {
    try {
      if (groups.isEmpty) {
        throw UnknownError(
          message:
              'Erro ao inserir os grupos vinculados ao questionário, lista de grupos esta vazia',
        );
      }

      final listGroups = groups.map((e) {
        return {
          'id_group': e.id,
          'id_quiz': idQuiz,
          'date': date.toDateHasura(),
        };
      }).toList();

      final response = await _client.post(
        '/quizzes/groups',
        body: {
          'groups': listGroups,
        },
      );

      return HelperHasura.returnResponseBool(response, 'insert_quiz_vincule');
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on InvalidArgumentHasura {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _insertQuestionsQuiz(
    String idQuiz,
    List<NewQuestionModel> questions,
  ) async {
    try {
      if (questions.isEmpty) {
        throw UnknownError(
          message:
              'Erro ao inserir questões do questionário, lista de questões esta vazia',
        );
      }

      List<bool> insertsSuccess = [];

      for (var question in questions) {
        final questionMap = question.copyWith(idQuiz: idQuiz).toMap();
        final response = await _client.post(
          '/quizzes/questions',
          body: {
            'question': questionMap,
          },
        );
        final idQuestions = HelperHasura.returningHasura(
          response,
          keyMap: 'insert_quiz_questions',
          keyValueSearch: 'id',
        );
        if (idQuestions.isEmpty) {
          throw InvalidArgumentHasura(
            message: 'Erro ao buscar código das questões',
            key: 'insert_quiz_questions.returning.id',
          );
        }

        final inserted = await _insertAnswer(
          idQuestions,
          (question.answers as List<NewAnswerModel>),
        );

        insertsSuccess.add(inserted);
      }

      if (insertsSuccess.contains(false)) {
        throw UnknownError(
          message: 'Erro ao inserir questões do questionário',
        );
      }

      return true;
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on InvalidArgumentHasura {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _insertAnswer(
    String idQuestion,
    List<NewAnswerModel> answers,
  ) async {
    try {
      final listAnswers = answers
          .map(
            (e) => e.copyWith(idQuestion: idQuestion).toMap(),
          )
          .toList();
      if (listAnswers.isEmpty) {
        throw UnknownError(
          message:
              'Erro ao inserir respostas do questionário, lista de respostas esta vazia',
        );
      }

      final response = await _client.post(
        '/quizzes/questions/answers',
        body: {
          'answers': listAnswers,
        },
      );

      return HelperHasura.returnResponseBool(
        response,
        'insert_answer_question',
        multipleAffectedRows: true,
      );
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on InvalidArgumentHasura {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> insertAnswersUser(List<AnswerUserModel> answersUser) async {
    final listAnswers = answersUser.map((e) => e.toMap()).toList();

    if (listAnswers.isEmpty) {
      throw UnknownError(
        message:
            'Erro ao inserir respostas do usuário, lista de respostas esta vazia',
      );
    }

    final response = await _client.post(
      '/questions/answers/users',
      body: {
        'answers': listAnswers,
      },
    );

    return HelperHasura.returnResponseBool(
      response,
      'insert_answer_user',
      multipleAffectedRows: true,
    );
  }

  @override
  Future<bool> update(QuizDefaultModel t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<bool> updateQuizAnswered(String idQuiz, String idGroup) async {
    try {
      final body = {
        'id_quiz': idQuiz,
        'id_group': idGroup,
      };

      final response = await _client.put(
        '/quizzes/answered',
        body: body,
      );

      final result =
          HelperHasura.returnResponseBool(response, 'update_quiz_group');
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
}
