import 'dart:convert';

import 'package:api_tbl_tcc/core/models/quiz/answer_default_model.dart';
import 'package:map_fields/map_fields.dart';

class NewAnswer extends AnswerDefaultModel {
  NewAnswer({
    required super.idCompany,
    required super.idQuestion,
    required super.description,
    required super.correct,
    required super.score,
  });

  factory NewAnswer.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    return NewAnswer(
      idCompany: mapFields.getString('id_company', ''),
      idQuestion: mapFields.getString('id_question', ''),
      description: mapFields.getString('description', ''),
      correct: mapFields.getBool('correct', false),
      score: mapFields.getInt('score', -1),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_company': idCompany,
      'id_question': idQuestion,
      'description': description,
      'correct': correct,
      'score': score,
    };
  }

  factory NewAnswer.fromJson(String source) =>
      NewAnswer.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
