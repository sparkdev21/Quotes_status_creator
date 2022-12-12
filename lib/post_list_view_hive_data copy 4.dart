// import 'dart:convert';
// import './providers/QuotesUINotifier.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'models/love_quotes_english.dart';
// import 'models/post_list_model.dart';
// import 'repositories/Blog/blog_fetch_repository.dart';
// import 'views/QuotesUI/category_listile.dart';

// final blogRepositoryProvider = Provider.autoDispose((ref) => BlogRepository());

// final blogProvider = FutureProvider.autoDispose<PostModel>((ref) {
//   // access the provider above
//   final repository = ref.watch(blogRepositoryProvider);
//   // use it to return a Future
//   return repository.fetchPosts();
// });

// final managedblogProvider = FutureProvider.autoDispose<PostModel>((ref) {
//   // access the provider above
//   final repository = ref.watch(blogRepositoryProvider);
//   // use it to return a Future
//   final datas = repository.fetchPosts();

//   List<List<QuotesModel>> quotesList = [];
//   List<String> titles = [];
//   datas.then((quotes) {
//     ref.read(mainQuotesProvider.notifier).setPostData(quotes);

//     for (int i = 0; i < quotes.items!.length; i++) {
//       print("GG:${quotes.items![i].title!}");
//       print("GGi:${quotes.items!.length}");
//       titles.add(quotes.items![i].title!);
//       List gb = json.decode(quotes.items![i].content!) as List;

//       print("GG:${gb.runtimeType}"); //returns List<dynamic>
//       List<QuotesModel> imagesList =
//           gb.map((e) => QuotesModel.fromJson(e)).toList();

//       quotesList.add(imagesList);

//       print("GG:${quotesList.length}");
//     }

//     ref.read(mainQuotesProvider.notifier).setMainQuotes(quotesList);
//     ref.read(mainQuotesProvider.notifier).setQuotesCategories(titles);
//     print("quotesList:Hello");
//   }
//       // return (quotesList.map((e)=>QuotesModel.fromJson(e).toList()));
//       );

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
//     ref.watch(mainQuotesProvider);
//     final cat = ref.watch(mainQuotesProvider.notifier).categories;
//     final datas = ref.watch(mainQuotesProvider.notifier).mainQuotes;

//     return Flexible(
//       child: ListView.separated(
//           primary: false,
//           shrinkWrap: true,
//           separatorBuilder: (context, index) => SizedBox(
//                 height: 1,
//               ),
//           itemCount: cat.length,
//           itemBuilder: (context, index) {
//             print("category:${cat[index]}");
//             final category = cat[index];
//             final quotesList = datas[index];

//             return CategoryListTile(
//               category: category,
//               quotes: quotesList,
//             );
//           }),
//     );
//   }
// }
