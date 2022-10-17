import 'dart:convert';

import 'package:map_fields/map_fields.dart';

import '../../core/models/group/group_default.dart';
import '../user/user_model.dart';

class NewGroupModel extends GroupDefault {
  final String idUserLeader;
  NewGroupModel({
    required super.idClass,
    required super.reference,
    required this.idUserLeader,
    required super.users,
  });

  factory NewGroupModel.fromMap(Map<String, dynamic> json) {
    final map = MapFields.load(json);
    final userGroups = map.getList<Map<String, dynamic>>('users_groups', []);

    return NewGroupModel(
      idClass: map.getString('id_class', ''),
      reference: map.getString('reference', ''),
      idUserLeader: map.getString('id_user_leader', ''),
      users: userGroups.map((e) => UserModel.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_class': idClass,
      'reference': reference,
      'id_user_leader': idUserLeader,
    };
  }

  factory NewGroupModel.fromJson(String source) =>
      NewGroupModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
