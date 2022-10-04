import 'package:api_tbl_tcc/export/export_functions.dart';
import 'package:api_tbl_tcc/services/user/user_service.dart';

import '../../../models/type_user/type_user_model.dart';
import '../../interfaces/generic_service/generic_service.dart';
import '../../models/user/user_default.dart';
import 'bind_injectors.dart';

class Injects {
  static BindInjectors init() {
    final i = BindInjectors();
    i.bind<HttpClient>(() => DioClient());
    i.bind<GenericService<TypeUserModel>>(() => TypesUserService(i()));
    i.bind<TypesUserApi>(() => TypesUserApi(i()));
    i.bind<LoginApi>(() => LoginApi());
    i.bind<SobreApi>(() => SobreApi());
    i.bind<GenericService<UserDefault>>(() => UserService(i()));
    return i;
  }
}
