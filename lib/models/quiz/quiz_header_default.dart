import '../user/user_model.dart';

class QuizHeaderDefault {
  final String idClass;
  final UserModel teacher;
  final DateTime date;
  final int numberQuestion;

  QuizHeaderDefault({
    required this.idClass,
    required this.teacher,
    required this.date,
    required this.numberQuestion,
  });
}
