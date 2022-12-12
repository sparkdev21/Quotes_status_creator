// import 'dart:convert';
// import 'package:blogger_json_example/providers/QuotesUINotifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'models/love_quotes_english.dart';
// import 'models/post_list_model.dart';
// import 'repositories/Blog/blog_fetch_repository.dart';
// import 'views/QuotesUI/category_listile.dart';

// final blogRepositoryProvider = Provider((ref) => BlogRepository());

// final blogProvider = FutureProvider<PostModel>((ref) {
//   // access the provider above
//   final repository = ref.watch(blogRepositoryProvider);
//   // use it to return a Future
//   return repository.fetchPosts();
// });

// final managedblogProvider = FutureProvider<PostModel>((ref) {
//   // access the provider above
//   final repository = ref.watch(blogRepositoryProvider);
//   // use it to return a Future
//   final datas = repository.fetchPosts();

//   List quotesList = [];
//   List<String> titles = [];

//   datas.then((quotes) {
//     for (int i = 0; i < quotes.items!.length; i++) {
//       print("quotesListTitle:${quotes.items![i].title!}");
//       titles.add(quotes.items![i].title!);
//       List gb = json.decode(quotes.items![i].content!);

//       print("quotesListDatas:$gb");
//       quotesList.add(gb);
//     }

//     print("quotesList:${quotesList.length}");
//   }
//       // return (quotesList.map((e)=>QuotesModel.fromJson(e).toList()));
//       );
//   final postData = quotesList.map((e) => new QuotesModel.fromJson(e)).toList();
//   ref.read(mainQuotesProvider.notifier).setMainQuotes(postData);
//   ref.read(mainQuotesProvider.notifier).setQuotesCategories(titles);

//   return datas;
// });

// class PostHiveData extends ConsumerWidget {
//   PostHiveData({Key? key}) : super(key: key);
//   // bool _handleScrollNotification(ScrollNotification notification) {
//   //   if (notification.depth == 0) {
//   //     if (notification is UserScrollNotification) {
//   //       final UserScrollNotification userScroll = notification;
//   //       switch (userScroll.direction) {
//   //         case ScrollDirection.forward:
//   //           isHideBottomNavBar(true);
//   //           break;
//   //         case ScrollDirection.reverse:
//   //           isHideBottomNavBar(false);
//   //           break;
//   //         case ScrollDirection.idle:
//   //           break;
//   //       }
//   //     }
//   //   }
//   //   return false;
//   // }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<PostModel> quotes = ref.watch(managedblogProvider);

//     return quotes.when(
//         loading: () => Center(child: const CircularProgressIndicator()),
//         error: (error, stack) => Center(child: const Text('Oopsies')),
//         data: (quotes) => Flexible(
//               child: ListView.separated(
//                   primary: false,
//                   shrinkWrap: true,
//                   separatorBuilder: (context, index) => SizedBox(
//                         height: 1,
//                       ),
//                   itemCount: quotes.items!.length,
//                   itemBuilder: (context, index) {
//                     PostModel posts = quotes;
//                     List gb = json.decode(quotes.items![index].content!);
//                     var datas =
//                         gb.map((e) => new QuotesModel.fromJson(e)).toList();
//                     // datas.shuffle();
//                     final category = posts.items![index].title!;
//                     final quotesList = datas;

//                     return CategoryListTile(
//                       category: category,
//                       quotes: quotesList,
//                     );
//                   }),
//             ));
//   }
// }
