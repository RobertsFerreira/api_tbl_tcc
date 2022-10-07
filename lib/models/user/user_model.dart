import 'dart:convert';

import 'package:api_tbl_tcc/core/models/user/user_default.dart';
import 'package:map_fields/map_fields.dart';

import '../type_user/type_user_model.dart';

class UserModel extends UserDefault {
  final String id;

  UserModel({
    required this.id,
    required super.name,
    required super.cpf,
    required super.birthDate,
    required super.idCompany,
    required super.typeUser,
    required super.ativo,
  });
  factory UserModel.fromMap(Map<String, dynamic> json) {
    final map = MapFields.load(json);
    final type = (json['type_user'] ?? {});
    return UserModel(
      id: map.getString('id', ''),
      idCompany: map.getString('id_company', ''),
      name: map.getString('name', ''),
      cpf: map.getString('cpf', ''),
      birthDate: map.getDateTime('birth_date', DateTime.now()),
      typeUser: TypeUserModel.fromMap(type),
      ativo: map.getBool('situacao', true),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'birth_date': birthDate,
      'id_company': idCompany,
      'id_type_user': typeUser.id,
      'situacao': ativo,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
