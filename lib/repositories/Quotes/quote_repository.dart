import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/post_list_model.dart';
import '/repositories/Quotes/Data/quotesData.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '/models/love_quotes_english.dart';
import 'Data/quotesData copy.dart';

// final quotesRepositoryProvider = Provider((ref) => QuotesRepository());

// final quotesProvider = FutureProvider<List<QuotesModel>?>((ref) {
//   // access the provider above
//   final repository = ref.watch(quotesRepositoryProvider);
//   // use it to return a Future
//   return repository.fetchQuotes(2);
// });

class QuotesRepository {
  Future<List<QuotesModel>?> fetchQuotes(int index) async {
    debugPrint("Api ccalled");
    List offlineQuotes = [];
    List jsonResponse = [];
    // get data from the network or local database
    final String apiKey = 'AIzaSyCouAelkFCXYxL9QM45RZLMzbo9O6Ac4Rw';
    //Enter your Blog Id here
    // final String blogId = '5028934898989604741';
    final String blogId = '2291870846384972971';
    // "blogger.googleapis.com", "/v3/blogs/2291870846384972971/posts/
    try {
      var postListUrl = Uri.https("blogger.googleapis.com",
          "/v3/blogs/$blogId/posts/", {"key": apiKey});

      final response =
          await http.get(postListUrl).timeout(const Duration(seconds: 10));

      print("response:${response.statusCode}");
      if (response.statusCode == 200) {
        final postList = PostModel.fromJson(jsonDecode(response.body));
        var content = postList.items![0].content!
            .replaceAll(RegExp(r'<script>|</script>'), "");
        List jsonResponse = json.decode(content);
        return jsonResponse
            .map((job) => new QuotesModel.fromJson(job))
            .toList();
      } else {}
    } on TimeoutException catch (_) {
      final postList = PostModel.fromJson(offlineBloGdata);
      var content = postList.items![0].content!
          .replaceAll(RegExp(r'<script>|</script>'), "");

      jsonResponse = json.decode(content);
      jsonResponse.shuffle();
      return jsonResponse.map((job) => new QuotesModel.fromJson(job)).toList();
    } on SocketException catch (_) {
      debugPrint("socket Statement");
      jsonResponse = offlineblogData;
      return jsonResponse.map((job) => new QuotesModel.fromJson(job)).toList();
    } on Error {
      jsonResponse = offlineblogData;
      debugPrint("error Statement");
      return jsonResponse.map((job) => new QuotesModel.fromJson(job)).toList();
    } finally {
      http.Client().close();
    }
    return jsonResponse.map((job) => new QuotesModel.fromJson(job)).toList();
    
  }
}
