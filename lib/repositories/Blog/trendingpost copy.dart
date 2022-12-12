// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import '../../Network/Api/Api.dart';
// import '/models/TrendingModel.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../../Constants/keys.dart';
// import '../../Controllers/OfflineHiveDataControllers.dart';
// import '../../Network/Exceptions.dart';

// class TrendinRepository {
//   Future<TrendingModel> fetchPosts() async {
//     final HttpClient http = HttpClient();

//     TrendingModel results = TrendingModel();
//     OfflineHiveDataController quoteHiveController = OfflineHiveDataController();
//     try {
//       var postListUrl = Uri.https("blogger.googleapis.com",
//           "/v3/blogs/$blogId/pages/$trendingPageId/", {"key": apiKey});
//       final response =
//           await http.getRequest(postListUrl).timeout(Duration(seconds: 10));
//       if (response.statusCode == 200) {
//         Map<String, dynamic> jsonParsed = json.decode(response.body);

//         results = TrendingModel.fromJson(jsonParsed);

//         results.content =
//             results.content!.replaceAll(RegExp(r'<script>|</script>'), "");
//         print("results:$results");

//         quoteHiveController.storeTrendingData(response.body);
//         print("Fetched from website");
//         Fluttertoast.showToast(msg: "Fetched from website");

//         return results;
//       } else {
//         if (await quoteHiveController.retriveTrendingData() != null) {
//           Map<String, dynamic> jsonParsed = json.decode(
//               await quoteHiveController.retriveTrendingData() as String);
//           // print(jsonParsed);
//           results = TrendingModel.fromJson(jsonParsed);
//           results.content =
//               results.content!.replaceAll(RegExp(r'<script>|</script>'), "");
//           print("else Hive code Exceuted");
//           Fluttertoast.showToast(msg: "Fetched from hive");

//           return results;
//         } else {
//           Fluttertoast.showToast(msg: "Internal Server Error Couldnot fetch");
//           print("else No hive Data Exceuted");

//           // throw DelayTimeoutException('Delayed Fetched$e');
//         }

//         throw Exception();
//       }
//     } on SocketException catch (e) {
//       print("socket exception");

//       Fluttertoast.showToast(msg: "Socket exception no int :$e");
//       if (await quoteHiveController.retriveTrendingData() != null) {
//         Map<String, dynamic> jsonParsed = json
//             .decode(await quoteHiveController.retriveTrendingData() as String);
//         // print(jsonParsed);
//         results = TrendingModel.fromJson(jsonParsed);
//         results.content =
//             results.content!.replaceAll(RegExp(r'<script>|</script>'), "");
//         return results;
//       } else {
//         Fluttertoast.showToast(msg: "Socket Exception else :$e");
//       }
//       throw DelayTimeoutException('Socket  Fetched$e');
//     } catch (e) {
//       if (await quoteHiveController.retriveTrendingData() != null) {
//         Map<String, dynamic> jsonParsed = json
//             .decode(await quoteHiveController.retriveTrendingData() as String);
//         // print(jsonParsed);
//         results = TrendingModel.fromJson(jsonParsed);
//         results.content =
//             results.content!.replaceAll(RegExp(r'<script>|</script>'), "");
//         Fluttertoast.showToast(msg: "Fetched from catch hive");

//         return results;
//       } else {
//         Fluttertoast.showToast(msg: "Unknow Server Failure Error");
//         throw NoInternetException('No Internet:$e');
//       }
//     }
//   }
// }
