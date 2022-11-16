import 'package:map_fields/map_fields.dart';

import '../../core/models/apelacao/apelacao_default.dart';

class NewApelacaoModel extends ApelacaoDefault {
  NewApelacaoModel({
    required super.idGroup,
    required super.idUser,
    required super.idCompany,
    required super.idQuiz,
    required super.apelacao,
    required super.date,
  });

  NewApelacaoModel copyWith({
    String? idGroup,
    String? idUser,
    String? idCompany,
    String? idQuiz,
    String? apelacao,
  }) {
    return NewApelacaoModel(
      idGroup: idGroup ?? this.idGroup,
      idUser: idUser ?? this.idUser,
      idCompany: idCompany ?? this.idCompany,
      idQuiz: idQuiz ?? this.idQuiz,
      apelacao: apelacao ?? this.apelacao,
      date: date ?? date,
    );
  }

  factory NewApelacaoModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    return NewApelacaoModel(
      idGroup: mapFields.getString('id_group', ''),
      idUser: mapFields.getString('id_user'),
      idCompany: mapFields.getString('id_company'),
      idQuiz: mapFields.getString('id_quiz'),
      apelacao: mapFields.getString('apelacao'),
      date: mapFields.getDateTime('date', DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_group': idGroup,
      'id_user': idUser,
      'id_company': idCompany,
      'id_quiz': idQuiz,
      'apelacao': apelacao,
    };
  }
}
