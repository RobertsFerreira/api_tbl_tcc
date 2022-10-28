class UserDefault {
  final String name;
  final String cpf;
  final DateTime birthDate;
  final String idCompany;

  UserDefault({
    required this.name,
    required this.cpf,
    required this.birthDate,
    required this.idCompany,
  });
}

extension ToBirthDate on DateTime {
  String toBirthDate() {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}
