import 'dart:convert';

import 'package:api_tbl_tcc/core/interfaces/clients/http_client.dart';
import 'package:api_tbl_tcc/models/type_user/type_user_model.dart';
import 'package:api_tbl_tcc/services/types_user/types_user_service.dart';
import 'package:map_fields/map_fields.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../utils/responses/types_users/type_user_response.dart';

class DioMock extends Mock implements HttpClient {}

void main() {
  late HttpClient client;
  late TypesUserService typesUserService;

  setUp(() {
    client = DioMock();
    typesUserService = TypesUserService(client);
  });

  group('Conjuntos de teste para caso de sucesso', () {
    test('Deve retornar os tipos de usuários do sistema', () async {
      final response = jsonDecode(getAllTypes);
      when(
        () => client.get(any()),
      ).thenAnswer(
        (_) async => response,
      );

      final result = await typesUserService.getAll();

      expect(result, isA<List<TypeUserModel>>());
    });
  });
  group('Conjuntos de teste para caso de erro ', () {
    test('Deve retornar um erro do tipo InvalidMapStringObjectError', () async {
      when(
        () => client.get(any()),
      ).thenThrow(InvalidMapStringObjectError());

      try {
        await typesUserService.getAll();
      } catch (e) {
        expect(e, isA<InvalidMapStringObjectError>());
      }
    });

    test('Deve retornar um erro do tipo MapFieldsErrorMissingRequiredField',
        () async {
      when(
        () => client.get(any()),
      ).thenThrow(MapFieldsErrorMissingRequiredField('teste'));

      try {
        await typesUserService.getAll();
      } catch (e) {
        expect(e, isA<MapFieldsErrorMissingRequiredField>());
      }
    });
    test('Deve retornar um erro do tipo UnknownErrorMapFieldsError', () async {
      when(
        () => client.get(any()),
      ).thenThrow(UnknownErrorMapFieldsError('teste', Exception()));

      try {
        await typesUserService.getAll();
      } catch (e) {
        expect(e, isA<UnknownErrorMapFieldsError>());
      }
    });
    test('Deve retornar um erro do tipo ConvertMapStringFieldError', () async {
      when(
        () => client.get(any()),
      ).thenThrow(ConvertMapStringFieldError('teste', 'teste'));

      try {
        await typesUserService.getAll();
      } catch (e) {
        expect(e, isA<ConvertMapStringFieldError>());
      }
    });
  });
}
