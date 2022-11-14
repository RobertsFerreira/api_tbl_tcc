import 'package:map_fields/map_fields.dart';

class AnswerUser {
  final double scoreAnswered;
  final double scoredScore;
  final String userName;

  AnswerUser({
    required this.scoreAnswered,
    required this.scoredScore,
    required this.userName,
  });

  factory AnswerUser.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    final userMap = mapFields.getMap('user');
    final userFields = MapFields.load(userMap);

    return AnswerUser(
      scoreAnswered: mapFields.getDouble('score_answer'),
      scoredScore: mapFields.getDouble('scored_score'),
      userName: userFields.getString('name'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'score_answer': scoreAnswered,
      'scored_score': scoredScore,
      'user': userName
    };
  }
}
