import 'package:api_tbl_tcc/models/quiz/answer/new_answer_model.dart';
import 'package:map_fields/map_fields.dart';

import '../../../core/models/quiz/question_default_model.dart';

class NewQuestionModel extends QuestionDefaultModel {
  NewQuestionModel({
    required super.idQuiz,
    required super.idCompany,
    required super.description,
    required super.numberAnswer,
    required super.answers,
  });

  NewQuestionModel copyWith({
    String? idQuiz,
    String? idCompany,
    String? description,
    int? numberAnswer,
    List<NewAnswerModel>? answers,
  }) {
    return NewQuestionModel(
      idQuiz: idQuiz ?? this.idQuiz,
      idCompany: idCompany ?? this.idCompany,
      description: description ?? this.description,
      numberAnswer: numberAnswer ?? this.numberAnswer,
      answers: answers ?? this.answers,
    );
  }

  factory NewQuestionModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    final listAnswers = mapFields.getList('answers', []);
    return NewQuestionModel(
      idQuiz: mapFields.getString('id_quiz', ''),
      idCompany: mapFields.getString('id_company', ''),
      description: mapFields.getString('description', ''),
      numberAnswer: mapFields.getInt('number_answer', -1),
      answers: listAnswers.map((e) => NewAnswerModel.fromMap(e)).toList(),
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
