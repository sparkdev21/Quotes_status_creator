import 'package:flutter/material.dart';
import 'package:quotes_status_creator/models/BlogUserQuotesModel.dart';

import '../models/love_quotes_english.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/HiveModel/TrendingQuotesModel.dart';
import '../models/post_list_model.dart';

final mainQuotesProvider = ChangeNotifierProvider<QuotesUINotifier>((ref) {
  return QuotesUINotifier();
});

class QuotesUINotifier extends ChangeNotifier {
//rapid index change notifier in Tinder Swipe
  int _indx = 0;
  int _show_after_action = 5;
  int _adsCounter = 0;
  // set adsCounter(value) {
  //   adsCounter = value;
  // }

  int get adCount => _adsCounter;
  get index => _indx;
  changeindex(value) {
    _adsCounter += 1;
    _indx = value;
    if (_adsCounter == _show_after_action || _adsCounter > 8) {
      print("adts:$_adsCounter");
      _adsCounter = 0;
    }

    notifyListeners();
  }

  List<TrendingQuotesModel> _featuredQuotes = [
    TrendingQuotesModel(
      id: 1,
      quote: "Hello",
      category: "cat",
      author: "Gb",
    ),
    TrendingQuotesModel(
      id: 1,
      quote: "Hello",
      category: "cat",
      author: "Gb",
    ),
    TrendingQuotesModel(
      id: 1,
      quote: "Hello",
      category: "cat",
      author: "Gb",
    )
  ];
  List<TrendingQuotesModel> _trendingQuotes = [
    TrendingQuotesModel(
      id: 1,
      quote: "Hello",
      category: "cat",
      author: "Gb",
    ),
    TrendingQuotesModel(
      id: 1,
      quote: "Hello",
      category: "cat",
      author: "Gb",
    ),
    TrendingQuotesModel(
      id: 1,
      quote: "Hello",
      category: "cat",
      author: "Gb",
    )
  ];
  List<UserQuotesBlogModel> _userQuotes = [
    UserQuotesBlogModel(
        userid: "@gb", quote: "Hello", featured: 1, status: "pending"),
    UserQuotesBlogModel(
        userid: "@gb", quote: "Hello", featured: 1, status: "pending"),
    UserQuotesBlogModel(
        userid: "@gb", quote: "Hello", featured: 1, status: "pending"),
  ];

  List<List<QuotesModel>> _mainQuotes = [];
  List<QuotesModel> _mainQuotesList = [];
  List<String> _categories = [];

//Quotes with Ads
  List<Object> _catWithAds = [];
  get catWithAds => _catWithAds;
  addAds() {
    _catWithAds = List.from(_categories);

    for (var i = catWithAds.length - 3; i >= 0; i -= 2) {
      catWithAds.insert(i, SizedBox.shrink());
    }
    notifyListeners();
  }

// Featured Quotes
  List<TrendingQuotesModel> get featuredQuotes => _featuredQuotes;
  setFeaturedQuotes(value) {
    _featuredQuotes = value;
    notifyListeners();
  }

// Trending Quotes
  List<TrendingQuotesModel> get trendinGQuotes => _trendingQuotes;
  setTrendingQuotes(value) {
    _trendingQuotes = value;
    notifyListeners();
  }

// User Quotes
  List<UserQuotesBlogModel> get userQuotes => _userQuotes;
  setUserQuotes(value) {
    _userQuotes = value;
    notifyListeners();
  }

  List<List<QuotesModel>> get mainQuotes => _mainQuotes;
  setMainQuotes(value) {
    _mainQuotes = value;
    notifyListeners();
  }

  List<QuotesModel> get mainQuotesList => _mainQuotesList;

  addMainQuotes(QuotesModel value) {
    _mainQuotesList.add(value);
    print("main:${_mainQuotesList.length}");
    notifyListeners();
  }

  List<String> get categories => _categories;
  setQuotesCategories(value) {
    _categories = value;
    notifyListeners();
  }

  // Cache LatestQuotees
  PostModel _postData = PostModel();
  get postData => _postData;

  setPostData(PostModel value) {
    _postData = value;
    print("PG:${_postData.items!.length}");
    notifyListeners();
  }

  //category Decider
  bool _defaultCategory = true;
  get defaultCategory {
    return _defaultCategory;
  }

  changeUi(bool value) {
    _defaultCategory = value;
    print("va;$value");
    notifyListeners();
  }

  // Change Ctaegory Ui Setting

  bool _autoPlay = false;
  get autoplay {
    return _autoPlay;
  }

  get autoDelay {
    return _autodelay;
  }

  //change ui Tinder Colors Card

  bool _defaultColor = true;
  get defaultColor {
    return _defaultColor;
  }

  changeDefualtColor(bool value) {
    _defaultColor = value;
    notifyListeners();
  }

  int _autodelay = 5;
  changeAutoplay(bool value) {
    _autoPlay = value;
    notifyListeners();
  }

  changeAutodelay(double value) {
    _autodelay = value.toInt();
    notifyListeners();
  }

  //Change to STack on Screenshot
  bool _isTakingScreenshot = false;

  get isTakingScreenshot {
    return _isTakingScreenshot;
  }

  setTakingScreenShot(value) {
    _isTakingScreenshot = value;
    notifyListeners();
  }

  changeUI(bool value) {
    _isTakingScreenshot = value;

    notifyListeners();
  }
}
