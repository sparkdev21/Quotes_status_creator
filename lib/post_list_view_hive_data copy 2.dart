// import 'dart:convert';
// import 'package:blogger_json_example/views/QuotesUI/Dashboard.dart';
// import 'package:blogger_json_example/views/QuotesUI/category_listile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'models/love_quotes_english.dart';
// import 'models/post_list_model.dart';
// import 'repositories/Blog/blog_fetch_repository.dart';

// final blogRepositoryProvider = Provider.autoDispose((ref) => BlogRepository());

// final blogProvider = FutureProvider.autoDispose<PostModel>((ref) {
//   // access the provider above
//   final repository = ref.watch(blogRepositoryProvider);
//   // use it to return a Future
//   return repository.fetchPosts();
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
//     AsyncValue<PostModel> quotes = ref.watch(blogProvider);

//     return quotes.when(
//         loading: () => Center(child: const CircularProgressIndicator()),
//         error: (error, stack) => Center(child: const Text('Oopsies')),
//         data: (quotes) => ListView.separated(
//             separatorBuilder: (context, index) => SizedBox(
//                   height: 1,
//                 ),
//             itemCount: quotes.items!.length,
//             itemBuilder: (context, index) {
//               PostModel posts = quotes;
//               List gb = json.decode(quotes.items![index].content!);
//               var datas = gb.map((e) => new QuotesModel.fromJson(e)).toList();
//               // datas.shuffle();
//               final category = posts.items![index].title!;
//               final quotesList = datas;

//               return TestPage(
//                 category: category,
//                 quotes: quotesList,
//               );
//               //  CategoryListTile(
//               //   category: category,
//               //   quotes: quotesList,
//               // );
//             }));
//   }
// }
