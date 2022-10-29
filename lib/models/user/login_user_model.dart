import 'dart:convert';

import 'package:api_tbl_tcc/core/models/user/user_default.dart';
import 'package:map_fields/map_fields.dart';

import '../type_user/type_user_model.dart';

class LoginUserModel extends UserDefault {
  final String password;
  final String id;

  LoginUserModel({
    required this.id,
    required super.name,
    required super.cpf,
    required super.birthDate,
    required super.idCompany,
    required super.typeUser,
    required this.password,
  });

  factory LoginUserModel.fromMap(Map<String, dynamic> map) {
    final maps = MapFields.load(map);
    final typeUser = maps.getMap<String, dynamic>("typeUser");
    return LoginUserModel(
      id: maps.getString('id'),
      name: maps.getString('name'),
      cpf: maps.getString('cpf'),
      birthDate: maps.getDateTime('birth_date'),
      idCompany: maps.getString('id_company'),
      typeUser: TypeUserModel.fromMap(typeUser),
      password: maps.getString('password'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'birth_date': birthDate.toBirthDate(),
      'id_company': idCompany,
      'id_type_user': typeUser.toMap(),
    };
  }

  toJson() => jsonEncode(toMap());

  factory LoginUserModel.fromJson(String source) =>
      LoginUserModel.fromMap(jsonDecode(source));
}
