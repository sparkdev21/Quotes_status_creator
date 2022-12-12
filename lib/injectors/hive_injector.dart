import '../models/HiveModel/hive_quote_data_model.dart';
import '../services/store_quotes.dart';
import 'package:hive_flutter/adapters.dart';

import '../services/store_data.dart';

class HiveInjector {
  static Future<void> setup() async {
    await Hive.initFlutter();
    _registerAdapters();
    await Hive.openBox(StoreData.storeBox);
    await Hive.openBox(StoreQuotes.storeBox);
    await Hive.openBox(StoreQuotes.categoryStoreBox);
  }

  static void _registerAdapters() {
    Hive.registerAdapter(HiveQuoteDataModelAdapter());
  }
}
//    final applicatonDocumentDir =
    //     await path_provider.getApplicationDocumentsDirectory();
    // Hive.init(applicatonDocumentDir.path);