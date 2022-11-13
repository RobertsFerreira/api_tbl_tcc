import 'package:api_tbl_tcc/core/models/quiz/quiz_default_model.dart';
import 'package:api_tbl_tcc/export/export_functions.dart';
import 'package:api_tbl_tcc/services/apelacao/apelacao_service.dart';
import 'package:api_tbl_tcc/services/group/group_service.dart';
import 'package:api_tbl_tcc/services/login/login.dart';
import 'package:api_tbl_tcc/services/quiz/quiz_sub_service.dart';
import 'package:api_tbl_tcc/services/user/user_service.dart';

import '../../../apis/apelacao/apelacao_api.dart';
import '../../../apis/quiz/quiz_sub_api.dart';
import '../../../models/type_user/type_user_model.dart';
import '../../../services/quiz/quiz_service.dart';
import '../../interfaces/generic_service/generic_service.dart';
import '../../models/apelacao/apelacao_default.dart';
import '../../models/group/group_default.dart';
import '../../models/user/user_default.dart';
import 'bind_injectors.dart';

class Injects {
  static BindInjectors init() {
    final i = BindInjectors();
    i.bind<HttpClient>(() => DioClient());
    i.bind<GenericService<TypeUserModel>>(
      () => TypesUserService(i.get<HttpClient>()),
    );
    i.bind<TypesUserApi>(
      () => TypesUserApi(i.get<GenericService<TypeUserModel>>()),
    );
    i.bind<LoginService>(
      () => LoginService(i.get<HttpClient>()),
    );
    i.bind<LoginApi>(() => LoginApi(i.get<LoginService>()));
    i.bind<SobreApi>(() => SobreApi());
    i.bind<GenericService<UserDefault>>(
      () => UserService(i.get<HttpClient>()),
    );
    i.bind<UserApi>(
      () => UserApi(i.get<GenericService<UserDefault>>()),
    );
    i.bind<GenericService<GroupDefault>>(
      () => GroupService(i.get<HttpClient>()),
    );
    i.bind<GroupApi>(
      () => GroupApi(i.get<GenericService<GroupDefault>>()),
    );
    i.bind<GenericService<QuizDefaultModel>>(
      () => QuizService(i.get<HttpClient>()),
    );

    i.bind<QuizSubService>(
      () => QuizSubService(i.get<HttpClient>()),
    );

    i.bind<QuizSubApi>(
      () => QuizSubApi(i.get<QuizSubService>()),
    );

    i.bind<QuizApi>(
      () => QuizApi(i.get<GenericService<QuizDefaultModel>>()),
    );

    i.bind<ApelacaoService>(
      () => ApelacaoService(i.get<HttpClient>()),
    );

    i.bind<ApelacaoApi>(
      () => ApelacaoApi(
        i.get<GenericService<ApelacaoDefault>>(),
      ),
    );

    return i;
  }
}
