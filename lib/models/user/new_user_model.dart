import 'dart:convert';

import 'package:api_tbl_tcc/core/models/user/user_default.dart';
import 'package:map_fields/map_fields.dart';

import '../type_user/type_user_model.dart';

class NewUserModel extends UserDefault {
  NewUserModel({
    required super.name,
    required super.cpf,
    required super.birthDate,
    required super.idCompany,
    required super.typeUser,
  });

  factory NewUserModel.fromMap(Map<String, dynamic> map) {
    final maps = MapFields.load(map);
    final typeUser = maps.getMap<String, dynamic>("typeUser");
    return NewUserModel(
      idCompany: maps.getString('id_company'),
      name: maps.getString('name'),
      cpf: maps.getString('cpf'),
      birthDate: maps.getDateTime('birth_date'),
      typeUser: TypeUserModel.fromMap(typeUser),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cpf': cpf,
      'birth_date': birthDate.toBirthDate(),
      'id_company': idCompany,
      'id_type_user': typeUser.id,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory NewUserModel.fromJson(String source) =>
      NewUserModel.fromMap(jsonDecode(source));
}
