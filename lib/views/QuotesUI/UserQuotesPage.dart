import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quotes_status_creator/Monetization/NativeAds/native_banner_feeds.dart';
import 'package:quotes_status_creator/repositories/Blog/userQuotesRepository.dart';
import 'package:quotes_status_creator/views/SubmitQuotes/submit.dart';
import 'package:social_share/social_share.dart';

import '../../models/BlogUserQuotesModel.dart';
import '../../models/TrendingModel.dart';
import '../../providers/QuotesUINotifier.dart';
import '../../utils/PageTrasition.dart';
import '../../utils/Utilities.dart';
import '../Editor/SingleEditor.dart';
import '/views/Editor/EditorNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'TrendingQuotes.dart';

final userRepositoryProvider =
    Provider.autoDispose((ref) => UserQuotesRepository());

final userQuotesProvider =
    FutureProvider.autoDispose<List<UserQuotesBlogModel>>((ref) async {
  // access the provider above
  final repository = ref.watch(userRepositoryProvider);

  // use it to return a Future
  final datas = repository.fetchPosts();
  List<UserQuotesBlogModel> userQuotes = [];
  try {
    await datas.then((value) {
      TrendingModel posts = value;

      List gb = json.decode(posts.content!);
      userQuotes = gb.map((e) => new UserQuotesBlogModel.fromJson(e)).toList();
      ref.read(mainQuotesProvider.notifier).setUserQuotes(userQuotes);

      print("trendQuotes:${userQuotes.length}");
    });
  } catch (e) {
    print(e);
  }

  return userQuotes;
});

class UserQuotesBlogPage extends ConsumerStatefulWidget {
  final Function(bool) isHideBottomNavBar;
  UserQuotesBlogPage({
    required this.isHideBottomNavBar,
    super.key,
  });

  @override
  ConsumerState<UserQuotesBlogPage> createState() => _UserQuotesBlogPageState();
}

class _UserQuotesBlogPageState extends ConsumerState<UserQuotesBlogPage> {
  bool _handleScrollNotification(notification, WidgetRef ref) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            widget.isHideBottomNavBar(true);
            ref.read(editorNotifier.notifier).setFloatingStatus(true);

            break;
          case ScrollDirection.reverse:
            widget.isHideBottomNavBar(false);
            ref.read(editorNotifier.notifier).setFloatingStatus(false);

            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  late List<Object> dataWithAds;
  late NativeAd nativeAd;

  void insertAdtoData() {
    for (var i = dataWithAds.length - 3; i >= 1; i -= 4) {
      dataWithAds.insert(i, SizedBox.shrink());
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(mainQuotesProvider);
    final datas = ref.watch(mainQuotesProvider.notifier).userQuotes;
    dataWithAds = List.from(datas);
    insertAdtoData();

    // final data = dataWithAds;
    // datas.sort((a, b) => a.featured = 1);
    // datas.sort((a, b) {
    //   if
    //   return a.status.length - b.status.length;
    //   return a.status.length - b.status.length;
    // });
    return NotificationListener<ScrollNotification>(
      onNotification: ((notification) =>
          _handleScrollNotification(notification, ref)),
      child: Scaffold(
          body: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              itemCount: datas.length,
              addAutomaticKeepAlives: true,
              itemBuilder: (context, int i) {
                final item = dataWithAds[i];
                if (item is Widget && i != 1) {
                  return NativeBannerFeeds();
                }
                return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 13, 25, 8),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.60,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  offset: Offset(2, 3))
                              // BoxShadow(
                              //     color: Theme.of(context)
                              //         .colorScheme
                              //         .onBackground,
                              //     offset: Offset(1, -1.2)),
                              // BoxShadow(
                              //     color: Theme.of(context)
                              //         .colorScheme
                              //         .onBackground,
                              //     offset: Offset(-2, -1.5))
                            ],
                            gradient: LinearGradient(colors: [
                              Theme.of(context).cardColor,
                              // Theme.of(context).colorScheme.secondary,
                              Theme.of(context).cardColor,
                            ])),
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
                        child: Stack(children: [
                          Banner(
                              message: "${datas[i].userid}",
                              textStyle: TextStyle(
                                  fontSize: 10,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.color,
                                  fontWeight: FontWeight.bold),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              location: BannerLocation.topStart,
                              child: GestureDetector(
                                onTap: () {
                                  AppUtil.lauchInstagram(
                                      'https://www.instagram.com/${datas[i].userid}');
                                },
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.79),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: buttons(context, "${datas[i].quote}"),
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
                                          Theme.of(context)
                                              .colorScheme
                                              .onTertiary,
                                          Theme.of(context)
                                              .colorScheme
                                              .background
                                        ]),
                                      ),
                                      child: Icon(
                                        Icons.local_fire_department_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      14, 1, 24, 14),
                                  child: AutoSizeText(
                                    'Laboris fugiat aliqua cillum Sit veniam consequat offic. Merunt incididunt anim. Commodo esse non fugiat nulla aute. ',
                                    maxLines: 5,
                                    maxFontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ])));

                //  AdWidget(ad: item.load() as BannerAd
                // Generated code for this Container Widget...

                return SizedBox.shrink();
              }),
          floatingActionButton: Visibility(
              visible: ref.watch(editorNotifier.notifier).showFloatingButton,
              child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: SubmitQuotesPage(
                              title: "",
                            ),
                            type: PageTransitionType.rightToLeftWithFade));
                  }))),
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
