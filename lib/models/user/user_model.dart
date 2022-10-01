import 'package:map_fields/map_fields.dart';

import '../type_user/type_user_model.dart';

class UserModel {
  final String id;
  final String idCompany;
  final String name;
  final String cpf;
  final TypeUserModel typeUser;

  UserModel({
    required this.id,
    required this.idCompany,
    required this.name,
    required this.cpf,
    required this.typeUser,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final map = MapFields.load(json);
    final type = (json['types_user'] ?? {});
    return UserModel(
      id: map.getString('id', ''),
      idCompany: map.getString('id_company', ''),
      name: map.getString('name', ''),
      cpf: map.getString('cpf', ''),
      typeUser: TypeUserModel.fromMap(type),
    );
  }
}
