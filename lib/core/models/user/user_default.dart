import '../../../models/type_user/type_user_model.dart';

class UserDefault {
  final String name;
  final String cpf;
  final DateTime birthDate;
  final String idCompany;
  final TypeUserModel typeUser;

  UserDefault({
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.idCompany,
    required this.typeUser,
  });
}
