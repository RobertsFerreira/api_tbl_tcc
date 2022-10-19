import 'package:api_tbl_tcc/core/models/quiz/quiz_default_model.dart';
import 'package:map_fields/map_fields.dart';

import '../user/user_model.dart';

class QuizModel extends QuizDefaultModel {
  final String id;

  QuizModel({
    required this.id,
    required super.idClass,
    required super.teacher,
    required super.date,
    required super.numberQuestion,
    required super.idCompany,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    final user = mapFields.getMap<String, dynamic>('user');
    return QuizModel(
      id: mapFields.getString('id', ''),
      idClass: mapFields.getString('id_class', ''),
      teacher: UserModel.fromMap(user),
      date: mapFields.getDateTime('date', DateTime.now()),
      numberQuestion: mapFields.getInt('number_question', -1),
      idCompany: mapFields.getString('id_company', ''),
    );
  }

  Map<String, dynamic> toUpdate() {
    return {
      'id': id,
      'id_class': idClass,
      'id_user': teacher.id,
      'date': date,
      'number_question': numberQuestion,
      'id_company': idCompany
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_class': idClass,
      'id_user': teacher.toMap(),
      'date': date,
      'number_question': numberQuestion,
      'id_company': idCompany
    };
  }
}
