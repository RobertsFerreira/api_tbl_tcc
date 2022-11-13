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
  Future<List<ApelacaoDefault>> get({String? idCompany}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<ApelacaoDefault> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<bool> insert(ApelacaoDefault apelacao) async {
    try {
      final result = await _client.get(
        '/user/quiz/id',
        queryParameters: {
          'id_quiz': apelacao.idQuiz,
          'id_user': apelacao.idUser,
        },
      );

      final resultMap = MapFields.load(result);

      final mapReturn = resultMap.getList<Map<String, dynamic>>('quiz_header');

      if (mapReturn.length > 1) {
        throw UnknownError(message: 'Mais de 1 dado retornado');
      }

      final mapFields = MapFields.load(mapReturn.first);

      final quizGroupMap =
          mapFields.getList<Map<String, dynamic>>('quiz_groups');

      if (quizGroupMap.length > 1) {
        throw UnknownError(message: 'Mais de 1 id retornado');
      }

      final mapGroups = MapFields.load(quizGroupMap.first);

      final mapGroup = mapGroups.getMap<String, dynamic>('group');

      final mapFieldsGroup = MapFields.load(mapGroup);

      final idGroup = mapFieldsGroup.getString('id');

      final apelacaoMap =
          (apelacao as NewApelacaoModel).copyWith(idGroup: idGroup).toMap();
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
