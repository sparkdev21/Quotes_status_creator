import 'package:hive/hive.dart';

class StoreData {
  static const storeBox = '_storeBox';
  static const note = 'notes';
  static const offlineJsonDatakey = 'offlineData';
  static const offlinTrendingData = 'offlineTrending';
  static const offlinUserData = 'offlineUserQuotes';
  static const offlinSettingsData = 'offlineSettings';

  static const offlinfeaturedData = 'featured';
  late final Box<dynamic> _box;

  StoreData() {
    _box = Hive.box(storeBox);
  }

  Future<T?> getValue<T>(Object key, {T? defaultValue}) async => await _box.get(
        key,
        defaultValue: defaultValue,
      ) as T?;

  Future<T?> getQuoteValue<T>(Object key, {T? defaultValue}) async =>
      await _box.get(
        key,
        defaultValue: defaultValue,
      ) as T?;

  Future<bool?> isQuoteExist<bool>(Object key) async =>
      await _box.get(key) as bool;

  Future<void> setValue<T>(Object key, T value) async =>
      await _box.put(key, value);

  Future<void> deleteValue<T>(Object key) async => await _box.delete(key);

  Future<void> clearAll() async => await _box.clear();
  Future<void> putData<T>(Object key, T value) async {
    await _box.clear();
    _box.put(key, value);
  }

  Future<T?> getCategory<T>(Object key, {T? defaultValue}) async =>
      await _box.get(key, defaultValue: defaultValue) as T?;

  Future<void> storeResponseData<T>(Object key, String data) async =>
      await _box.put(key, data);

  Future<T?> retriveResponseData<T>(Object key) async => await _box.get(key);
}
