import 'dart:convert';

import 'package:map_fields/map_fields.dart';

import '../../core/models/group/group_default.dart';

class GroupModel extends GroupDefault {
  final String id;

  GroupModel({
    required this.id,
    required super.idClass,
    required super.reference,
    required super.idUserLeader,
  });

  factory GroupModel.fromMap(Map<String, dynamic> json) {
    final map = MapFields.load(json);
    return GroupModel(
      id: map.getString('id', ''),
      idClass: map.getString('id_class', ''),
      reference: map.getString('reference', ''),
      idUserLeader: map.getString('id_user_leader', ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_class': idClass,
      'reference': reference,
      'id_user_leader': idUserLeader,
    };
  }

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
