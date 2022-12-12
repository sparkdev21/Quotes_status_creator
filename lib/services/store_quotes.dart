import '../models/HiveModel/hive_quote_data_model.dart';
import 'package:hive/hive.dart';

class StoreQuotes {
  static const storeBox = '_quoteStoreBox';
  static const categoryStoreBox = '_categoryStoreBox';

  static const note = 'notes';

  late final Box<dynamic> _box;
  late final Box<dynamic> _catBox;

  StoreQuotes() {
    _box = Hive.box(storeBox);
    _catBox = Hive.box(categoryStoreBox);
  }

  boxName() {
    return storeBox;
  }

  catBoxName() {
    return categoryStoreBox;
  }

  //String Quotes for Single Quotes Function

  Future<T?> isQuoteExist<T>(String quote) async {
    final existed = _box.values.where((item) {
      return quote == item;
    });
    if (existed.isNotEmpty) {
      print("Already xa:quote");
      return true as T?;
    } else {
      print("Already xaina:quote");
      return false as T?;
    }
  }

  Future<void> clearAll() async {
    await _box.clear();
    await _catBox.clear();
  }

  Future<void> putData<T>(Object key, T value) async {
    await _box.clear();
    _box.put(key, value);
  }

  Future<void> addQuotes<T>(String data) async => await _box.add(data);

  Future<void> deleteQuote<T>(String quote) async {
    final Map<dynamic, dynamic> deliveriesMap = _box.toMap();
    deliveriesMap.forEach((key, value) {
      if (quote == value) {
        print(",atched:$key");
        _box.delete(key);
      }
    });
  }

  //Category Quote for Model Functions
  Future<void> addCategoryQuotes<T>(data) async => await _catBox.add(data);

  Future<T?> getCategory<T>(Object key, {T? defaultValue}) async =>
      await _catBox.get(key, defaultValue: defaultValue) as T?;

  Future<bool> isCategoryQuoteExist<T>(HiveQuoteDataModel quote) async {
    final existed =
        _catBox.values.map((e) => e.quote).toList().contains(quote.quote);

    if (existed) {
      print("Already xa:quote");
      return true;
    } else {
      print("Already xaina:quote");
      return false;
    }
  }

  Future<void> deleteCategoryQuote(HiveQuoteDataModel quote) async {
    final Map<dynamic, dynamic> deliveriesMap = _catBox.toMap();
    deliveriesMap.forEach((key, value) {
      if (value.quote.toString() == quote.quote) {
        _catBox.delete(key);
      }
    });
  }

  //return favourite keys
  List<String> favKeys() {
    final Map<dynamic, dynamic> deliveriesMap = _catBox.toMap();
    List<String> quotes = [];
    deliveriesMap.forEach((key, value) {
      return quotes.add(value.quote.toString());
    });
    // print(quotes);
    return quotes;
  }

  List<String> favCatKeys() {
    final Map<dynamic, dynamic> deliveriesMap = _catBox.toMap();
    List<String> categories = [];
    deliveriesMap.forEach((key, value) {
      return categories.add(value.category.toString());
    });
    // print(quotes);
    return categories;
  }
}
