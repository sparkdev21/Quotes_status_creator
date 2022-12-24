import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes_status_creator/IsolatesJson/Jsonpasrer.dart';
import 'package:quotes_status_creator/Network/Api/Dio/dio_api.dart';
import 'package:quotes_status_creator/repositories/Blog/helper.dart';

import '../../Constants/keys.dart';
import '../../Controllers/OfflineHiveDataControllers.dart';
import '../../models/post_list_model.dart';
import 'Data/blogdata.dart';

class BlogRepository {
  Future<PostModel> fetchPosts() async {
    PostModel results = PostModel();

    final QuoteAPI http = QuoteAPI();
    OfflineHiveDataController quoteHiveController = OfflineHiveDataController();
    String url =
        'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$apiKey';

    offlineFetch() async {
      debugPrint("Executing :Offline");

      results =
          await BlogRepositoryParser("").fetchInOffline(offlineRealblogData);

      Fluttertoast.showToast(msg: results.items.toString());
      print("Executing Offline Data code Exceuted");
      return results;
    }

    try {
      if (await quoteHiveController.retriveData() != null) {
        final hiveJson = await quoteHiveController.retriveData();
        final blogparser = BlogRepositoryParser(hiveJson!);
        results = await blogparser.fetchGeneral();
        print("Executing Offline Hive  Data code Exceuted");
        return results;
      } else {
        results = await http.getQuotes(url);
        if (results.items == null) {
          print("Executing $results");
          results = await offlineFetch();
        }
        return results;
      }
    } on SocketException {
      return offlineFetch();
    } catch (e) {
      showToast(true, "Unable to Fetch From Internet ");
      return results;
    }

    // return offlineFetch();
  }
}


//general Methods 
// offlineFetch() {
    //   print(offlineRealblogData.toString());
    //   // final postList = PostModel.fromJson(offlineBloGdata);
    //   print("Offline fwtch called");

    //   results = PostModel.fromJson(offlineRealblogData);
    //   for (int i = 0; i < results.items!.length; i++) {
    //     results.items![i].content = results.items![i].content!
    //         .replaceAll(RegExp(r'<script>|</script>'), "");
    //   }
    //   print("Offline Data code Exceuted");
    //   Fluttertoast.showToast(msg: results.items.toString());
    //   print(results);
    //   return results;
    // }
     //   try {
    //     if (await quoteHiveController.retriveData() != null) {
    //       Map<String, dynamic> jsonParsed =
    //           json.decode(await quoteHiveController.retriveData() as String);
    //       print("hive parsed: $jsonParsed");
    //       results = PostModel.fromJson(jsonParsed);
    //       for (int i = 0; i < results.items!.length; i++) {
    //         results.items![i].content = results.items![i].content!
    //             .replaceAll(RegExp(r'<script>|</script>'), "");
    //       }
    //       print("else Hive code Exceuted");
    //       Fluttertoast.showToast(msg: "Fetched from hive");

    //       return results;
    //     }
    //   } catch (e) {
    //     results = await http.getQuotes(url);
    //     showToast(debug, "Fetched from Internet");
    //     return results;
    //   }

    //   return offlineFetch();

    //   // return offlineFetch();
    // }