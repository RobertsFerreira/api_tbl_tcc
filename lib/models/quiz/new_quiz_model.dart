import 'dart:convert';

import 'package:api_tbl_tcc/core/models/quiz/quiz_default_model.dart';
import 'package:api_tbl_tcc/models/user/user_model.dart';
import 'package:api_tbl_tcc/utils/hasura/helper_extensions.dart';
import 'package:map_fields/map_fields.dart';

import 'question/new_question_model.dart';

class NewQuizModel extends QuizDefaultModel {
  NewQuizModel({
    required super.idClass,
    required super.teacher,
    required super.date,
    required super.numberQuestion,
    required super.idCompany,
    required super.questions,
  });

  factory NewQuizModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    final user = mapFields.getMap<String, dynamic>('user');
    final questionsMap = mapFields.getList<Map<String, dynamic>>('questions');
    return NewQuizModel(
      idClass: mapFields.getString('id_class', ''),
      teacher: UserModel.fromMap(user),
      date: mapFields.getDateTime('date', DateTime.now()),
      numberQuestion: mapFields.getInt('number_question', -1),
      idCompany: mapFields.getString('id_company', ''),
      questions: questionsMap.map((e) => NewQuestionModel.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_class': idClass,
      'id_user': teacher.id,
      'date': date.toDateHasura(),
      'number_question': numberQuestion,
      'id_company': idCompany,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory NewQuizModel.fromJson(String source) =>
      NewQuizModel.fromMap(jsonDecode(source));
}
