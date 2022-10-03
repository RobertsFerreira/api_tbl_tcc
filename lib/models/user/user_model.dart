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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_company': idCompany,
      'name': name,
      'cpf': cpf,
      'birth_date': birthDate,
      'id_type_user': typeUser.id,
    };
  }
}
