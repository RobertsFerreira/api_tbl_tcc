import 'package:map_fields/map_fields.dart';

import '../../core/models/errors/arguments/invalid_argument_hasura.dart';
import '../../core/models/errors/generic_error/generic_error.dart';

class HelperHasura {
  static bool returnResponseBool(
    dynamic response,
    String key, {
    bool multipleAffectedRows = false,
  }) {
    final data = response['error'];
    if (data != null) {
      final messageError = _returnErrorHasura(response);
      throw InvalidArgumentHasura(message: messageError);
    }
    final mapResponse = MapFields.load(response[key] ?? {});
    final result = mapResponse.getInt('affected_rows', -1);
    if (result == -1) {
      throw MapFieldsErrorMissingRequiredField('affected_rows');
    } else if (result == 1 && !multipleAffectedRows) {
      return true;
    }
    if (result == 0) {
      return false;
    } else if (result >= 1 && multipleAffectedRows) {
      return true;
    } else {
      String message = '';
      if (key.contains('insert')) {
        message = 'Erro ao inserir';
      } else if (key.contains('update')) {
        message = 'Erro ao atualizar';
      } else if (key.contains('delete')) {
        message = 'Erro ao deletar';
      }
      throw UnknownError(
        message: '$message usuário, houve mais de um usuário deletado: $result',
      );
    }
  }

  static String _returnErrorHasura(dynamic response) {
    final mapErrors = MapFields.load(response);
    final listErros = mapErrors.getList<Map<String, dynamic>>("errors");
    String messageError = "";
    for (var error in listErros) {
      final mapError = MapFields.load(error);
      final message = mapError.getString("message");
      final index = listErros.indexOf(error);
      messageError += "Erro $index: $message\n";
    }
    return messageError;
  }
}
