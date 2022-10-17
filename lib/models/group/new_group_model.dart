import 'dart:convert';

import 'package:map_fields/map_fields.dart';

import '../../core/models/group/group_default.dart';

class NewGroupModel extends GroupDefault {
  final String idUserLeader;
  NewGroupModel({
    required super.idClass,
    required super.reference,
    required this.idUserLeader,
  });

  factory NewGroupModel.fromMap(Map<String, dynamic> json) {
    final map = MapFields.load(json);
    return NewGroupModel(
      idClass: map.getString('id_class', ''),
      reference: map.getString('reference', ''),
      idUserLeader: map.getString('id_user_leader', ''),
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
