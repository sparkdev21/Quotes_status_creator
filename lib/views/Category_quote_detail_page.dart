import 'dart:core';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quotes_status_creator/Monetization/AdmobHelper/AdmobHelper.dart';
import 'package:quotes_status_creator/Monetization/Banners/small_banner.dart';
import 'package:quotes_status_creator/Monetization/NativeAds/native_banner_feeds.dart';
import 'package:quotes_status_creator/providers/QuotesUINotifier.dart';
import 'package:quotes_status_creator/providers/ThemeProvider.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
import 'package:quotes_status_creator/views/QuotesUI/TinderSwipe.dart';
import 'package:social_share/social_share.dart';

import '../Monetization/AdHelpers.dart';
import '/Controllers/QuotesController.dart';
import '/models/HiveModel/hive_quote_data_model.dart';
import '/models/love_quotes_english.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../services/store_quotes.dart';
import 'QuotesUI/ElevatedQuotesCard.dart';
import 'widgets/Favourite_categories.dart.dart';
import 'package:provider/provider.dart' as pr;

enum CategoryUI { Tinder, List }

class CategoryQuoteDetailPage extends ConsumerStatefulWidget {
  final int index;
  final String typeofQuote;
  final List<QuotesModel> quoteList;
  CategoryQuoteDetailPage(this.index, this.typeofQuote, this.quoteList);

  @override
  ConsumerState<CategoryQuoteDetailPage> createState() =>
      _CategoryQuoteDetailPageState();
}

