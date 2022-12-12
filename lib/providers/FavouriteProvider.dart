import '../Controllers/QuotesController.dart';
import '../models/HiveModel/hive_quote_data_model.dart';
import '../services/store_quotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final favNotifier = ChangeNotifierProvider<Favourites>((ref) {
  return Favourites();
});

class Favourites extends ChangeNotifier {
  QuotesController controller = QuotesController();
  List<String> _favQuotes = [];
  List<String> get favQuotes => _favQuotes;
  bool _isLiked = false;

  bool get isLiked => _isLiked;

  set isLiked(bool value) {
    _isLiked = value;
  }

  bool changeFav() {
    _isLiked = !_isLiked;
    notifyListeners();
    return _isLiked;
  }

  set quotesList(List<String> value) {
    _favQuotes = value;
  }

  void initilize() {
    final box = Hive.box(StoreQuotes().catBoxName());
    final List values = box.values.toList();

    for (HiveQuoteDataModel q in values) {
      if (q.isFavourite == true) {
        favQuotes.add(q.quote);
        return;
      }
    }
  }

  Future<List<String>> getFavList() {
    return Future.value(_favQuotes);
  }

  isFav(String quote) {
    if (favQuotes.contains(quote)) {
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  void addToFav(HiveQuoteDataModel quote) {
    controller.addCategoryQuotes(quote);
    if (favQuotes.contains(quote)) {
      favQuotes.remove(quote);
      notifyListeners();
      return;
    }
    favQuotes.add(quote.quote);

    notifyListeners();
  }
}
