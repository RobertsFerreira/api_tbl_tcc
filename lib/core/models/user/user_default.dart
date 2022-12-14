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

extension ToBirthDate on DateTime {
  String toBirthDate() {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}
