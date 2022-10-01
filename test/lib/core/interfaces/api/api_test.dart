import 'dart:async';

import 'package:api_tbl_tcc/core/interfaces/api/api.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/test.dart';

class ApiMock extends Api {
  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    return Router();
  }
}

void main() {
  test('Deve retornar um handle', () {
    final api = ApiMock();
    final handler = api.createHandler(
      router: api.getHandler(),
      middlewares: [],
    );
    expect(handler, isNotNull);
    expect(handler, isA<FutureOr<Response> Function(Request)>());
  });

  test('Deve retornar uma lista de middlewares na pipeline', () {
    final api = ApiMock();
    final handler = api.createHandler(
      router: api.getHandler(),
      middlewares: [
        logRequests(),
      ],
    );
    expect(handler, isNotNull);
    expect(handler, isA<FutureOr<Response> Function(Request)>());
  });
}
