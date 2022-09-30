import '../../models/type_user/type_user_model.dart';
import '../interfaces/clients/http_client.dart';
import '../interfaces/generic_service/generic_service.dart';

class TypesUserService implements GenericService<TypeUserModel> {
  final HttpClient client;

  TypesUserService(this.client);

  @override
  Future<TypeUserModel> add(TypeUserModel t) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<TypeUserModel> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<TypeUserModel> get(int id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<TypeUserModel>> getAll() async {
    List<TypeUserModel> listTypes = [];
    try {
      final result = await client.get('/get/types_users/all');
      final types =
          result.map<TypeUserModel>((e) => TypeUserModel.fromMap(e)).toList();
      listTypes = types;
    } catch (e) {
      print(e.toString());
    }
    return listTypes;
  }

  @override
  Future<TypeUserModel> update(TypeUserModel t) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
