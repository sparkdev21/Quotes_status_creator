// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:fluttertoast/fluttertoast.dart';
// import '../../Network/Api/Api.dart';

// import '../../Constants/keys.dart';
// import '../../Controllers/OfflineHiveDataControllers.dart';
// import '../../Network/Exceptions.dart';
// import '../../models/post_list_model.dart';

// class BlogRepository {
//   Future<PostModel> fetchPosts() async {
//     PostModel results = PostModel();
//     final HttpClient http = HttpClient();

//     OfflineHiveDataController quoteHiveController = OfflineHiveDataController();
//     try {
//       var postListUrl = Uri.https("blogger.googleapis.com",
//           "/v3/blogs/$blogId/posts/", {"key": apiKey});
//       final response =
//           await http.getRequest(postListUrl).timeout(Duration(seconds: 12));
//       if (response.statusCode == 200) {
//         Map<String, dynamic> jsonParsed = json.decode(response.body);

//         results = PostModel.fromJson(jsonParsed);
//         for (int i = 0; i < results.items!.length; i++) {
//           results.items![i].content = results.items![i].content!
//               .replaceAll(RegExp(r'<script>|</script>'), "");
//         }

//         quoteHiveController.storeData(response.body);
//         print("Fetched from website");
//         Fluttertoast.showToast(msg: "Fetched from website");

//         return results;
//       } else {
//         if (await quoteHiveController.retriveData() != null) {
//           Map<String, dynamic> jsonParsed =
//               json.decode(await quoteHiveController.retriveData() as String);
//           // print(jsonParsed);
//           results = PostModel.fromJson(jsonParsed);
//           for (int i = 0; i < results.items!.length; i++) {
//             results.items![i].content = results.items![i].content!
//                 .replaceAll(RegExp(r'<script>|</script>'), "");
//           }
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

//       Fluttertoast.showToast(msg: "Socket exception:$e");
//       if (await quoteHiveController.retriveData() != null) {
//         Map<String, dynamic> jsonParsed =
//             json.decode(await quoteHiveController.retriveData() as String);
//         // print(jsonParsed);
//         results = PostModel.fromJson(jsonParsed);
//         for (int i = 0; i < results.items!.length; i++) {
//           results.items![i].content = results.items![i].content!
//               .replaceAll(RegExp(r'<script>|</script>'), "");
//         }
//         return results;
//       } else {
//         Fluttertoast.showToast(msg: "Socket Exception else :$e");
//       }
//       throw DelayTimeoutException('Socket  Fetched$e');
//     } on TimeoutException catch (e) {
//       if (await quoteHiveController.retriveData() != null) {
//         Map<String, dynamic> jsonParsed =
//             json.decode(await quoteHiveController.retriveData() as String);
//         // print(jsonParsed);
//         results = PostModel.fromJson(jsonParsed);
//         for (int i = 0; i < results.items!.length; i++) {
//           results.items![i].content = results.items![i].content!
//               .replaceAll(RegExp(r'<script>|</script>'), "");
//         }
//         return results;
//       } else {
//         Fluttertoast.showToast(msg: "Delay To Fetch Slow Internet");
//         // throw DelayTimeoutException('Delayed Fetched$e');
//       }
//       throw NoInternetException('No Internet:$e');

//       // throw DelayTimeoutException('Couldnot Fetch in Time:$e');
//     } on HttpException {
//       throw NoServiceFoundException('No Service Found');
//     } on FormatException {
//       throw InvalidFormatException('Invalid Data Format');
//     } catch (e) {
//       if (await quoteHiveController.retriveData() != null) {
//         Map<String, dynamic> jsonParsed =
//             json.decode(await quoteHiveController.retriveData() as String);
//         // print(jsonParsed);
//         results = PostModel.fromJson(jsonParsed);
//         for (int i = 0; i < results.items!.length; i++) {
//           results.items![i].content = results.items![i].content!
//               .replaceAll(RegExp(r'<script>|</script>'), "");
//         }
//         Fluttertoast.showToast(msg: "Fetched from catch hive");

//         return results;
//       } else {
//         Fluttertoast.showToast(msg: "Unknow Server Failure Error");
//         throw NoInternetException('No Internet:$e');
//       }
//     }
//   }
// }
