import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quotes_status_creator/Monetization/AdmobHelper/AdmobHelper.dart';
import 'package:quotes_status_creator/Monetization/Banners/small_banner.dart';
import 'package:quotes_status_creator/Monetization/NativeAds/native_banner_feeds.dart';
import 'package:quotes_status_creator/utils/PageTrasition.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
import 'package:social_share/social_share.dart';

import '/models/HiveModel/TrendingQuotesModel.dart';
import '/models/TrendingModel.dart';
import '/providers/QuotesUINotifier.dart';
import '/repositories/Blog/trendingpost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pr;

final trendingRepositoryProvider =
    Provider.autoDispose((ref) => TrendinRepository());

final trendingQuotesProvider =
    FutureProvider.autoDispose<List<TrendingQuotesModel>>((ref) async {
  // access the provider above
  final repository = ref.watch(trendingRepositoryProvider);

  // use it to return a Future
  final datas = repository.fetchPosts();
  List<TrendingQuotesModel> trendQuotes = [];
  try {
    await datas.then((value) {
      TrendingModel posts = value;

      List gb = json.decode(posts.content!);
      trendQuotes = gb.map((e) => new TrendingQuotesModel.fromJson(e)).toList();
      ref.read(mainQuotesProvider.notifier).setTrendingQuotes(trendQuotes);

      print("trendQuotes:${trendQuotes.length}");
    });
  } catch (e) {
    print("Trending:Error Data Fetching from Internet ");
  }

  return trendQuotes;
});

class TrendingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mainQuotesProvider);
    final datas = ref.watch(mainQuotesProvider.notifier).trendinGQuotes;
    final admobHelper = pr.Provider.of<AdmobHelper>(context, listen: false);

    print("trendings:$datas");
    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Trending Quotes"),
        centerTitle: true,
      ),
      bottomNavigationBar: BannerSmall(),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          // shrinkWrap: false,
          itemCount: datas.length,
          itemBuilder: (context, int i) { 
            if (i == datas.length / 2 
            ) {
              debugPrint("Ad native ${datas.length}");
              return NativeBannerFeeds();
            }

            return // Generated code for this Container Widget...
                Padding(
              padding: const EdgeInsets.fromLTRB(20, 13, 25, 8),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.60,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).colorScheme.onBackground,
                          offset: Offset(2, 3))
                    ],
                    gradient: LinearGradient(colors: [
                      Theme.of(context)
                          .cardColor, // Theme.of(context).colorScheme.secondary,
                      Theme.of(context).backgroundColor,
                    ])),
                child: Stack(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.79),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: buttons(context, datas[i].quote, admobHelper),
                        )),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(colors: [
                                      Theme.of(context).splashColor,
                                      Theme.of(context).colorScheme.background
                                    ]),
                                    boxShadow: [
                                      // BoxShadow(
                                      //     color: Colors.blue.shade700,
                                      //     offset: Offset(-1, -0.5))
                                    ]),
                                child: Icon(
                                  Icons.local_fire_department_rounded,
                                  color: Theme.of(context).colorScheme.tertiary,
                                )),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(14, 1, 24, 14),
                            child: AutoSizeText(
                              'Laboris fugiat aliqua cillum Sit veniam consequat offic. Merunt incididunt anim. Commodo esse non fugiat nulla aute. ',
                              maxLines: 5,
                              maxFontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: datas[i].author ?? '',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '',
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget buttons(context, msg, AdmobHelper admobHelper) {
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
                  admobHelper.decideIntersialAd(ActionAds.twoClicks);
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

                  Fluttertoast.showToast(msg: "copied to clipboard");
                  admobHelper.decideIntersialAd(ActionAds.twoClicks);
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
