import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:quotes_status_creator/models/post_list_model.dart';

import '../repositories/Blog/Data/blogdata.dart';

class ItemsMapper {
  ItemsMapper();

  Future<PostModel> fetchInBackground(String encodeJson) {
    return compute(_parseJson, encodeJson);
  }

  PostModel _parseJson(String encodedJson) {
    final jsonParsed = jsonDecode(encodedJson).cast<Map<String, dynamic>>();

    final results = PostModel.fromJson(jsonParsed);
    for (int i = 0; i < results.items!.length - 1; i++) {
      results.items![i].content = results.items![i].content!
          .replaceAll(RegExp(r'<script>|</script>'), "");
      print("Executing hive isolates");
    }
    print("Executing : $results");

    return results;
  }
}

class BlogRepositoryParser {
  final String encodedJson;
  BlogRepositoryParser(this.encodedJson);

  Future<PostModel> fetchInOffline(Map<String, Object> offlineJson) async {
    final port = ReceivePort();
    await Isolate.spawn(_parseListOfJson, port.sendPort);
    return await port.first;
  }

  Future<PostModel> fetchGeneral() async {
    final port = ReceivePort();
    await Isolate.spawn(_parseJson, port.sendPort);
    return await port.first;
  }

  List<void> _parseJson(SendPort port) {
    Map<String, dynamic> jsonParsed = jsonDecode(encodedJson);

    final results = PostModel.fromJson(jsonParsed);
    for (int i = 0; i < results.items!.length; i++) {
      results.items![i].content = results.items![i].content!
          .replaceAll(RegExp(r'<script>|</script>'), "");
      print("Executing hive isolates");
    }
    print("Executing: $results");

    Isolate.exit(port, results);
  }

  List<void> _parseListOfJson(SendPort port) {
    final results = PostModel.fromJson(offlineRealblogData);
    for (int i = 0; i < results.items!.length; i++) {
      results.items![i].content = results.items![i].content!
          .replaceAll(RegExp(r'<script>|</script>'), "");
      print("Executing");
    }

    Isolate.exit(port, results);
  }
}


// class APIServices{
// Future<List<UserModel>> downloadAndParseJson()async{
//   final response = await http.get(Uri.parse(GET_URL));
//   if(response.statusCode == 200){
//     final userModelParser = BlogRepositoryParser();
//     return userModelParser.fetchInBackground(response.body);
//   }
//   else{
//     throw Exception('Failed to fetch data from the API');
//   }
//  }
// }