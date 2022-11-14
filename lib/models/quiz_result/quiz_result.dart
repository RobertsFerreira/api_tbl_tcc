import 'package:map_fields/map_fields.dart';

import 'question/question_result.dart';

class QuizResult {
  final String title;
  final List<QuestionResult> questionsResult;

  QuizResult({
    required this.title,
    required this.questionsResult,
  });

  factory QuizResult.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    final questionsResultMap =
        mapFields.getList<Map<String, dynamic>>('questions');

    return QuizResult(
      title: mapFields.getString('title'),
      questionsResult: questionsResultMap
          .map(
            (questionResult) => QuestionResult.fromMap(questionResult),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questionsResult
          .map(
            (question) => question.toMap(),
          )
          .toList(),
    };
  }
}
