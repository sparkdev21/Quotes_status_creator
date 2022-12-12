import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';

import '../Constants/keys.dart';
import '../Controllers/OfflineHiveDataControllers.dart';
import '../Network/Exceptions.dart';
import '../models/post_list_model.dart';
import 'package:http/http.dart' as http;

Future<PostModel> fetchPosts() async {
  PostModel results = PostModel();
  OfflineHiveDataController quoteHiveController = OfflineHiveDataController();
  try {
    var postListUrl = Uri.https(
        "blogger.googleapis.com", "/v3/blogs/$blogId/posts/", {"key": apiKey});
    final response = await http.get(postListUrl).timeout(Duration(seconds: 3));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonParsed = json.decode(response.body);

      results = PostModel.fromJson(jsonParsed);
      for (int i = 0; i < results.items!.length; i++) {
        results.items![i].content = results.items![i].content!
            .replaceAll(RegExp(r'<script>|</script>'), "");
      }

      quoteHiveController.storeData(response.body);

      return results;
    } else {
      print("else Exceuted");

      throw Exception();
    }
  } on SocketException catch (e) {
    throw NoInternetException('No Internet:$e');
  } on TimeoutException catch (e) {
    if (await quoteHiveController.retriveData() != null) {
      Map<String, dynamic> jsonParsed =
          json.decode(await quoteHiveController.retriveData() as String);
      // print(jsonParsed);
      results = PostModel.fromJson(jsonParsed);
      for (int i = 0; i < results.items!.length; i++) {
        results.items![i].content = results.items![i].content!
            .replaceAll(RegExp(r'<script>|</script>'), "");
      }
      return results;
    } else {
      Fluttertoast.showToast(msg: "Delay To Fetch Slow Internet");
      // throw DelayTimeoutException('Delayed Fetched$e');
    }
    throw NoInternetException('No Internet:$e');

    // throw DelayTimeoutException('Couldnot Fetch in Time:$e');
  } on HttpException {
    throw NoServiceFoundException('No Service Found');
  } on FormatException {
    throw InvalidFormatException('Invalid Data Format');
  } catch (e) {
    if (await quoteHiveController.retriveData() != null) {
      Map<String, dynamic> jsonParsed =
          json.decode(await quoteHiveController.retriveData() as String);
      // print(jsonParsed);
      results = PostModel.fromJson(jsonParsed);
      for (int i = 0; i < results.items!.length; i++) {
        results.items![i].content = results.items![i].content!
            .replaceAll(RegExp(r'<script>|</script>'), "");
      }
      return results;
    } else {
      Fluttertoast.showToast(msg: "No Internet");
      throw NoInternetException('No Internet:$e');
    }

    throw UnknownException(e.toString());
  } finally {
    http.Client().close();
  }
}

// final quotesRepositoryProvider = Provider((ref) => QuotesRepository());

// final quotesProvider = FutureProvider<List<QuotesModel>?>((ref) {
//   // access the provider above
//   final repository = ref.watch(quotesRepositoryProvider);
//   // use it to return a Future
//   return repository.fetchQuotes(2);
// });
// final postRepositoryProvider = Provider((ref) => BlogRepository());

// final postProvider = FutureProvider.autoDispose<List<PostModel>>((ref) {
//   // access the provider above
//   final repository = ref.watch(postRepositoryProvider);
//   // use it to return a Future
//   return repository.fetchPosts();
// });