class _CategoryQuoteDetailPageState
    extends ConsumerState<CategoryQuoteDetailPage> {
  final QuotesController controller = QuotesController();
  final scrollcontroller = ScrollController();
  bool defaultCategory = true;

  bool defaultColor = true;
  late List quotesWithAds;
  @override
  void initState() {
    quotesWithAds = List.from(widget.quoteList[0].content!);
    // print("GB2:${quotesWithAds.first.toString()}");
    debugPrint("GB2:${quotesWithAds.length.toString()}");

    insertAdtoList();
    super.initState();
  }

  void insertAdtoList() {
    for (var i = quotesWithAds.length - 3; i >= 0; i -= 6) {
      quotesWithAds.insert(
          i,
          NativeAd(
            adUnitId: AdHelper.nativeGoogleTestAdUnitId,
            factoryId: 'listTile',
            request: AdRequest(),
            listener: NativeAdListener(
              // Called when an ad is successfully received.
              onAdLoaded: (Ad ad) {
                debugPrint("Ad native. loaded");
              },
              // Called when an ad request failed.
              onAdFailedToLoad: (Ad ad, LoadAdError error) {
                // Dispose the ad here to free resources.
                ad.dispose();
                print('Ad failed to load:native $error');
              },
              // Called when an ad opens an overlay that covers the screen.
              onAdOpened: (Ad ad) => print('Ad opened.'),
              // Called when an ad removes an overlay that covers the screen.
              onAdClosed: (Ad ad) => print('Ad closed.'),
              // Called when an impression occurs on the ad.
              onAdImpression: (Ad ad) => print('Ad impression. native'),
              // Called when a click is recorded for a NativeAd.
              onAdClicked: (ad) => print('Ad clicked.native'),
            ),
          ));
      ;
    }
  }

  //Function for Fetching Posts
  @override
  Widget build(BuildContext context) {
    print("GB2:${quotesWithAds.length.toString()}");
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
        overlays: [SystemUiOverlay.bottom]);
    ref.watch(mainQuotesProvider);
    ref.watch(themeProvider);
    final admobHelper = pr.Provider.of<AdmobHelper>(context, listen: false);
    // quoteList.shuffle();;
    print("Rebuilding widget main");
    print(widget.quoteList.first);

    return Scaffold(
      bottomNavigationBar: BannerSmall(),
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            widget.typeofQuote,
            textAlign: TextAlign.center,
          ),
          actions: [
            PopupMenuButton(
                elevation: 2,
                color: Theme.of(context).colorScheme.primaryContainer,
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.dashboard),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Change UI")
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 3,
                      child: Visibility(
                        visible: ref
                            .read(mainQuotesProvider.notifier)
                            .defaultCategory,
                        child: Row(
                          children: [
                            Icon(Icons.color_lens),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Change Color")
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Icon(
                            ref.watch(themeProvider.notifier).darkTheme
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Change Theme")
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.red.shade400,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Favourites")
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 0) {
                    ref.watch(themeProvider.notifier).darkTheme =
                        !ref.watch(themeProvider.notifier).darkTheme;
                    ref.read(themeProvider.notifier).toggleTheme(
                        ref.watch(themeProvider.notifier).darkTheme);
                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (context) => AboutdialogWidget());
                    // print("My account menu is selected.");
                  } else if (value == 1) {
                    admobHelper.decideIntersialAd(ActionAds.twoClicks);

                    defaultCategory = !defaultCategory;

                    ref
                        .read(mainQuotesProvider.notifier)
                        .changeUi(defaultCategory);
                    print("Settings menu is selected.");
                  } else if (value == 2) {
                    admobHelper.decideIntersialAd(ActionAds.twoClicks);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavouriteCategoryPage(
                            category: widget.typeofQuote,
                          ),
                        ));
                    print("Logout menu is selected.");
                  } else if (value == 3) {
                    admobHelper.decideIntersialAd(ActionAds.twoClicks);

                    defaultColor = !defaultColor;
                    ref
                        .read(mainQuotesProvider.notifier)
                        .changeDefualtColor(defaultColor);
                  }
                  // Navigator.pop(context);
                }),

            // IconButton(
            //   icon: Icon(
            //     Icons.arrow_back_ios_new,
            //     size: 24,
            //     color: Colors.white,
            //   ),
            //   onPressed: (() {
            //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            //         overlays: [SystemUiOverlay.top]);
            //     Navigator.pop(context);
            //   }),
            // ),
          ]),
      body: ref.watch(mainQuotesProvider.notifier).defaultCategory
          ? InnerSwiper(widget.typeofQuote, widget.quoteList)
          : Column(children: [
              Expanded(
                child: ListView.builder(
                  cacheExtent:20 ,
                    controller: scrollcontroller,
                    padding: const EdgeInsets.only(top: 4),
                    // itemCount: widget.quoteList[0].content!.length,
                    itemCount: widget.quoteList[0].content!.length,
                    itemBuilder: (context, i) {
                      final item = quotesWithAds[i];

                      if (item is NativeAd && i != 1) {
                        return NativeBannerFeeds();
                        // return SizedBox(
                        //     height: 50, child: AdWidget(ad: item..load()));
                      }
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            ElevatedQuotesCard(
                                quote: widget.quoteList[0].content![i].msg,
                                category: widget.typeofQuote,
                                // notifier: quoteList[0].content![i].msg,

                                copyCallback: () {
                                  admobHelper
                                      .decideIntersialAd(ActionAds.counterShow);
                                  SocialShare.copyToClipboard(
                                      widget.quoteList[0].content![i].msg);
                                  Fluttertoast.showToast(
                                      msg: "copied to clipboard");
                                  // SnackBar snackBar = SnackBar(
                                  //   content: Text(
                                  //     "Copied to Clipboard",
                                  //     textAlign: TextAlign.center,
                                  //   ),
                                  // );
                                  // ScaffoldMessenger.of(context)
                                  //     .showSnackBar(snackBar);
                                },
                                editCallback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SimpleEditorPage(
                                          title: widget.typeofQuote,
                                          quote: widget
                                              .quoteList[0].content![i].msg,
                                        ),
                                      ));
                                },
                                favoriteCallback: () {
                                  print("fb callback");
                                },
                                shareCallback: () {
                                  Fluttertoast.showToast(msg: "Share Using");
                                  SocialShare.shareOptions(
                                      widget.quoteList[0].content![i].msg);
                                },
                                textClickcallBack: () {
                                  admobHelper
                                      .decideIntersialAd(ActionAds.counterShow);
                                }),
                          ],
                        ),
                      );
                    }),
              ),
            ]),
    );
  }
}

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    Key? key,
    required this.index,
    required this.quote,
    required this.category,
  }) : super(key: key);
  final String quote;
  final String category;
  final int index;

  @override
  Widget build(BuildContext context) {
    final admobhelper = pr.Provider.of<AdmobHelper>(context, listen: false);
    print("rebuilding Favourites");
    return ValueListenableBuilder(
        valueListenable: Hive.box(StoreQuotes().catBoxName()).listenable(),
        builder: (BuildContext context, Box box, Widget? child) {
          bool isCatexist =
              QuotesController().favCategoryKeys().toList().contains(category);
          bool isExist =
              QuotesController().favCatKeys().toList().contains(quote) &&
                  isCatexist;
          return IconButton(
              onPressed: () {
                HiveQuoteDataModel quotes = HiveQuoteDataModel(
                    category: category,
                    id: index,
                    isFavourite: true,
                    language: category.contains(RegExp(r'hindi|Hindi'))
                        ? 'hindi'
                        : 'english',
                    quote: quote);

                QuotesController().addCategoryQuotes(quotes);
                admobhelper.decideIntersialAd(ActionAds.twoClicks);
              },
              icon: Icon(
                isExist ? Icons.favorite : Icons.favorite_border_outlined,
                color: isExist
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.secondary,
              ));
        });
  }
}
