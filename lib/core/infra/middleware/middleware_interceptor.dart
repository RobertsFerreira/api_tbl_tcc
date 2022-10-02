import 'dart:convert';

import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';

class MiddlewareInterceptor {
  Middleware get middleware {
    return createMiddleware(
      errorHandler: (e, s) {
        if (e is MapFieldsError) {
          return Response.internalServerError(
            body: jsonEncode({
              'erro': e.toString(),
              'message': 'Erro no processamento dos campos do json',
              'stacktrace': s.toString(),
            }),
          );
        } else {
          return Response.internalServerError(
            body: jsonEncode({
              'erro': e.toString(),
              'message': 'Erro interno desconhecido no servidor',
              'stacktrace': s.toString(),
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
