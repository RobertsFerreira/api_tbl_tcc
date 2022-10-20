import 'package:map_fields/map_fields.dart';

import '../../../core/models/quiz/question_default_model.dart';

class NewQuestionModel extends QuestionDefaultModel {
  NewQuestionModel({
    required super.idQuiz,
    required super.idCompany,
    required super.description,
    required super.numberAnswer,
  });

  NewQuestionModel copyWith({
    String? idQuiz,
    String? idCompany,
    String? description,
    int? numberAnswer,
  }) {
    return NewQuestionModel(
      idQuiz: idQuiz ?? this.idQuiz,
      idCompany: idCompany ?? this.idCompany,
      description: description ?? this.description,
      numberAnswer: numberAnswer ?? this.numberAnswer,
    );
  }

  factory NewQuestionModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    return NewQuestionModel(
      idQuiz: mapFields.getString('id_quiz', ''),
      idCompany: mapFields.getString('id_company', ''),
      description: mapFields.getString('description', ''),
      numberAnswer: mapFields.getInt('number_answer', -1),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_quiz': idQuiz,
      'id_company': idCompany,
      'description': description,
      'number_answer': numberAnswer,
    };
  }
}
