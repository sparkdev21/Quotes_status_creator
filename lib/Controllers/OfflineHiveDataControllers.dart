import '../services/store_data.dart';

class OfflineHiveDataController {
  late final StoreData store;

  OfflineHiveDataController() {
    store = StoreData();
  }

  // Future<void> putData(HiveQuoteModel note, Object key) async {
  //   await store.putData(key, note);

  Future<void> storeData(String value) async {
    await store.putData(StoreData.offlineJsonDatakey, value);
  }

  Future<String?> retriveData() async {
    return await store
        .retriveResponseData<String>(StoreData.offlineJsonDatakey);
  }

  Future<void> storeTrendingData(String value) async {
    await store.putData(StoreData.offlinTrendingData, value);
  }

  Future<String?> retriveTrendingData() async {
    return await store
        .retriveResponseData<String>(StoreData.offlinTrendingData);
  }
  Future<String?> retriveSettingsData() async {
    return await store
        .retriveResponseData<String>(StoreData.offlinSettingsData);
  }

  Future<void> storeFeaturedData(String value) async {
    await store.putData(StoreData.offlinfeaturedData, value);
  }
  Future<void> storeSettingsData(String value) async {
    await store.putData(StoreData.offlinfeaturedData, value);
  }
  Future<void> storeUserQuotesData(String value) async {
    await store.putData(StoreData.offlinUserData, value);
  }

  Future<String?> retriveFeaturedData() async {
    return await store
        .retriveResponseData<String>(StoreData.offlinfeaturedData);
  }
  Future<String?> retriveUserQuotesData() async {
    return await store
        .retriveResponseData<String>(StoreData.offlinfeaturedData);
  }

  Future<void> clearAll() async {
    await store.clearAll();
  }
}
