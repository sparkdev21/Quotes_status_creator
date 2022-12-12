import 'dart:convert';
import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quotes_status_creator/utils/PageTrasition.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
import 'package:social_share/social_share.dart';

import '/models/HiveModel/TrendingQuotesModel.dart';
import '/models/TrendingModel.dart';
import '/providers/QuotesUINotifier.dart';
import '/repositories/Blog/trendingpost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_colors/gradient_colors.dart';

final trendingRepositoryProvider =
    Provider.autoDispose((ref) => TrendinRepository());

final trendingQuotesProvider =
    FutureProvider.autoDispose<List<TrendingQuotesModel>>((ref) async {
  // access the provider above
  final repository = ref.watch(trendingRepositoryProvider);

  // use it to return a Future
  final datas = repository.fetchPosts();
  List<TrendingQuotesModel> trendQuotes = [];
  await datas.then((value) {
    TrendingModel posts = value;

    List gb = json.decode(posts.content!);
    trendQuotes = gb.map((e) => new TrendingQuotesModel.fromJson(e)).toList();
    ref.read(mainQuotesProvider.notifier).setTrendingQuotes(trendQuotes);

    print("trendQuotes:${trendQuotes.length}");
  });
  return trendQuotes;
});

class TrendingPage extends ConsumerWidget {
  final imagesx = "https://docs.flutter.dev/assets/images/404/dash_nest.png";

  final bestGradints = [0, 9, 15, 10, 75, 88, 100, 114];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mainQuotesProvider);
    final datas = ref.watch(mainQuotesProvider.notifier).trendinGQuotes;

    print("trendings:$datas");
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Trending Quotes"),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
              color: Colors.red,
              height: 50,
              child: Text(
                "Ads",
                textAlign: TextAlign.center,
              ))),
      body: Material(
          elevation: 2.0,
          color: Colors.transparent,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              itemCount: GradientColors.values.length,
              itemBuilder: (context, int i) {
                return // Generated code for this Container Widget...
                    Padding(
                  padding: const EdgeInsets.fromLTRB(20, 13, 25, 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.red, offset: Offset(2, 3))
                        ],
                        gradient:
                            LinearGradient(colors: GradientColors.values[i])),
                    // BoxDecoration(
                    //   borderRadius: BorderRadius.circular(16),
                    //   gradient: LinearGradient(
                    //       colors: GradientColors
                    //           .values[math.Random().nextInt(100)]),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       blurRadius: 12,
                    //       // color: Colors.red.shade900,
                    //       offset: Offset(1, -2),
                    //       spreadRadius: 1,
                    //     )
                    //   ],
                    //   border: Border.all(
                    //     color: Colors.blue,
                    //     width: 1,
                    //   ),
                    // ),
                    child: Stack(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.79),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: buttons(context, "datas[i].quote"),
                            )),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(14, 1, 24, 14),
                            child: AutoSizeText(
                              'Laboris fugiat aliqua cillum occaecat velit aliquip velit. Sit veniam consequat officia deserunt nostrud magna enim nostrud aute dolor elit do adipisicing aute. Minim minim do pariatur nulla aute Lorem occaecat deserunt incididunt anim. Commodo esse non fugiat nulla aute. Nulla in magna eu labore dolor eiusmod. Amet ullamco cupidatat ullamco minim commodo aliqua.',
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 4, 14, 14),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "-$i{datas[i].author}",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: '',
                                      style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.02, -1.5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                        colors: GradientColors.values[
                                            math.Random().nextInt(100)]),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blue.shade700,
                                          offset: Offset(-1, -0.5))
                                    ]),
                                child:
                                    Icon(Icons.local_fire_department_rounded)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }

  Widget buttons(context, msg) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: IconButton(
                onPressed: () {
                  SocialShare.shareOptions(msg);
                },
                icon: const Icon(
                  FontAwesomeIcons.share,
                  size: iconSize,
                )),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  SocialShare.copyToClipboard(msg);
                  Fluttertoast.showToast(msg: "Copied  to Clipboard");
                },
                icon: const Icon(
                  Icons.copy,
                  size: iconSize,
                )),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: SimpleEditorPage(
                            quote: msg,
                            title: "",
                          ),
                          type: PageTransitionType.leftToRight));
                },
                icon: const Icon(
                  FontAwesomeIcons.penToSquare,
                  size: iconSize,
                )),
          ),
        ],
      ),
    );
  }
}

const double iconSize = 14.0;
