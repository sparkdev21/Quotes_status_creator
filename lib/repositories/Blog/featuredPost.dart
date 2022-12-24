import 'dart:async';
import 'dart:convert';

import 'package:quotes_status_creator/Network/Api/Dio/dio_api.dart';
import 'package:quotes_status_creator/repositories/Blog/helper.dart';

import '/models/TrendingModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Constants/keys.dart';
import '../../Controllers/OfflineHiveDataControllers.dart';

class FeaturedRepository {
  String url =
      'https://www.googleapis.com/blogger/v3/blogs/$blogId/pages/$featuredPageId?key=$apiKey';
  Future<TrendingModel> fetchPosts() async {
    TrendingModel results = TrendingModel();

    final QuoteAPI http = QuoteAPI();
    OfflineHiveDataController quoteHiveController = OfflineHiveDataController();

    _fetchDataFromHive() async {
      Map<String, dynamic> jsonParsed = json
          .decode(await quoteHiveController.retriveFeaturedData() as String);
      // print(jsonParsed);
      results = TrendingModel.fromJson(jsonParsed);
      results.content =
          results.content!.replaceAll(RegExp(r'<script>|</script>'), "");
      Fluttertoast.showToast(
          msg: "Fetched from hive  :Featured Data :$results");

      return results;
    }

    _fetchFromInternet() async {
      results = await http.getFeaturedQuotes(url);
      showToast(debug, "Fetched from Internet :Featured Data :$results");
      return results;
    }

    if (await quoteHiveController.retriveFeaturedData() != null) {
      return _fetchDataFromHive();
    } else {
      return _fetchFromInternet();
    }
  }
}
