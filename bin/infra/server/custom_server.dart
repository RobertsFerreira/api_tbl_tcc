import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class CustomServer {
  Future<void> initialize(Handler handler) async {
    final address = InternetAddress.anyIPv4.address;
    final int port = 8000;

    await shelf_io.serve(handler, address, port);
    print('Servidor inicializado: -> http://$address:$port');
  }
}
