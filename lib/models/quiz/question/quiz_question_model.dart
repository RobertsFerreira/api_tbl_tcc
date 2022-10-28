import 'dart:convert';

import 'package:api_tbl_tcc/core/models/quiz/question_default_model.dart';
import 'package:map_fields/map_fields.dart';

import '../answer/answer_model.dart';

class QuestionModel extends QuestionDefaultModel {
  final String id;

  QuestionModel({
    required this.id,
    required super.idQuiz,
    required super.idCompany,
    required super.description,
    required super.numberAnswer,
    required super.answers,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    final listAnswers = mapFields.getList<Map<String, dynamic>>('answers', []);
    return QuestionModel(
      id: mapFields.getString('id', ''),
      idQuiz: mapFields.getString('id_quiz', ''),
      idCompany: mapFields.getString('id_company', ''),
      description: mapFields.getString('description', ''),
      numberAnswer: mapFields.getInt('number_answer', -1),
      answers: listAnswers.map((e) => AnswerModel.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_quiz': idQuiz,
      'id_company': idCompany,
      'description': description,
      'number_answer': numberAnswer,
      'answers': answers.map((e) => (e as AnswerModel).toMap()).toList(),
    };
  }

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());
}
