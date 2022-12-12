// import 'dart:convert';
// import 'dart:math' as math;

// import 'package:blogger_json_example/models/HiveModel/TrendingQuotesModel.dart';
// import 'package:blogger_json_example/models/TrendingModel.dart';
// import 'package:blogger_json_example/repositories/Blog/trendingpost.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gradient_colors/gradient_colors.dart';

// final trendingRepositoryProvider =
//     Provider.autoDispose((ref) => TrendinRepository());

// final trendingQuotesProvider =
//     FutureProvider.autoDispose<List<TrendingQuotesModel>>((ref) async {
//   // access the provider above
//   final repository = ref.watch(trendingRepositoryProvider);

//   // use it to return a Future
//   final datas = repository.fetchPosts();
//   List<TrendingQuotesModel> trendQuotes = [];
//   await datas.then((value) {
//     TrendingModel posts = value;

//     List gb = json.decode(posts.content!);
//     trendQuotes = gb.map((e) => new TrendingQuotesModel.fromJson(e)).toList();
//     print("trendQuotes:${trendQuotes.length}");
//   });
//   return trendQuotes;
// });

// class UserQuotesPage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<List<TrendingQuotesModel>> trendings =
//         ref.watch(trendingQuotesProvider);
//     print("trendings:$trendings");
//     return Material(
//       elevation: 2.0,
//       child: trendings.when(
//           loading: () => Center(child: const CircularProgressIndicator()),
//           error: (error, stack) => Center(child: const Text('Oopsies')),
//           data: (datas) {
//             return ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 itemCount: datas.length,
//                 itemBuilder: (context, int i) {
//                   return // Generated code for this Container Widget...
//                       Padding(
//                     padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
//                     child: Material(
//                       color: Colors.transparent,
//                       elevation: 2,
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.60,
//                         height: MediaQuery.of(context).size.height * 0.2,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16),
//                           gradient: LinearGradient(
//                               colors: GradientColors
//                                   .values[math.Random().nextInt(100)]),
//                           boxShadow: [
//                             BoxShadow(
//                               blurRadius: 12,
//                               color: Colors.green,
//                               offset: Offset(1, -3),
//                               spreadRadius: 1,
//                             )
//                           ],
//                           border: Border.all(
//                             color: Colors.blue,
//                             width: 1,
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             Banner(
//                                 message: "@ghanshyam",
//                                 color: Colors.pink.shade700,
//                                 location: BannerLocation.topStart),
//                             Align(
//                               alignment: AlignmentDirectional(-0.02, -1.5),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                       gradient: LinearGradient(
//                                           colors: GradientColors.values[
//                                               math.Random().nextInt(100)]),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color: Colors.green.shade700,
//                                             offset: Offset(2, 3))
//                                       ]),
//                                   child: Icon(Icons.star),
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: AlignmentDirectional(0, -0.3),
//                               child: Padding(
//                                 padding: EdgeInsetsDirectional.fromSTEB(
//                                     37, 1, 24, 4),
//                                 child: Text(
//                                   'If you look at what you have in life, you\'ll always have more. If you look at what you don\'t have in life, you\'ll never have enough',
//                                   textAlign: TextAlign.start,
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.bottomRight,
//                               child: Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       4, 4, 14, 14),
//                                   child: Text.rich(
//                                     TextSpan(
//                                       children: [
//                                         TextSpan(text: '@'),
//                                         TextSpan(
//                                           text: 'Ghanshyam',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );

//                   // return Padding(
//                   //   padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
//                   //   child: Container(
//                   //     decoration: BoxDecoration(
//                   //         borderRadius: BorderRadius.circular(12),
//                   //         gradient: LinearGradient(
//                   //             colors: GradientColors
//                   //                 .values[math.Random().nextInt(100)]),
//                   //         boxShadow: [
//                   //           BoxShadow(
//                   //               color: Colors.green.shade700,
//                   //               offset: Offset(2, 3))
//                   //         ]),
//                   //     child: ListTile(
//                   //       title: Row(
//                   //         children: [
//                   //           Align(
//                   //             alignment: Alignment.topLeft,
//                   //             child: Padding(
//                   //               padding: const EdgeInsets.all(8.0),
//                   //               child: Container(
//                   //                 decoration: BoxDecoration(
//                   //                     borderRadius: BorderRadius.circular(12),
//                   //                     gradient: LinearGradient(
//                   //                         colors: GradientColors.values[
//                   //                             math.Random().nextInt(100)]),
//                   //                     boxShadow: [
//                   //                       BoxShadow(
//                   //                           color: Colors.green.shade700,
//                   //                           offset: Offset(2, 3))
//                   //                     ]),
//                   //                 child: Icon(Icons.star),
//                   //               ),
//                   //             ),
//                   //           ),
//                   //           Flexible(
//                   //             child: AutoSizeText(
//                   //               "Sit nisi tempor nisi fugiat amet. Anim esse velit magna aute sit laboris ,mollit anim ullamco non cillum. Tempor magna ea duis tempor esse aliqua. Laborum id ullamco ex officia sunt proident do incididunt magna ut id aliquip. Cupidatat do velit labore qui incididunt pariatur ad labore voluptate. Elit deserunt tempor est proident Lorem dolore sit laborum pariatur mollit.",
//                   //               maxLines: 5,
//                   //               overflow: TextOverflow.ellipsis,
//                   //               style: TextStyle(color: Colors.white),
//                   //             ),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //       subtitle: Align(
//                   //           alignment: Alignment.bottomRight,
//                   //           child: Text("@${datas[i].category}")),
//                   //     ),
//                   //   ),
//                   // );
//                 });
//           }),
//     );
//   }
// }
