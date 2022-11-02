import 'package:api_tbl_tcc/core/models/quiz/quiz_default_model.dart';
import 'package:api_tbl_tcc/export/export_functions.dart';
import 'package:api_tbl_tcc/services/group/group_service.dart';
import 'package:api_tbl_tcc/services/login/login.dart';
import 'package:api_tbl_tcc/services/user/user_service.dart';

import '../../../models/type_user/type_user_model.dart';
import '../../../services/quiz/quiz_service.dart';
import '../../interfaces/generic_service/generic_service.dart';
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

    i.bind<QuizApi>(
      () => QuizApi(i.get<GenericService<QuizDefaultModel>>()),
    );
    return i;
  }
}
