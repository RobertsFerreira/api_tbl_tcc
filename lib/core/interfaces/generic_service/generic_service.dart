import 'dart:async';

abstract class GenericService<T> {
  Future<List<T>> getAll();
  Future<List<T>> getAllForCompany({required String idCompany});
  Future<T> get(int id);
  Future<T> insert(T t);
  Future<T> update(T t);
  Future<T> delete(int id);
}
