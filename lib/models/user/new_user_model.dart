import 'dart:convert';

import 'package:api_tbl_tcc/core/models/user/user_default.dart';
import 'package:map_fields/map_fields.dart';

class NewUserModel extends UserDefault {
  final String typeUser;
  NewUserModel({
    required super.name,
    required super.cpf,
    required super.birthDate,
    required super.idCompany,
    required this.typeUser,
  });

  factory NewUserModel.fromMap(Map<String, dynamic> map) {
    final maps = MapFields.load(map);
    return NewUserModel(
      idCompany: maps.getString('id_company', ''),
      name: maps.getString('name', ''),
      cpf: maps.getString('cpf', ''),
      birthDate: maps.getDateTime('birth_date', DateTime.now()),
      typeUser: maps.getString('id_type_user', ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cpf': cpf,
      'birth_date': birthDate.toBirthDate().toString(),
      'id_company': idCompany,
      'id_type_user': typeUser,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory NewUserModel.fromJson(String source) =>
      NewUserModel.fromMap(jsonDecode(source));
}
