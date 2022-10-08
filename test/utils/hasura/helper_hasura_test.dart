import 'dart:convert';

import 'package:api_tbl_tcc/core/models/errors/arguments/invalid_argument_hasura.dart';
import 'package:api_tbl_tcc/core/models/errors/generic_error/generic_error.dart';
import 'package:api_tbl_tcc/utils/hasura/helper_hasura.dart';
import 'package:map_fields/map_fields.dart';
import 'package:test/test.dart';

import '../responses/users/users_response.dart';

void main() {
  group('Grupo de testes de erro no retorno do Hasura', () {
    test('Deve retornar um erro por ter sido passado um argumento inválido',
        () async {
      try {
        final response = jsonDecode(responseInserterUserError);
        HelperHasura.returnResponseBool(response, '');
      } catch (e) {
        expect(e, isA<InvalidArgumentHasura>());
      }
    });

    test(
        'Deve retornar um erro por a ter um erro no campo do retorno do hasura',
        () async {
      try {
        final response = jsonDecode(
          responseInserterUser.replaceAll('affected_rows', 'affected_row'),
        );
        HelperHasura.returnResponseBool(response, 'insert_user');
      } catch (e) {
        expect(e, isA<MapFieldsErrorMissingRequiredField>());
      }
    });

    test('Deve retornar um erro por ter sido afetado mais de 1', () async {
      try {
        final response = jsonDecode(
          responseInserterUser.replaceAll('1', '2'),
        );
        HelperHasura.returnResponseBool(response, 'insert_user');
      } catch (e) {
        expect(e, isA<UnknownError>());
      }
    });
  });

  group('Grupo de testes de sucesso no retorno do Hasura', () {
    test('Deve retornar true por ter sido afetado mais de 1', () async {
      final response = jsonDecode(
        responseInserterUser.replaceAll('1', '2'),
      );
      final result = HelperHasura.returnResponseBool(
        response,
        'insert_user',
        multipleAffectedRows: true,
      );
      expect(result, isA<bool>());
      expect(result, true);
    });

    test('Deve retornar true por ter sido afetado 1 row', () async {
      final response = jsonDecode(responseInserterUser);
      final result = HelperHasura.returnResponseBool(response, 'insert_user');
      expect(result, isA<bool>());
      expect(result, true);
    });
  });
}
