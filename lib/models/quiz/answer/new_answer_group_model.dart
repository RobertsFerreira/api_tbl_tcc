import 'package:map_fields/map_fields.dart';

class NewAnswerGroupModel {
  final String idAnswer;
  final String idCompany;
  final double score;
  final String idGroup;

  NewAnswerGroupModel({
    required this.idAnswer,
    required this.idCompany,
    required this.score,
    required this.idGroup,
  });

  NewAnswerGroupModel copyWith({
    String? idAnswer,
    String? idCompany,
    double? score,
    String? idGroup,
  }) {
    return NewAnswerGroupModel(
      idAnswer: idAnswer ?? this.idAnswer,
      idCompany: idCompany ?? this.idCompany,
      score: score ?? this.score,
      idGroup: idGroup ?? this.idGroup,
    );
  }

  factory NewAnswerGroupModel.fromMap(Map<String, dynamic> map) {
    final maps = MapFields.load(map);
    return NewAnswerGroupModel(
      idAnswer: maps.getString('id_answer'),
      idCompany: maps.getString('id_company'),
      score: maps.getDouble('score'),
      idGroup: maps.getString('id_group'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_answer': idAnswer,
      'id_company': idCompany,
      'score': score,
      'id_group': idGroup,
    };
  }
}
