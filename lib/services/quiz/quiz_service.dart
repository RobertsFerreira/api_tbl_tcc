import 'package:api_tbl_tcc/core/interfaces/clients/http_client.dart';
import 'package:api_tbl_tcc/core/interfaces/generic_service/generic_service.dart';
import 'package:api_tbl_tcc/core/models/errors/arguments/invalid_argument_hasura.dart';
import 'package:api_tbl_tcc/core/models/quiz/quiz_default_model.dart';
import 'package:api_tbl_tcc/models/quiz/new_quiz_model.dart';
import 'package:api_tbl_tcc/models/quiz/question/new_question_model.dart';
import 'package:map_fields/map_fields.dart';

import '../../core/models/errors/client/client_error.dart';
import '../../core/models/errors/generic_error/generic_error.dart';
import '../../models/quiz/answer/new_answer_model.dart';
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
    String? idClass,
  }) {
    // TODO: implement get
    throw UnimplementedError();
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

      var response = await _client.post(
        'quiz',
        body: quizMap,
      );

      final idQuiz = HelperHasura.getReturningHasura(
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
        final questionMap = question.toMap();
        final response = await _client.post(
          '/quiz/question',
          body: {
            'question': questionMap,
          },
        );
        final idQuestions = HelperHasura.getReturningHasura(
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
        '/quiz/question/answer',
        body: listAnswers,
      );

      return HelperHasura.returnResponseBool(response, 'insert_quiz_answers');
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

  @override
  Future<bool> update(QuizDefaultModel t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
