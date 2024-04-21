import 'package:get_storage/get_storage.dart';

class SLocalStorage {
  late final GetStorage _storage;

  // Singleton instance
  static SLocalStorage? _instance;

  SLocalStorage._internal();

  factory SLocalStorage.instance() {
    _instance ??= SLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = SLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }
  // static final SLocalStorage _instance = SLocalStorage._internal();

  // factory SLocalStorage() {
  //   return _instance;
  // }

  // SLocalStorage._internal();

  // final _storage = GetStorage();

  // Generic method to save data
  Future<void> saveData<S>(String key, S value) async {
    await _storage.write(key, value);
  }

  // Generic method to read data
  S? readData<S>(String key){
    return _storage.read<S>(key);
  }

  // Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Clear all data in storege
  Future<void> clearAll() async {
    await _storage.erase();
  }
}