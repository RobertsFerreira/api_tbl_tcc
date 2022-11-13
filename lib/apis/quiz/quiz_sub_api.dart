import 'package:map_fields/map_fields.dart';
import 'package:shelf/shelf.dart';

import '../../core/interfaces/generic_service/generic_service.dart';
import '../../core/models/quiz/quiz_default_model.dart';
import '../../models/quiz/answer/new_answer_group_model.dart';
import '../../services/quiz/quiz_sub_service.dart';

class QuizSubApi {
  final GenericService<QuizDefaultModel> quizUserService;

  QuizSubApi(this.quizUserService);

  Future<List<QuizDefaultModel>> getQuizzesUser({
    required Map<String, dynamic> queryParams,
    required String idUser,
  }) async {
    final mapFields = MapFields.load(queryParams);

    final dateI = mapFields.getString('dateI');
    final dateF = mapFields.getString('dateF');
    final answered = mapFields.getBool('answered');

    final result = await (quizUserService as QuizSubService).get(
      userId: idUser,
      dataIni: dateI,
      dataFim: dateF,
      answered: answered,
    );

    return result;
  }

  Future<bool> insertAnswersGroup({required Request request}) async {
    try {
      final body = await request.readAsString();

      final mapFields = MapFields.load(body);

      final listAnswers = mapFields.getList<Map<String, dynamic>>('answers');

      final answers = listAnswers
          .map((answer) => NewAnswerGroupModel.fromMap(answer))
          .toList();

      final result =
          await (quizUserService as QuizSubService).insertAnswersGroup(answers);

      return result;
    } catch (e) {
      rethrow;
    }
  }
}