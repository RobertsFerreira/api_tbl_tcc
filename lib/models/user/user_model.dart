import 'dart:convert';

import 'package:api_tbl_tcc/core/models/user/user_default.dart';
import 'package:map_fields/map_fields.dart';

import '../type_user/type_user_model.dart';

class UserModel extends UserDefault {
  final String id;
  final bool active;

  UserModel({
    required this.id,
    required super.name,
    required super.cpf,
    required super.birthDate,
    required super.idCompany,
    required super.typeUser,
    required this.active,
  });
  factory UserModel.fromMap(Map<String, dynamic> json) {
    final map = MapFields.load(json);
    final type = map.getMap<String, dynamic>('types_user');
    return UserModel(
      id: map.getString('id'),
      name: map.getString('name'),
      cpf: map.getString('cpf'),
      birthDate: map.getDateTime('birth_date'),
      idCompany: map.getString('id_company'),
      typeUser: TypeUserModel.fromMap(type),
      active: map.getBool('active'),
    );
  }

  Map<String, dynamic> toUpdate() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'birth_date': birthDate.toBirthDate(),
      'id_company': idCompany,
      'id_type_user': typeUser.id,
      'active': active,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'birth_date': birthDate.toBirthDate(),
      'id_company': idCompany,
      'types_user': typeUser.toMap(),
      'active': active,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source));
}
