import 'package:map_fields/map_fields.dart';

import '../../core/models/apelacao/apelacao_default.dart';

class NewApelacaoModel extends ApelacaoDefault {
  NewApelacaoModel({
    required super.idGroup,
    required super.idUser,
    required super.idCompany,
    required super.idQuiz,
    required super.apelacao,
  });

  factory NewApelacaoModel.fromMap(Map<String, dynamic> map) {
    final mapFields = MapFields.load(map);
    return NewApelacaoModel(
      idGroup: mapFields.getString('id_group'),
      idUser: mapFields.getString('id_user'),
      idCompany: mapFields.getString('id_company'),
      idQuiz: mapFields.getString('id_quiz'),
      apelacao: mapFields.getString('apelacao'),
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
