import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes_status_creator/Network/Api/Dio/dio_api.dart';
import 'package:quotes_status_creator/repositories/Blog/helper.dart';

import '../../Constants/keys.dart';
import '../../Controllers/OfflineHiveDataControllers.dart';
import '../../models/post_list_model.dart';

class BlogRepository {
  Future<PostModel> fetchPosts() async {
    PostModel results = PostModel();
    final QuoteAPI http = QuoteAPI();

    OfflineHiveDataController quoteHiveController = OfflineHiveDataController();
    String url =
        'https://www.googleapis.com/blogger/v3/blogs/$blogId/posts?key=$apiKey';
    
    if (await quoteHiveController.retriveData() != null) {
      Map<String, dynamic> jsonParsed =
          json.decode(await quoteHiveController.retriveData() as String);
      // print(jsonParsed);
      results = PostModel.fromJson(jsonParsed);
      for (int i = 0; i < results.items!.length; i++) {
        results.items![i].content = results.items![i].content!
            .replaceAll(RegExp(r'<script>|</script>'), "");
      }
      print("else Hive code Exceuted");
      Fluttertoast.showToast(msg: "Fetched from hive");

      return results;
    } else {
      results = await http.getQuotes(url);
      showToast(debug, "Fetched from Internet");
      return results;
    }
  }
}
