import 'package:map_fields/map_fields.dart';

class AnswerGroup {
  final double score;
  final String referenceGroup;

  AnswerGroup({
    required this.score,
    required this.referenceGroup,
  });

  factory AnswerGroup.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    final groupMap = mapFields.getMap('group');
    final groupFields = MapFields.load(groupMap);

    return AnswerGroup(
      score: mapFields.getDouble('score'),
      referenceGroup: groupFields.getString('reference'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'score': score,
      'group': referenceGroup,
    };
  }
}
