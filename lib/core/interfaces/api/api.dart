import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares});

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
  }) {
    middlewares ??= [];

    Pipeline pipeline = Pipeline();

    for (final middleware in middlewares) {
      pipeline = pipeline.addMiddleware(middleware);
    }
    return pipeline.addHandler(router);
  }
}
