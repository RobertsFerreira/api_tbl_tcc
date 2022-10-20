import 'package:api_tbl_tcc/core/models/quiz/question_default_model.dart';

import '../../../models/user/user_model.dart';

class QuizDefaultModel {
  final String idClass;
  final UserModel teacher;
  final DateTime date;
  final int numberQuestion;
  final String idCompany;
  final List<QuestionDefaultModel> questions;

  QuizDefaultModel({
    required this.idClass,
    required this.teacher,
    required this.date,
    required this.numberQuestion,
    required this.idCompany,
    required this.questions,
  });
}
