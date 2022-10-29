import 'package:map_fields/map_fields.dart';

import '../../core/interfaces/clients/http_client.dart';
import '../../core/models/errors/client/client_error.dart';
import '../../core/models/errors/generic_error/generic_error.dart';
import '../../models/user/login_user_model.dart';
import '../../models/user/user_model.dart';

class LoginService {
  final HttpClient _client;

  LoginService(this._client);

  Future<UserModel> login(LoginUserModel user) async {
    try {
      final userMap = user.toMap();
      final response = await _client.post(
        '/login',
        body: userMap,
      );

      final map = MapFields.load(response);

      final userHasura = map.getMap<String, dynamic>('user');

      final userLogged = UserModel.fromMap(userHasura);
      return userLogged;
    } on ClientError {
      rethrow;
    } on MapFieldsError {
      rethrow;
    } on UnknownError {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
