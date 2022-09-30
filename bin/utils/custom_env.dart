import 'dart:io';

import 'parses/custom_parses.dart';

class CustomEnv {
  static Map<String, String> _map = {};

  static String _file = '';

  CustomEnv._();

  factory CustomEnv.fromFile(String file) {
    _file = file;
    return CustomEnv._();
  }

  static get<T>({required String key}) {
    if (_map.isEmpty) _load();
    return _map[key]!.toParse(T);
  }

  static void _load() {
    List<String> linhas = (_readFile()).split('\n');

    _map = {
      for (var linha in linhas)
        linha.split('=')[0]:
            linha.split('=')[1].replaceAll(String.fromCharCode(13), ''),
    };
  }

  static String _readFile() {
    return File(_file).readAsStringSync();
  }
}
