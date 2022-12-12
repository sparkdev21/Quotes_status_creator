import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Controllers/OfflineHiveDataControllers.dart';
import 'Network/Exceptions.dart';
import 'models/HiveModel/hive_quote_data_model.dart';
import 'models/love_quotes_english.dart';
import 'models/post_list_model.dart';

class PostListPage extends StatelessWidget {
  //Enter Your API key
  // final String apiKey = 'AIzaSyAD3g-Y69XEhLMxmTdrZ6DvPVdGPkeurB8';
  final String apiKey = 'AIzaSyCouAelkFCXYxL9QM45RZLMzbo9O6Ac4Rw';
  //Enter your Blog Id here
  // final String blogId = '5028934898989604741';
  final String blogId = '2291870846384972971';

  //Function for Fetching Posts
  Future<PostModel> fetchPosts() async {
    PostModel results = PostModel();
    OfflineHiveDataController quoteHiveController = OfflineHiveDataController();
    try {
      var postListUrl = Uri.https("blogger.googleapis.com",
          "/v3/blogs/$blogId/posts/", {"key": apiKey});
      final response = await http.get(postListUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonParsed = json.decode(response.body);

        results = PostModel.fromJson(jsonParsed);
        for (int i = 0; i < results.items!.length; i++) {
          results.items![i].content = results.items![i].content!
              .replaceAll(RegExp(r'<script>|</script>'), "");

          HiveQuoteDataModel datas = HiveQuoteDataModel(
            category: results.items![i].title!,
            language: i.isOdd ? "hindi" : "english",
            quote: results.items![i].content!,
            isFavourite: false,
          );
          // quoteHiveController.putData(datas);
        }

        return results;
      } else {
        print('Request failed with status: ${response.statusCode}');

        throw Exception();
      }
    } on SocketException catch (e) {
      throw NoInternetException('No Internet:$e');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                OfflineHiveDataController().clearAll();
              },
              icon: const Icon(Icons.delete))
        ],
        title: const Text("Post List"),
        centerTitle: true,
      ),
      body: FutureBuilder<PostModel>(
          future: fetchPosts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.items!.length,
                itemBuilder: (context, index) {
                  final title = snapshot.data!.items![index].title;
                  // List jsons = jsonDecode(snapshot.data!.items![index].content.toString());
                  List gb = json.decode(snapshot.data!.items![index].content!);
                  var datas = gb.map((e) => QuotesModel.fromJson(e)).toList();

                  return Card(
                    child: GestureDetector(
                      onTap: () async {
                        // Fluttertoast.showToast(
                        //     msg: "This is Center Short Toast",
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.CENTER,
                        //     timeInSecForIosWeb: 1,
                        //     backgroundColor: Colors.red,
                        //     textColor: Colors.white,
                        //     fontSize: 16.0);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             QuoteDetailPage(index, title!, datas)));
                      },
                      child: ListTile(
                        title: Text(
                            // postlist.posts[index].
                            snapshot.data!.items![index].title!),
                        subtitle: Text(snapshot.data!.items![index].etag!),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
