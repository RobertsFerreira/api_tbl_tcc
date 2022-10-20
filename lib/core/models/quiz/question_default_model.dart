import 'package:api_tbl_tcc/core/models/quiz/answer_default_model.dart';

class QuestionDefaultModel {
  final String idQuiz;
  final String idCompany;
  final String description;
  final int numberAnswer;
  final List<AnswerDefaultModel> answers;

  QuestionDefaultModel({
    required this.idQuiz,
    required this.idCompany,
    required this.description,
    required this.numberAnswer,
    required this.answers,
  });
}
