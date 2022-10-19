import 'package:api_tbl_tcc/core/interfaces/clients/http_client.dart';
import 'package:api_tbl_tcc/core/interfaces/generic_service/generic_service.dart';
import 'package:api_tbl_tcc/core/models/errors/arguments/invalid_argument_hasura.dart';
import 'package:api_tbl_tcc/models/quiz/new_quiz_model.dart';
import 'package:api_tbl_tcc/models/quiz/quiz_default_model.dart';
import 'package:map_fields/map_fields.dart';

import '../../core/models/errors/client/client_error.dart';
import '../../core/models/errors/generic_error/generic_error.dart';

class QuizHeaderService implements GenericService<QuizDefaultModel> {
  final HttpClient _client;

  QuizHeaderService(this._client);

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

      final mapFields = MapFields.load(response);

      final quizResp = mapFields.getMap<String, dynamic>('insert_quiz', {});

      if (quizResp.isEmpty) {
        throw InvalidArgumentHasura(
          message: 'erro ao inserir cabeçalho do questionário',
        );
      }

      var map = MapFields.load(quizResp);

      final returnList = map.getList<Map<String, dynamic>>('returning', []);

      if (returnList.isEmpty || returnList.length > 1) {
        throw InvalidArgumentHasura(message: 'Erro ao inserir grupo');
      }

      map = MapFields.load(returnList.first);

      final idQuiz = map.getString('id', '');

      if (idQuiz.isEmpty) {
        throw InvalidArgumentHasura(
          message: 'Erro ao buscar código do quiz',
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

  @override
  Future<bool> update(QuizDefaultModel t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
