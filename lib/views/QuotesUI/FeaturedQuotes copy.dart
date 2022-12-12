// import 'dart:convert';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:blogger_json_example/models/HiveModel/TrendingQuotesModel.dart';
// import 'package:blogger_json_example/models/TrendingModel.dart';
// import 'package:blogger_json_example/repositories/Blog/featuredPost.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gradient_colors/gradient_colors.dart';

// import 'flutter_flow_theme.dart';

// final featuredRepositoryProvider = Provider((ref) => FeaturedRepository());

// final featuredQuotesProvider =
//     FutureProvider<List<TrendingQuotesModel>>((ref) async {
//   // access the provider above
//   final repository = ref.watch(featuredRepositoryProvider);

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

// class FeaturedPage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<List<TrendingQuotesModel>> trendings =
//         ref.watch(featuredQuotesProvider);
//     print("featured:$trendings");
//     return Material(
//       elevation: 2.0,
//       color: Theme.of(context).scaffoldBackgroundColor,
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height * 0.28,
//         child: trendings.when(
//             loading: () => Center(child: const CircularProgressIndicator()),
//             error: (error, stack) => Center(child: const Text('Oopsies')),
//             data: (datas) {
//               return ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemCount: datas.length,
//                   itemBuilder: (context, int i) {
//                     return Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.45,
//                         height: MediaQuery.of(context).size.height * 0.28,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(color: Colors.red, offset: Offset(2, 3))
//                             ],
//                             gradient: LinearGradient(
//                                 colors: GradientColors.royalBlack)),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(4),
//                               child: AutoSizeText(
//                                 datas[i].quote!,
//                                 maxFontSize: 18,
//                                 textAlign: TextAlign.center,
//                                 style: FlutterFlowTheme.of(context)
//                                     .title1
//                                     .override(
//                                       fontFamily: 'Lexend Deca',
//                                       fontSize: 15,
//                                     ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   AutoSizeText(
//                                     "- ${datas[i].author!}",
//                                     style: FlutterFlowTheme.of(context)
//                                         .bodyText1
//                                         .override(
//                                           fontFamily: 'Lexend Deca',
//                                           color: FlutterFlowTheme.of(context)
//                                               .primaryText,
//                                         ),
//                                   ),

//                                   // Icon(Icons.format_quote_sharp),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );

//                     // Generated code for this Container Widget...

//                     // return Padding(
//                     //   padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
//                     //   child: Container(
//                     //     decoration: BoxDecoration(
//                     //         borderRadius: BorderRadius.circular(12),
//                     //         gradient: LinearGradient(
//                     //             colors: GradientColors
//                     //                 .values[math.Random().nextInt(100)]),
//                     //         boxShadow: [
//                     //           BoxShadow(
//                     //               color: Colors.green.shade700,
//                     //               offset: Offset(2, 3))
//                     //         ]),
//                     //     child: ListTile(
//                     //       title: Row(
//                     //         children: [
//                     //           Align(
//                     //             alignment: Alignment.topLeft,
//                     //             child: Padding(
//                     //               padding: const EdgeInsets.all(8.0),
//                     //               child: Container(
//                     //                 decoration: BoxDecoration(
//                     //                     borderRadius: BorderRadius.circular(12),
//                     //                     gradient: LinearGradient(
//                     //                         colors: GradientColors.values[
//                     //                             math.Random().nextInt(100)]),
//                     //                     boxShadow: [
//                     //                       BoxShadow(
//                     //                           color: Colors.green.shade700,
//                     //                           offset: Offset(2, 3))
//                     //                     ]),
//                     //                 child: Icon(Icons.star),
//                     //               ),
//                     //             ),
//                     //           ),
//                     //           Flexible(
//                     //             child: AutoSizeText(
//                     //               "Sit nisi tempor nisi fugiat amet. Anim esse velit magna aute sit laboris ,mollit anim ullamco non cillum. Tempor magna ea duis tempor esse aliqua. Laborum id ullamco ex officia sunt proident do incididunt magna ut id aliquip. Cupidatat do velit labore qui incididunt pariatur ad labore voluptate. Elit deserunt tempor est proident Lorem dolore sit laborum pariatur mollit.",
//                     //               maxLines: 5,
//                     //               overflow: TextOverflow.ellipsis,
//                     //               style: TextStyle(color: Colors.white),
//                     //             ),
//                     //           ),
//                     //         ],
//                     //       ),
//                     //       subtitle: Align(
//                     //           alignment: Alignment.bottomRight,
//                     //           child: Text("@${datas[i].category}")),
//                     //     ),
//                     //   ),
//                     // );
//                   });
//             }),
//       ),
//     );
//   }
// }
