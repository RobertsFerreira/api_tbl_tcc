import '../user/user_model.dart';

class QuizHeaderDefaultModel {
  final String idClass;
  final UserModel teacher;
  final DateTime date;
  final int numberQuestion;

  QuizHeaderDefaultModel({
    required this.idClass,
    required this.teacher,
    required this.date,
    required this.numberQuestion,
  });
}
