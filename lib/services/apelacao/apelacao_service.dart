import 'package:api_tbl_tcc/models/apelacao/apelacao_model.dart';
import 'package:api_tbl_tcc/utils/hasura/helper_extensions.dart';
import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/clients/http_client.dart';
import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/apelacao/apelacao_default.dart';
import '../../core/models/errors/client/client_error.dart';
import '../../core/models/errors/generic_error/generic_error.dart';
import '../../models/apelacao/new_apelacao_model.dart';
import '../../utils/hasura/helper_hasura.dart';

class ApelacaoService implements GenericService<ApelacaoDefault> {
  final HttpClient _client;

  ApelacaoService(this._client);

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ApelacaoDefault>> get({
    String? idCompany,
    DateTime? date,
    String? idQuiz,
  }) async {
    List<ApelacaoModel> apelacoes = [];
    try {
      if (date == null) {
        throw UnknownError(
          message: 'Data não pode ser nula',
        );
      }

      if (idQuiz == null) {
        throw UnknownError(
          message: 'Id do quiz não pode ser nulo',
        );
      }

      final params = {
        'data': date.toDateHasura(),
        'id_quiz': idQuiz,
      };

      final result = await _client.get(
        'apelacao',
        queryParameters: params,
      );

      final map = MapFields.load(result);

      final listApelacao = map.getList<Map<String, dynamic>>('apelacao');

      final apelacoesModels = listApelacao
          .map((apelacao) => ApelacaoModel.fromMap(apelacao))
          .toList();

      apelacoes = apelacoesModels;
    } on MapFieldsError {
      rethrow;
    } on ClientError {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return (apelacoes as List<ApelacaoDefault>);
  }

  Future<List<ApelacaoModel>> getApelacao({
    DateTime? date,
    String? idQuiz,
  }) async {
    List<ApelacaoModel> apelacoes = [];
    try {
      if (date == null) {
        throw UnknownError(
          message: 'Data não pode ser nula',
        );
      }

      if (idQuiz == null) {
        throw UnknownError(
          message: 'Id do quiz não pode ser nulo',
        );
      }

      final params = {
        'data': date.toDateHasura(),
        'id_quiz': idQuiz,
      };

      final result = await _client.get(
        'apelacao',
        queryParameters: params,
      );

      final map = MapFields.load(result);

      final listApelacao = map.getList<Map<String, dynamic>>('apelacao');

      final apelacoesModels = listApelacao
          .map((apelacao) => ApelacaoModel.fromMap(apelacao))
          .toList();

      apelacoes = apelacoesModels;
    } on MapFieldsError {
      rethrow;
    } on ClientError {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return apelacoes;
  }

  @override
  Future<ApelacaoDefault> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(ApelacaoDefault apelacao) async {
    try {
      final apelacaoMap = (apelacao as NewApelacaoModel).toMap();
      final listApelacao = [apelacaoMap];
      final response = await _client.post(
        'apelacao',
        body: {
          'apelacao': listApelacao,
        },
      );

      return HelperHasura.returnResponseBool(response, 'insert_apelacao');
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

  @override
  Future<bool> update(ApelacaoDefault t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
