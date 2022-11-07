import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/quiz/quiz_default_model.dart';
import '../../services/quiz/quiz_user_service.dart';

class QuizUserApi {
  final GenericService<QuizDefaultModel> quizUserService;

  QuizUserApi(this.quizUserService);

  Future<List<QuizDefaultModel>> getQuizzesUser({
    required Map<String, dynamic> queryParams,
    required String idUser,
  }) async {
    final mapFields = MapFields.load(queryParams);

    final dateI = mapFields.getString('dateI');
    final dateF = mapFields.getString('dateF');
    final answered = mapFields.getBool('answered');

    final result = await (quizUserService as QuizUserService).get(
      userId: idUser,
      dataIni: dateI,
      dataFim: dateF,
      answered: answered,
    );

    return result;
  }
}
