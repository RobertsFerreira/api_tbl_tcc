import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class CustomServer {
  Future<void> initialize({
    required Handler handler,
    required String address,
    required int port,
  }) async {
    final server = await shelf_io.serve(handler, address, port);

    print('Servidor inicializado: -> http://${server.address}:${server.port}');

    await _terminateRequestFuture();

    await server.close(force: true);
  }

  Future<void> _terminateRequestFuture() {
    final completer = Completer<bool>.sync();

    // sigIntSub is copied below to avoid a race condition - ignoring this lint
    // ignore: cancel_subscriptions
    StreamSubscription? sigIntSub, sigTermSub;

    Future<void> signalHandler(ProcessSignal signal) async {
      print('Received signal $signal - closing');

      final subCopy = sigIntSub;
      if (subCopy != null) {
        sigIntSub = null;
        await subCopy.cancel();
        sigIntSub = null;
        if (sigTermSub != null) {
          await sigTermSub!.cancel();
          sigTermSub = null;
        }
        completer.complete(true);
      }
    }

    sigIntSub = ProcessSignal.sigint.watch().listen(signalHandler);

    // SIGTERM is not supported on Windows. Attempting to register a SIGTERM
    // handler raises an exception.
    if (!Platform.isWindows) {
      sigTermSub = ProcessSignal.sigterm.watch().listen(signalHandler);
    }

    return completer.future;
  }
}
