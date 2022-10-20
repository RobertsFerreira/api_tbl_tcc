import 'dart:convert';

import 'package:api_tbl_tcc/core/models/quiz/answer_default_model.dart';
import 'package:map_fields/map_fields.dart';

class AnswerModel extends AnswerDefaultModel {
  final String id;

  AnswerModel({
    required this.id,
    required super.idCompany,
    required super.idQuestion,
    required super.description,
    required super.correct,
    required super.score,
  });

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    return AnswerModel(
      id: mapFields.getString('id', ''),
      idCompany: mapFields.getString('id_company', ''),
      idQuestion: mapFields.getString('id_question', ''),
      description: mapFields.getString('description', ''),
      correct: mapFields.getBool('correct', false),
      score: mapFields.getInt('score', -1),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_company': idCompany,
      'id_question': idQuestion,
      'description': description,
      'correct': correct,
      'score': score,
    };
  }

  factory AnswerModel.fromJson(String source) =>
      AnswerModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
