// import 'dart:convert';
// import 'package:blogger_json_example/views/Editor/SingleEditor.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/rendering.dart';
// import 'package:blogger_json_example/Controllers/OfflineHiveDataControllers.dart';
// import 'package:blogger_json_example/Controllers/QuotesController.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'models/love_quotes_english.dart';
// import 'models/post_list_model.dart';
// import 'repositories/Blog/blog_fetch_repository.dart';
// import 'views/Category_quote_detail_page.dart';

// final blogRepositoryProvider = Provider((ref) => BlogRepository());

// final blogProvider = FutureProvider<PostModel>((ref) {
//   // access the provider above
//   final repository = ref.watch(blogRepositoryProvider);
//   // use it to return a Future
//   return repository.fetchPosts();
// });

// class PostHiveData extends ConsumerWidget {
//   final Function(bool) isHideBottomNavBar;

//   PostHiveData({Key? key, required this.isHideBottomNavBar}) : super(key: key);
//   bool _handleScrollNotification(ScrollNotification notification) {
//     if (notification.depth == 0) {
//       if (notification is UserScrollNotification) {
//         final UserScrollNotification userScroll = notification;
//         switch (userScroll.direction) {
//           case ScrollDirection.forward:
//             isHideBottomNavBar(true);
//             break;
//           case ScrollDirection.reverse:
//             isHideBottomNavBar(false);
//             break;
//           case ScrollDirection.idle:
//             break;
//         }
//       }
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<PostModel> quotes = ref.watch(blogProvider);

//     return NotificationListener<ScrollNotification>(
//       onNotification: _handleScrollNotification,
//       child: Scaffold(
//           appBar: AppBar(
//             actions: [
//               IconButton(
//                   onPressed: () async {
//                     OfflineHiveDataController().clearAll();
//                     QuotesController().clearAll();
//                   },
//                   icon: Icon(Icons.delete)),
//               IconButton(
//                   onPressed: () async {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: ((context) => SimpleEditorPage(
//                                 title: "Edit page",
//                                 quote: "hello Mr How Rae u"))));
//                   },
//                   icon: Icon(Icons.format_quote_sharp))
//             ],
//             title: Text("Post List"),
//             centerTitle: true,
//           ),
//           body: quotes.when(
//               loading: () => Center(child: const CircularProgressIndicator()),
//               error: (error, stack) => Center(child: const Text('Oopsies')),
//               data: (quotes) => ListView.builder(
//                   //                   final title = snapshot.data!.items![index].title;

//                   itemCount: quotes.items!.length,
//                   itemBuilder: (context, index) {
//                     PostModel posts = quotes;
//                     List gb = json.decode(quotes.items![index].content!);
//                     var datas =
//                         gb.map((e) => new QuotesModel.fromJson(e)).toList();
//                     // datas.shuffle();

//                     return Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         CategoryQuoteDetailPage(
//                                             index,
//                                             posts.items![index].title!,
//                                             datas)));
//                           },
//                           child: Card(
//                             elevation: 2.0,
//                             color: Colors.green.shade100,
//                             child: ListTile(
//                               trailing: SizedBox(
//                                   height: 100,
//                                   width: 100,
//                                   child: CachedNetworkImage(
//                                     imageUrl: datas[0].image!,
//                                   )

//                                   //  realImage.Image.network(
//                                   //   datas[0].image!,
//                                   //   key: UniqueKey(),
//                                   //   fit: BoxFit.cover,
//                                   // ),
//                                   ),
//                               title: Text(
//                                 // postlist.posts[index].
//                                 quotes.items![index].title!,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               subtitle: Text(
//                                 quotes.items![index].author!.displayName!,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }))),
//     );
//   }
// }
