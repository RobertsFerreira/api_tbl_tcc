import 'package:api_tbl_tcc/core/models/quiz/quiz_default_model.dart';
import 'package:api_tbl_tcc/models/quiz/question/quiz_question_model.dart';
import 'package:map_fields/map_fields.dart';

import '../user/user_model.dart';

class QuizModel extends QuizDefaultModel {
  final String id;

  QuizModel({
    required this.id,
    required super.teacher,
    required super.numberQuestion,
    required super.idCompany,
    required super.questions,
    required super.title,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    final user = mapFields.getMap<String, dynamic>('user');
    final questionsMap = mapFields.getList<Map<String, dynamic>>('questions');
    return QuizModel(
      id: mapFields.getString('id'),
      teacher: UserModel.fromMap(user),
      numberQuestion: mapFields.getInt('number_question'),
      idCompany: mapFields.getString('id_company'),
      questions: questionsMap.map((e) => QuestionModel.fromMap(e)).toList(),
      title: mapFields.getString('title'),
    );
  }

  Map<String, dynamic> toUpdate() {
    return {
      'id': id,
      'id_user': teacher.id,
      'number_question': numberQuestion,
      'id_company': idCompany,
      'title': title,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': teacher.toMap(),
      'number_question': numberQuestion,
      'id_company': idCompany,
      'questions': questions.map((e) => (e as QuestionModel).toMap()).toList(),
      'title': title,
    };
  }
}
