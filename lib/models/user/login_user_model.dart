import 'dart:convert';

import 'package:map_fields/map_fields.dart';

class LoginUserModel {
  final String password;
  final String cpf;

  LoginUserModel({
    required this.cpf,
    required this.password,
  });

  factory LoginUserModel.fromMap(Map<String, dynamic> map) {
    final maps = MapFields.load(map);
    return LoginUserModel(
      cpf: maps.getString('cpf'),
      password: maps.getString('password'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cpf': cpf,
      'password': password,
    };
  }

  factory LoginUserModel.fromJson(String source) =>
      LoginUserModel.fromMap(Map<String, dynamic>.from(jsonDecode(source)));
}
