import 'package:map_fields/map_fields.dart';

import '../answer/answer_result.dart';

class QuestionResult {
  final String description;
  final List<AnswerResult> answersResult;

  QuestionResult({
    required this.description,
    required this.answersResult,
  });

  factory QuestionResult.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    final answersResultMap = mapFields.getList<Map<String, dynamic>>('answers');

    return QuestionResult(
      description: mapFields.getString('description'),
      answersResult: answersResultMap
          .map((answer) => AnswerResult.fromMap(answer))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'answers': answersResult
          .map(
            (answer) => answer.toMap(),
          )
          .toList(),
    };
  }
}
