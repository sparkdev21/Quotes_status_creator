import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '/models/TrendingModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Network/Api/Api.dart';

import '../../Constants/keys.dart';
import '../../Controllers/OfflineHiveDataControllers.dart';
import '../../Network/Exceptions.dart';

class FeaturedRepository {
  Future<TrendingModel> fetchPosts() async {
    TrendingModel results = TrendingModel();
    final HttpClient http = HttpClient();
    OfflineHiveDataController quoteHiveController = OfflineHiveDataController();
    try {
      if (await quoteHiveController.retriveFeaturedData() != null) {
        Map<String, dynamic> jsonParsed = json
            .decode(await quoteHiveController.retriveFeaturedData() as String);
        // print(jsonParsed);
        results = TrendingModel.fromJson(jsonParsed);
        results.content =
            results.content!.replaceAll(RegExp(r'<script>|</script>'), "");
        print("else Hive code Exceuted");
        Fluttertoast.showToast(msg: "Fetched from hive");

        return results;
      }
      var postListUrl = Uri.https("blogger.googleapis.com",
          "/v3/blogs/$blogId/pages/$featuredPageId/", {"key": apiKey});
      final response =
          await http.getRequest(postListUrl).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonParsed = json.decode(response.body);

        results = TrendingModel.fromJson(jsonParsed);

        results.content =
            results.content!.replaceAll(RegExp(r'<script>|</script>'), "");
        print("results:$results");

        quoteHiveController.storeFeaturedData(response.body);
        print("Fetched from website");
        Fluttertoast.showToast(msg: "Fetched from website");

        return results;
      }
      throw NoInternetException("No Internet Availabele");
    } on SocketException catch (e) {
      print("socket exception");

      Fluttertoast.showToast(msg: "Socket exception no int :$e");
      if (await quoteHiveController.retriveFeaturedData() != null) {
        Map<String, dynamic> jsonParsed = json
            .decode(await quoteHiveController.retriveFeaturedData() as String);
        // print(jsonParsed);
        results = TrendingModel.fromJson(jsonParsed);
        results.content =
            results.content!.replaceAll(RegExp(r'<script>|</script>'), "");
        return results;
      } else {
        Fluttertoast.showToast(msg: "Socket Exception else :$e");
      }
      throw DelayTimeoutException('Socket  Fetched$e');
    } catch (e) {
      if (await quoteHiveController.retriveFeaturedData() != null) {
        Map<String, dynamic> jsonParsed = json
            .decode(await quoteHiveController.retriveFeaturedData() as String);
        // print(jsonParsed);
        results = TrendingModel.fromJson(jsonParsed);
        results.content =
            results.content!.replaceAll(RegExp(r'<script>|</script>'), "");
        Fluttertoast.showToast(msg: "Fetched from catch hive");

        return results;
      } else {
        Fluttertoast.showToast(msg: "Unknow Server Failure Error");
        throw NoInternetException('No Internet:$e');
      }
    }
  }
}
