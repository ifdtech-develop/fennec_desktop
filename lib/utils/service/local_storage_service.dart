import 'package:get_storage/get_storage.dart';

abstract class LocalStorageService {
  void put(String key, Object value);

  T? get<T>(String key);

  Future<void> eraseKey(String key);

  Future<void> eraseAll();
}

class LocalStorage implements LocalStorageService {
  final GetStorage box;

  const LocalStorage(this.box);

  @override
  Future<void> eraseAll() => box.erase();

  @override
  Future<void> eraseKey(String key) => box.remove(key);

  @override
  T? get<T>(String key) => box.read<T>(key);

  @override
  void put(String key, Object value) => box.write(key, value);
}
