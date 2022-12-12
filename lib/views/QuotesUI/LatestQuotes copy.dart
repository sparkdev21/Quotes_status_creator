// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../models/love_quotes_english.dart';
// import '../../models/post_list_model.dart';
// import '../../post_list_view_hive_data.dart';
// import '../Category_quote_detail_page.dart';
// import '../ParalelEffect/parallelx_effect.dart';

// class LatestQuotes extends ConsumerWidget {
//   final imagesx = "https://docs.flutter.dev/assets/images/404/dash_nest.png";

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<PostModel> locationd = ref.watch(blogProvider);
//     return Material(
//       child: Column(children: [
//         Padding(
//           padding: EdgeInsets.only(top: 24),
//           child: Align(
//             alignment: Alignment.center,
//             child: const Text("Latest Categories",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//           ),
//         ),
//         Flexible(
//           child: locationd.when(
//               loading: () => Center(child: const CircularProgressIndicator()),
//               error: (error, stack) =>
//                   Center(child: const Text('Unknow Error')),
//               data: (datas) {
//                 return ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemCount: datas.items!.length,
//                     itemBuilder: (context, int i) {
//                       PostModel posts = datas;
//                       DateTime dt1 = DateTime.parse(posts.items![0].published!);
//                       DateTime dt2 = DateTime.parse(posts.items![1].published!);
//                       print("d1:$dt1:dt2:$dt2");

//                       if (i < 5 && dt1.compareTo(dt2) > 0) {
//                         List gb = json.decode(posts.items![i].content!);
//                         var quotes =
//                             gb.map((e) => new QuotesModel.fromJson(e)).toList();

//                         return Stack(
//                           children: [
//                             LocationListItem(
//                                 onTap: () => Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             CategoryQuoteDetailPage(
//                                                 i,
//                                                 posts.items![i].title!,
//                                                 quotes))),
//                                 imageUrl: quotes[0].image!,
//                                 name: datas.items![i].title!,
//                                 country: quotes[0].content!.length.toString()),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(18.0),
//                             //   child: Align(
//                             //     alignment: Alignment.topLeft,
//                             //     child: Banner(
//                             //         message: "New",
//                             //         location: BannerLocation.topStart),
//                             //   ),
//                             // ),
//                           ],
//                         );
//                       }
//                       return SizedBox.shrink();
//                     });
//               }),
//         ),
//       ]),
//     );
//   }
// }
