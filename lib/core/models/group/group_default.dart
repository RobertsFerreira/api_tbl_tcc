import '../../../models/user/user_model.dart';

class GroupDefault {
  final String idClass;
  final String reference;
  final List<UserModel> users;

  GroupDefault({
    required this.idClass,
    required this.reference,
    required this.users,
  });
}
