import 'dart:convert';

import 'package:api_tbl_tcc/core/models/quiz/quiz_question_default_model.dart';
import 'package:map_fields/map_fields.dart';

class QuizQuestionModel extends QuizQuestionDefaultModel {
  final String id;

  QuizQuestionModel({
    required this.id,
    required super.idQuiz,
    required super.idCompany,
    required super.description,
    required super.answer,
    required super.points,
  });

  factory QuizQuestionModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    return QuizQuestionModel(
      id: mapFields.getString('id', ''),
      idQuiz: mapFields.getString('id_quiz', ''),
      idCompany: mapFields.getString('id_company', ''),
      description: mapFields.getString('description', ''),
      answer: mapFields.getString('answer', ''),
      points: mapFields.getInt('points', -1),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_quiz': idQuiz,
      'id_company': idCompany,
      'description': description,
      'answer': answer,
      'points': points,
    };
  }

  factory QuizQuestionModel.fromJson(String source) =>
      QuizQuestionModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
