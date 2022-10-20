import 'package:map_fields/map_fields.dart';

import '../../../core/models/quiz/quiz_question_default_model.dart';

class NewQuizQuestionModel extends QuizQuestionDefaultModel {
  NewQuizQuestionModel({
    required super.idQuiz,
    required super.idCompany,
    required super.description,
    required super.answer,
    required super.points,
  });

  NewQuizQuestionModel copyWith({
    String? idQuiz,
    String? idCompany,
    String? description,
    String? answer,
    int? points,
  }) {
    return NewQuizQuestionModel(
      idQuiz: idQuiz ?? this.idQuiz,
      idCompany: idCompany ?? this.idCompany,
      description: description ?? this.description,
      answer: answer ?? this.answer,
      points: points ?? this.points,
    );
  }

  factory NewQuizQuestionModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    return NewQuizQuestionModel(
      idQuiz: mapFields.getString('id_quiz', ''),
      idCompany: mapFields.getString('id_company', ''),
      description: mapFields.getString('description', ''),
      answer: mapFields.getString('answer', ''),
      points: mapFields.getInt('points', -1),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_quiz': idQuiz,
      'id_company': idCompany,
      'description': description,
      'answer': answer,
      'points': points,
    };
  }
}
