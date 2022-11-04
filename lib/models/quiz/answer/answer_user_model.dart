import 'dart:convert';

import 'package:map_fields/map_fields.dart';

class AnswerUserModel {
  final String? id;
  final String idAnswer;
  final String idCompany;
  final String idUser;
  final double scoreAnswer;
  final double scoredScore;

  AnswerUserModel({
    this.id,
    required this.idAnswer,
    required this.idCompany,
    required this.idUser,
    required this.scoreAnswer,
    required this.scoredScore,
  });

  factory AnswerUserModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    return AnswerUserModel(
      id: mapFields.getStringNullable('id'),
      idAnswer: mapFields.getString('id_answer'),
      idCompany: mapFields.getString('id_company'),
      idUser: mapFields.getString('id_user'),
      scoreAnswer: mapFields.getDouble('score_answer'),
      scoredScore: mapFields.getDouble('scored_score'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'id_answer': idAnswer,
      'id_company': idCompany,
      'id_user': idUser,
      'score_answer': scoreAnswer,
      'scored_score': scoredScore,
    };
  }

  factory AnswerUserModel.fromJson(String source) =>
      AnswerUserModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
