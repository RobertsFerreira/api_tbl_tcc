import 'dart:convert';

import 'package:api_tbl_tcc/models/user/user_model.dart';
import 'package:map_fields/map_fields.dart';

import '../../core/models/group/group_default.dart';

class GroupModel extends GroupDefault {
  final String id;
  final UserModel userLeader;

  GroupModel({
    required this.id,
    required super.idClass,
    required super.reference,
    required this.userLeader,
    required super.users,
  });

  factory GroupModel.fromMap(Map<String, dynamic> json) {
    final map = MapFields.load(json);
    final user = json['user'] ?? {};
    final userGroups = map.getList<Map<String, dynamic>>('users_groups', []);

    return GroupModel(
      id: map.getString('id', ''),
      idClass: map.getString('id_class', ''),
      reference: map.getString('reference', ''),
      userLeader: UserModel.fromMap(user),
      users: userGroups.map((e) {
        final user = e['user'] ?? {};
        return UserModel.fromMap(user);
      }).toList(),
    );
  }

  Map<String, dynamic> toUpdate() {
    return {
      'id': id,
      'id_class': idClass,
      'reference': reference,
      'id_user_leader': userLeader.id,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_class': idClass,
      'reference': reference,
      'user': userLeader.toMap(),
      'users_groups': users.map((e) => e.toMap()).toList(),
    };
  }

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
