import 'dart:convert';

import 'package:api_tbl_tcc/core/models/errors/arguments/invalid_argument_hasura.dart';
import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';

import '../../models/errors/client/client_error.dart';

class MiddlewareInterceptor {
  static Middleware get middleware {
    return createMiddleware(
      errorHandler: (e, s) {
        if (e is MapFieldsError) {
          return Response.internalServerError(
            body: jsonEncode({
              'erro': e.toString(),
              'message': 'Erro no processamento dos campos do json',
              'stacktrace': s.toString(),
              'type': e.runtimeType.toString(),
            }),
          );
        } else if (e is ClientError) {
          return Response.internalServerError(
            body: jsonEncode({
              'erro': e.message,
              'message': 'Status code: ${e.statusCode} - Method: ${e.method}',
              'stacktrace': s.toString(),
              'type': e.runtimeType.toString(),
            }),
          );
        } else if (e is InvalidArgumentHasura) {
          return Response.internalServerError(
            body: jsonEncode({
              'erro': e.message,
              'message':
                  "Erro no processamento do campo '${e.key}' no retorno do hasura",
              'stacktrace': s.toString(),
              'type': e.runtimeType.toString(),
            }),
          );
        } else {
          return Response.internalServerError(
            body: jsonEncode({
              'erro': e.toString(),
              'message': 'Erro interno desconhecido no servidor',
              'stacktrace': s.toString(),
              'type': e.runtimeType.toString(),
            }),
          );
        }
      },
      responseHandler: (Response response) => response.change(
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
}
