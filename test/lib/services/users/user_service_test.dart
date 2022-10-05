import 'dart:convert';

import 'package:api_tbl_tcc/core/interfaces/clients/http_client.dart';
import 'package:api_tbl_tcc/models/user/user_model.dart';
import 'package:api_tbl_tcc/services/user/user_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../utils/responses/users/users_response.dart';

class DioMock extends Mock implements HttpClient {}

void main() {
  late HttpClient client;
  late UserService userService;

  setUp(() {
    client = DioMock();
    userService = UserService(client);
  });

  group('Conjuntos de teste para caso de sucesso', () {
    test('Deve retornar os tipos de usuários do sistema', () async {
      final response = jsonDecode(userForCompanyResponse);
      when(
        () => client.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => response,
      );

      final result = await userService.get(idCompany: '');

      expect(result, isA<List<UserModel>>());
    });
  });
}
