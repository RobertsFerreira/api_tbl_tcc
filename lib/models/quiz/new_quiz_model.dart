import 'package:api_tbl_tcc/models/quiz/quiz_default_model.dart';
import 'package:api_tbl_tcc/models/user/user_model.dart';
import 'package:map_fields/map_fields.dart';

class NewQuizModel extends QuizDefaultModel {
  NewQuizModel({
    required super.idClass,
    required super.teacher,
    required super.date,
    required super.numberQuestion,
  });

  factory NewQuizModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    final user = mapFields.getMap<String, dynamic>('user');
    return NewQuizModel(
      idClass: mapFields.getString('id_class', ''),
      teacher: UserModel.fromMap(user),
      date: mapFields.getDateTime('date', DateTime.now()),
      numberQuestion: mapFields.getInt('number_question', -1),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_class': idClass,
      'id_user': teacher.id,
      'date': date,
      'number_question': numberQuestion,
    };
  }
}
