typedef InstanceCreator<T> = Function();

class BindInjectors {
  BindInjectors._();

  static final BindInjectors _instance = BindInjectors._();

  factory BindInjectors() => _instance;

  final Map<Type, _InstanceGenerator<Object>> _binds = {};

  void bind<T extends Object>(
    InstanceCreator<T> bind, {
    bool isSingleton = true,
  }) {
    _binds[T] = _InstanceGenerator(
      bind,
      isSingleton: isSingleton,
    );
  }

  T get<T extends Object>() {
    final instance = _binds[T]?.instance;
    if (instance == null && instance is! T) {
      throw Exception('Bind not found for type $T');
    }
    return instance as T;
  }

  call<T extends Object>() => get<T>();
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;
  final InstanceCreator<T> _creator;

  _InstanceGenerator(
    this._creator, {
    bool isSingleton = true,
  }) : _isFirstGet = isSingleton;

  T? get instance {
    if (_isFirstGet) {
      _instance = _creator();
      _isFirstGet = false;
    }
    return _instance ?? _creator();
  }
}
