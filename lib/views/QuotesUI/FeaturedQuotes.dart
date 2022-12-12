import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes_status_creator/utils/PageTrasition.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
import 'package:social_share/social_share.dart';
import '/models/HiveModel/TrendingQuotesModel.dart';
import '/models/TrendingModel.dart';
import '/providers/QuotesUINotifier.dart';
import '/repositories/Blog/featuredPost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final featuredRepositoryProvider =
    Provider.autoDispose((ref) => FeaturedRepository());

final featuredQuotesProvider =
    FutureProvider.autoDispose<List<TrendingQuotesModel>>((ref) async {
  // access the provider above
  final repository = ref.watch(featuredRepositoryProvider);

  // use it to return a Future
  final datas = repository.fetchPosts();
  List<TrendingQuotesModel> featuredQuotes = [];
  try {
    await datas.then((value) {
      TrendingModel posts = value;

      List gb = json.decode(posts.content!);
      featuredQuotes =
          gb.map((e) => new TrendingQuotesModel.fromJson(e)).toList();
      ref.read(mainQuotesProvider.notifier).setFeaturedQuotes(featuredQuotes);
      print("featuredQuotes:${featuredQuotes.length}");
    });
  } catch (e) {
    print("Featured:Error Data Fetching from Internet  $e");
  }

  return featuredQuotes;
});

copyToClipFn(msg) {
  SocialShare.copyToClipboard(msg);
  Fluttertoast.showToast(msg: "Copied to Clipboard");
}

shareMsg(msg) {
  SocialShare.shareOptions(msg);
}

navigatoToEditor(context, msg) {
  Navigator.push(
      context,
      PageTransition(
          child: SimpleEditorPage(title: "title", quote: msg),
          type: PageTransitionType.leftToRightWithFade));
}

class FeaturedPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mainQuotesProvider);
    final datas = ref.watch(mainQuotesProvider.notifier).featuredQuotes;
    if (datas.length == 0) {
      return Center(
        child: Text("Loading..."),
      );
    }

    // print("featured:$datas");
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.20,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: datas.length,
            itemBuilder: (context, int i) {
              return GestureDetector(
                onTap: () => copyToClipFn(datas[i].quote!),
                onDoubleTap: () => navigatoToEditor(context, datas[i].quote!),
                onLongPress: () => shareMsg(datas[i].quote!),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.50,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(10),
                    //   // boxShadow: [
                    //   //   BoxShadow(
                    //   //       color: Theme.of(context).colorScheme.tertiary,
                    //   //       offset: Offset(0.2, 0))
                    //   // ],
                    //   // gradient: LinearGradient(
                    //   //     begin: Alignment.bottomCenter,
                    //   //     end: Alignment.topCenter,
                    //   //     tileMode: TileMode.mirror,
                    //   //     colors: [
                    //   //       Theme.of(context).colorScheme.background,
                    //   //       Colors.blueGrey.shade300
                    //   //     ])
                    // ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        style: ListTileStyle.list,
                        minVerticalPadding: 6,
                        title: AutoSizeText(
                          '${datas[i].quote!} In nostrud velit fugi ipsum velit.rud velit fugi ipsum velit.',
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AutoSizeText("- ${datas[i].author!}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'Lexend Deca')),
                        ),
                      ),
                    ),
                  ),
                ),
              );

              // Generated code for this Container Widget...

              // return Padding(
              //   padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(12),
              //         gradient: LinearGradient(
              //             colors: GradientColors
              //                 .values[math.Random().nextInt(100)]),
              //         boxShadow: [
              //           BoxShadow(
              //               color: Colors.green.shade700,
              //               offset: Offset(2, 3))
              //         ]),
              //     child: ListTile(
              //       title: Row(
              //         children: [
              //           Align(
              //             alignment: Alignment.topLeft,
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(12),
              //                     gradient: LinearGradient(
              //                         colors: GradientColors.values[
              //                             math.Random().nextInt(100)]),
              //                     boxShadow: [
              //                       BoxShadow(
              //                           color: Colors.green.shade700,
              //                           offset: Offset(2, 3))
              //                     ]),
              //                 child: Icon(Icons.star),
              //               ),
              //             ),
              //           ),
              //           Flexible(
              //             child: AutoSizeText(
              //               "Sit nisi tempor nisi fugiat amet. Anim esse velit magna aute sit laboris ,mollit anim ullamco non cillum. Tempor magna ea duis tempor esse aliqua. Laborum id ullamco ex officia sunt proident do incididunt magna ut id aliquip. Cupidatat do velit labore qui incididunt pariatur ad labore voluptate. Elit deserunt tempor est proident Lorem dolore sit laborum pariatur mollit.",
              //               maxLines: 5,
              //               overflow: TextOverflow.ellipsis,
              //               style: TextStyle(color: Colors.white),
              //             ),
              //           ),
              //         ],
              //       ),
              //       subtitle: Align(
              //           alignment: Alignment.bottomRight,
              //           child: Text("@${datas[i].category}")),
              //     ),
              //   ),
              // );
            }));
  }
}
