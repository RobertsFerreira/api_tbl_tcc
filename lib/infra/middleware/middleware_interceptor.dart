import 'package:shelf/shelf.dart';

class MiddlewareInterceptor {
  Middleware get middleware {
    return createMiddleware(
      responseHandler: (Response response) => response.change(
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }
}
