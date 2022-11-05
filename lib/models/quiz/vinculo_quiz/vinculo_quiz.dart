import 'dart:convert';

import 'package:map_fields/map_fields.dart';

class VinculoQuiz {
  final String title;
  final DateTime date;
  final String referenceGroup;
  final String userNameLeader;

  VinculoQuiz({
    required this.title,
    required this.date,
    required this.referenceGroup,
    required this.userNameLeader,
  });

  factory VinculoQuiz.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);

    final quizHeader = mapFields.getMap<String, dynamic>('quiz_header');
    final quizHeaderFields = MapFields.load(quizHeader);

    final groupMap = mapFields.getMap<String, dynamic>('group');
    final groupFields = MapFields.load(groupMap);

    final leaderMap = groupFields.getMap<String, dynamic>('user');
    final leaderFields = MapFields.load(leaderMap);

    return VinculoQuiz(
      title: quizHeaderFields.getString('title'),
      date: mapFields.getDateTime('date'),
      referenceGroup: groupFields.getString('reference'),
      userNameLeader: leaderFields.getString('name'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'reference_group': referenceGroup,
      'user_leader': userNameLeader,
    };
  }

  String toJson() => jsonEncode(toMap());
}
