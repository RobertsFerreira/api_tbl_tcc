class AnswerDefaultModel {
  final String idCompany;
  final String idQuestion;
  final String description;
  final bool correct;
  final int score;

  AnswerDefaultModel({
    required this.idCompany,
    required this.idQuestion,
    required this.description,
    required this.correct,
    required this.score,
  });
}
