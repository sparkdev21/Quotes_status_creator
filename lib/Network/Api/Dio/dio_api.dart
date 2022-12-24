// To handle offline API caching in Dio in Flutter, you can use the dio-http-cache package to automatically store and retrieve responses from the cache when the device is offline. Here is an example of how you might use the dio-http-cache package to enable offline caching in a Flutter app:

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:quotes_status_creator/Network/Exceptions.dart';
import 'package:quotes_status_creator/models/SettingsModel.dart';

import '../../../Controllers/OfflineHiveDataControllers.dart';
import '../../../models/TrendingModel.dart';
import '../../../models/post_list_model.dart';

class QuoteAPI {
  static const String BASE_URL = 'https://example.com/api/quotes';

  final _dio = Dio();
  PostModel _posts = PostModel();
  TrendingModel _featured = TrendingModel();
  SettingsModels _settings = SettingsModels();
  final OfflineHiveDataController quoteHiveController =
      OfflineHiveDataController();

  QuoteAPI() {
    _dio.interceptors.add(
      DioCacheManager(CacheConfig()).interceptor,
    );
  }

  Future<PostModel> getQuotes(url) async {
    print("dio called");
    try {
      final response = await _dio.get(
        url,
        options: buildCacheOptions(Duration(hours: 19), forceRefresh: true),
      );
      // print(response.data.toString());

      if (response.statusCode == 200) {
        quoteHiveController.storeData(response.toString());
        _posts = PostModel.fromJson(response.data);
        for (int i = 0; i < _posts.items!.length; i++) {
          _posts.items![i].content = _posts.items![i].content!
              .replaceAll(RegExp(r'<script>|</script>'), "");
        }

        return _posts;
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        print("No Internet from dio");
        throw NoInternetException("No Internet from dio");
      }
      // } on SocketException catch (e) {
      //   print("socket exception $e");
      //   throw NoInternetException("No Internet from dio");
    } catch (error) {
      return _posts;
      // throw Exception("Couldnot fetch $error");
    }
  }

  Future<TrendingModel> getFeaturedQuotes(url) async {
    print("dio fet called");
    try {
      final response = await _dio.get(
        url,
        options: buildCacheOptions(
          Duration(hours: 18),
          forceRefresh: true,
        ),
      );

      if (response.statusCode == 200) {
        quoteHiveController.storeFeaturedData(response.toString());
        _featured = TrendingModel.fromJson(response.data);
        _featured.content =
            _featured.content!.replaceAll(RegExp(r'<script>|</script>'), "");
        return _featured;
      } else {
        print(
            '${response.statusCode} :"No Internet from dio ${response.data.toString()}');
        throw NoInternetException("No Internet from dio");
      }
    } catch (error) {
      print(error);
      var response;
      throw response.statusCode;
    }
  }

  Future<SettingsModels> getSettings(url) async {
    print("dio settings called");
    try {
      final response = await _dio.get(
        url,
        options: buildCacheOptions(
          Duration(hours: 18),
          forceRefresh: true,
        ),
      );

      if (response.statusCode == 200) {
        final jsonParsed = json.decode(response.data['content']);

        final data =
            jsonParsed.content!.replaceAll(RegExp(r'<script>|</script>'), "");
        quoteHiveController.storeSettingsData(data.toString());
        _settings = SettingsModels.fromJson(data);
        print("settings api called");
        return _settings;
      } else {
        print(
            '${response.statusCode} :"No Internet from dio ${response.data.toString()}');
        throw NoInternetException("No Internet from dio");
      }
    } catch (error) {
      print(error);
      var response;
      throw response.statusCode;
    }
  }

  Future<TrendingModel> getTrendingQuotes(url) async {
    print("dio trend called");
    try {
      final response = await _dio.get(
        url,
        options: buildCacheOptions(
          Duration(hours: 18),
          forceRefresh: true,
        ),
      );

      if (response.statusCode == 200) {
        quoteHiveController.storeTrendingData(response.toString());
        _featured = TrendingModel.fromJson(response.data);
        _featured.content =
            _featured.content!.replaceAll(RegExp(r'<script>|</script>'), "");
        return _featured;
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw NoInternetException("No Internet from dio");
      }
    } catch (error) {
      print(error);
      var response;
      throw response.statusCode;
    }
  }

  Future<TrendingModel> getUserqUotes(url) async {
    print("dio called");
    try {
      final response = await _dio.get(
        url,
        options: buildCacheOptions(
          Duration(hours: 18),
          forceRefresh: true,
        ),
      );

      if (response.statusCode == 200) {
        quoteHiveController.storeUserQuotesData(response.toString());
        _featured = TrendingModel.fromJson(response.data);
        _featured.content =
            _featured.content!.replaceAll(RegExp(r'<script>|</script>'), "");
        return _featured;
      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw NoInternetException("No Internet from dio");
      }
    } catch (error) {
      print(error);
      var response;
      throw response.statusCode;
    }
  }
}
