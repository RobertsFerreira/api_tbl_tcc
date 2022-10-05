import 'dart:convert';

import 'package:api_tbl_tcc/core/models/user/user_default.dart';

class NewUserModel extends UserDefault {
  NewUserModel({
    required super.name,
    required super.cpf,
    required super.birthDate,
    required super.idCompany,
    required super.typeUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cpf': cpf,
      'birth_date': birthDate,
      'id_company': idCompany,
      'id_type_user': typeUser.id,
    };
  }

  String toJson() => jsonEncode(toMap());
}
