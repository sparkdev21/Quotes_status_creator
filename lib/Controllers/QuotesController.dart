import 'dart:core';

import 'package:fluttertoast/fluttertoast.dart';

import '../models/HiveModel/hive_quote_data_model.dart';
import '../services/store_quotes.dart';
import 'package:flutter/cupertino.dart';

class QuotesController extends ChangeNotifier {
  late final StoreQuotes store;

  QuotesController() {
    store = StoreQuotes();
  }

  Future<bool> isFav(String value) async {
    if (await store.isQuoteExist(value) == true) {
      print("already exist:$value");

      return true;
    }
    return false;
  }

  Future<bool> addQuotes(String value) async {
    if (await store.isQuoteExist(value) == true) {
      print("already exist:$value");
      await store.deleteQuote(value);

      return false;
    }

    await store.addQuotes(value);
    return true;
  }

  Future<void> addCategoryQuotes(HiveQuoteDataModel quote) async {
    if (await store.isCategoryQuoteExist(quote) == true) {
      await store.deleteCategoryQuote(quote);
      print("alreadyxa deleted");
      Fluttertoast.showToast(msg: "Removed from Favourites");
      return;
    }
    await store.addCategoryQuotes(quote);
    Fluttertoast.showToast(msg: "Added to Favourites");

    print("added ");
  }

  Future<bool> addNotificationQuotes(HiveQuoteDataModel quote) async {
    if (await store.isCategoryQuoteExist(quote) == true) {
      await store.deleteCategoryQuote(quote);
      print("alreadyxa deleted");
      Fluttertoast.showToast(msg: "Removed from Favourites");
      return false;
    }
    await store.addCategoryQuotes(quote);
    Fluttertoast.showToast(msg: "Added to Favourites");
    return true;
    print("added ");
  }

  Future<bool> isCatFav(HiveQuoteDataModel quote) async {
    if (await store.isCategoryQuoteExist(quote) == true) {
      return true;
    }
    return false;
  }

  List<String> favCatKeys() {
    return store.favKeys();
  }

  List<String> favCategoryKeys() {
    return store.favCatKeys();
  }

  Future<void> clearAll() async {
    await store.clearAll();
  }
}
