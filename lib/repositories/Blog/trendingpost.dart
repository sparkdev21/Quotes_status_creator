import 'dart:async';
import 'dart:convert';

import 'package:quotes_status_creator/repositories/Blog/helper.dart';

import '../../Network/Api/Dio/dio_api.dart';
import '/models/TrendingModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Constants/keys.dart';
import '../../Controllers/OfflineHiveDataControllers.dart';

class TrendinRepository {
  String url =
      'https://www.googleapis.com/blogger/v3/blogs/$blogId/pages/$trendingPageId?key=$apiKey';
  Future<TrendingModel> fetchPosts() async {
    TrendingModel results = TrendingModel();

    final QuoteAPI http = QuoteAPI();
    OfflineHiveDataController quoteHiveController = OfflineHiveDataController();

    _fetchDataFromHive() async {
      Map<String, dynamic> jsonParsed = json
          .decode(await quoteHiveController.retriveTrendingData() as String);
      // print(jsonParsed);
      results = TrendingModel.fromJson(jsonParsed);
      results.content =
          results.content!.replaceAll(RegExp(r'<script>|</script>'), "");
      print("else Hive code Exceuted");
      Fluttertoast.showToast(msg: "Fetched from hive");

      return results;
    }

    _fetchFromInternet() async {
      results = await http.getTrendingQuotes(url);
      showToast(debug, "Fetched from Internet");
      return results;
    }

    if (await quoteHiveController.retriveTrendingData() != null) {
      return _fetchDataFromHive();
    } else {
      return _fetchFromInternet();
    }
  }
}
