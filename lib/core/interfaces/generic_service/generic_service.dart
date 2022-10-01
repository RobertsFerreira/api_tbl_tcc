import 'dart:async';

abstract class GenericService<T> {
  Future<List<T>> getAll();
  Future<T> get(int id);
  Future<T> add(T t);
  Future<T> update(T t);
  Future<T> delete(int id);
}
