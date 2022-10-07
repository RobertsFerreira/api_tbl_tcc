import 'package:map_fields/map_fields.dart';

class HelperHasura {
  static String returnErrorHasura(dynamic response) {
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
