import 'dart:convert';

import 'package:api_tbl_tcc/core/interfaces/clients/http_client.dart';
import 'package:api_tbl_tcc/models/type_user/type_user_model.dart';
import 'package:api_tbl_tcc/models/user/new_user_model.dart';
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

  group('Conjuntos de teste para buscar todos os usuários', () {
    test('Deve retornar os usuários do sistema por empresa', () async {
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

  group('Conjuntos de teste para inserir um usuário', () {
    test(
        'Deve retornar o numero de registros afetados = 1  ao inserir um usuário',
        () async {
      final response = jsonDecode(responseInserterUser);
      when(
        () => client.post(any(), body: any(named: 'body')),
      ).thenAnswer((_) async => response);

      final result = await userService.insert(
        NewUserModel(
          name: 'Teste',
          cpf: '',
          birthDate: DateTime.now(),
          idCompany: '',
          typeUser: '',
        ),
      );

      expect(result, isA<bool>());
      expect(result, true);
    });
  });

  group('Conjuntos de teste para fazer update de um usuário', () {
    test(
        'Deve retornar o numero de registros afetados = 1 ao atualizar um usuário',
        () async {
      final response = jsonDecode(responseUpdateUser);
      when(
        () => client.put(any(), body: any(named: 'body')),
      ).thenAnswer((_) async => response);

      final result = await userService.update(
        UserModel(
          id: '',
          name: 'Teste',
          cpf: '',
          birthDate: DateTime.now(),
          idCompany: '',
          typeUser: TypeUserModel(id: '', name: ''),
          active: false,
        ),
      );

      expect(result, isA<bool>());
      expect(result, true);
    });
  });

  group('Conjuntos de teste para fazer delete de um usuário', () {
    test(
        'Deve retornar o numero de registros afetados = 1 ao deletar um usuário',
        () async {
      final response = jsonDecode(responseUpdateUser);
      when(
        () => client.delete(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => response);

      final result = await userService.delete('');

      expect(result, isA<bool>());
      expect(result, true);
    });
  });
}
