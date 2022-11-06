import 'dart:convert';

import 'package:api_tbl_tcc/utils/hasura/helper_extensions.dart';
import 'package:map_fields/map_fields.dart';

class VinculoQuiz {
  final String title;
  final DateTime date;
  final List<CustomGroup> groups;

  VinculoQuiz({
    required this.title,
    required this.date,
    required this.groups,
  });

  factory VinculoQuiz.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);

    final quizHeader = mapFields.getMap<String, dynamic>('quiz_header');
    final quizHeaderFields = MapFields.load(quizHeader);

    final groupMap =
        quizHeaderFields.getList<Map<String, dynamic>>('quiz_groups');

    final groups = groupMap.map((e) => CustomGroup.fromMap(e)).toList();

    return VinculoQuiz(
      title: quizHeaderFields.getString('title'),
      date: mapFields.getDateTime('date'),
      groups: groups,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date.toDateHasuraWithoutTime(),
      'groups': groups.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => jsonEncode(toMap());
}

class CustomGroup {
  final String reference;
  final String nameLeader;

  CustomGroup({
    required this.reference,
    required this.nameLeader,
  });

  factory CustomGroup.fromMap(Map<String, dynamic> map) {
    MapFields mapFields = MapFields.load(map);
    final maps = mapFields.getMap<String, dynamic>('group');
    mapFields = MapFields.load(maps);

    final leaderMap = mapFields.getMap<String, dynamic>('user');
    final leaderFields = MapFields.load(leaderMap);

    return CustomGroup(
      reference: mapFields.getString('reference'),
      nameLeader: leaderFields.getString('name'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reference': reference,
      'name': nameLeader,
    };
  }

  String toJson() => jsonEncode(toMap());
}
