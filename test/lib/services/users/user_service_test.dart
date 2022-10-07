import 'dart:convert';

import 'package:api_tbl_tcc/core/interfaces/clients/http_client.dart';
import 'package:api_tbl_tcc/core/models/errors/arguments/invalid_argument_hasura.dart';
import 'package:api_tbl_tcc/core/models/errors/generic_error/generic_error.dart';
import 'package:api_tbl_tcc/models/type_user/type_user_model.dart';
import 'package:api_tbl_tcc/models/user/new_user_model.dart';
import 'package:api_tbl_tcc/models/user/user_model.dart';
import 'package:api_tbl_tcc/services/user/user_service.dart';
import 'package:map_fields/map_fields.dart';
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
    test('Deve retornar o numero de registros afetados = 1', () async {
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
          typeUser: TypeUserModel(id: '', name: ''),
          ativo: false,
        ),
      );

      expect(result, isA<bool>());
      expect(result, true);
    });

    test('Deve retornar um erro por ter sido passado um argumento inválido',
        () async {
      try {
        final response = jsonDecode(responseInserterUserError);
        when(
          () => client.post(any(), body: any(named: 'body')),
        ).thenAnswer((_) async => response);

        await userService.insert(
          NewUserModel(
            name: 'Teste',
            cpf: '',
            birthDate: DateTime.now(),
            idCompany: '',
            typeUser: TypeUserModel(id: '', name: ''),
            ativo: false,
          ),
        );
      } catch (e) {
        expect(e, isA<InvalidArgumentHasura>());
      }
    });

    test('Deve retornar um erro por a um erro no campo do retorno do hasura',
        () async {
      try {
        final response = jsonDecode(
            responseInserterUser.replaceAll('affected_rows', 'affected_row'));
        when(
          () => client.post(any(), body: any(named: 'body')),
        ).thenAnswer((_) async => response);

        await userService.insert(
          NewUserModel(
            name: 'Teste',
            cpf: '',
            birthDate: DateTime.now(),
            idCompany: '',
            typeUser: TypeUserModel(id: '', name: ''),
            ativo: false,
          ),
        );
      } catch (e) {
        expect(e, isA<MapFieldsErrorMissingRequiredField>());
      }
    });

    test('Deve retornar um erro por ter sido afetado mais de 1 ', () async {
      try {
        final response = jsonDecode(
          responseInserterUser.replaceAll('1', '2'),
        );
        when(
          () => client.post(any(), body: any(named: 'body')),
        ).thenAnswer((_) async => response);

        await userService.insert(
          NewUserModel(
            name: 'Teste',
            cpf: '',
            birthDate: DateTime.now(),
            idCompany: '',
            typeUser: TypeUserModel(id: '', name: ''),
            ativo: false,
          ),
        );
      } catch (e) {
        expect(e, isA<UnknownError>());
      }
    });
  });
}
