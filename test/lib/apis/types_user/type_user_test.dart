import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import '../../../utils/pathServer.dart';

void main() {
  late HttpClient httpClient;

  setUp(() {
    httpClient = HttpClient();
  });

  group('Grupo de testes de casos de sucesso', () {
    test(
        'Deve retornar um status code 200 caso de sucesso na busca dos tipos de usuários',
        () async {
      final url = Uri.parse('$urlBase/types_user');

      final request = await httpClient.getUrl(url);

      final response = await request.close();

      expect(response.statusCode, 200);
    });

    test(
        'Deve retornar um status code 200 caso de sucesso na busca dos tipos de usuários',
        () async {
      final url = Uri.parse('$urlBase/types_user');

      final request = await httpClient.getUrl(url);

      final response = await request.close();

      final content = StringBuffer();

      await for (var data in response.transform(utf8.decoder)) {
        content.write(data);
      }

      final result = jsonDecode(content.toString());
      expect(result, isList);
    });
  });

  group('Grupo de testes de casos de erro', () {
    test(
        'Deve retornar um status code 500 caso de erro na busca dos tipos de usuários',
        () async {
      final url = Uri.parse('$urlBase/types_user');

      final request = await httpClient.getUrl(url);

      final response = await request.close();

      expect(response.statusCode, 500);
    });
  });
}
