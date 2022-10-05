import 'dart:async';

abstract class GenericService<T> {
  Future<List<T>> get({String? idCompany});
  Future<T> getById(int id);
  Future<bool> insert(T t);
  Future<bool> update(T t);
  Future<bool> delete(int id);
}
