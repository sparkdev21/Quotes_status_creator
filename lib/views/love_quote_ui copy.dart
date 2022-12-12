// import 'dart:convert';

// import 'package:blogger_json_example/models/love_quotes_english.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../models/post_list_model.dart';
// class LoveQuotePage extends StatelessWidget {
//   //Enter Your API key
//   // final String apiKey = 'AIzaSyAD3g-Y69XEhLMxmTdrZ6DvPVdGPkeurB8';
//   final String apiKey = 'AIzaSyCouAelkFCXYxL9QM45RZLMzbo9O6Ac4Rw';
//   //Enter your Blog Id here
//   // final String blogId = '5028934898989604741';
//   final String blogId = '2291870846384972971';

//   //Function for Fetching Posts
//   Future<List<LoveQuoteEnglish>> fetchPosts() async {
//     var postListUrl = Uri.https(
//         "blogger.googleapis.com", "/v3/blogs/$blogId/posts/", {"key": apiKey});
//     final response = await http.get(postListUrl);
//     if (response.statusCode == 200) {
//       final postList = PostList.fromJson(jsonDecode(response.body));
//       var content = postList.posts[0].content.replaceAll(RegExp(r'<script>|</script>')  , "");
//  List jsonResponse = json.decode(content);
//   return jsonResponse.map((job) => new LoveQuoteEnglish.fromJson(job)).toList();
//     } else {
//       throw Exception();
//     } 
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Post List"),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<List<LoveQuoteEnglish>>(
//           // : null,
//           future: fetchPosts(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (context, index) {
//                   final postlist = LoveQuoteEnglish();
//                   return Card(
//                     child: ListTile(
//                       title: Text(
//                         // postlist.posts[index].url\
//                         snapshot.data[index]?.msg?? "no items",
//                       ),
//                       subtitle: Text(
//                           postlist.submit ??
//                               "No Auther"),
//                     ),
//                   );
//                 },
//               );
//           }),
//     );
//   }
// }
