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
  });

  factory GroupModel.fromMap(Map<String, dynamic> json) {
    final map = MapFields.load(json);
    final user = json['user'] ?? {};
    return GroupModel(
      id: map.getString('id', ''),
      idClass: map.getString('id_class', ''),
      reference: map.getString('reference', ''),
      userLeader: UserModel.fromMap(user),
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
      'id_class': idClass,
      'reference': reference,
      'user': userLeader.toMap(),
    };
  }

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
