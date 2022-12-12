import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quotes_status_creator/models/love_quotes_english.dart';
import 'package:quotes_status_creator/providers/QuotesUINotifier.dart';
import 'package:quotes_status_creator/providers/ThemeProvider.dart';
import 'package:quotes_status_creator/utils/PageTrasition.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

import '../../Controllers/QuotesController.dart';
import '../../helpers/quote_fnctions.dart';
import '../../models/HiveModel/hive_quote_data_model.dart';
import '../../services/store_quotes.dart';
import '../single_quote_page.dart';

class InnerSwiper extends StatefulWidget {
  final String category;
  final List<QuotesModel> quotes;
  InnerSwiper(this.category, this.quotes);
  @override
  State<StatefulWidget> createState() {
    return new _InnerSwiperState();
  }
}

class _InnerSwiperState extends State<InnerSwiper> {
  SwiperController? controller;
  ScreenshotController? screenshotController;
  GlobalKey _repaintBoundaryKey = new GlobalKey();
  bool takingScreenshot = false;

  int val = 1;
  int indx = 0;
  Random rand = Random();
  late List<SwiperController> controllers;

  @override
  void initState() {
    controller = new SwiperController();
    screenshotController = ScreenshotController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         tileMode: TileMode.mirror,
        //         colors: val < 127
        //             ? GradientColors.values[val]
        //             : GradientColors.royalBlack)),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child:
                  Consumer(builder: (BuildContext context, WidgetRef ref, _) {
                ref.watch(mainQuotesProvider);

                return Screenshot(
                  controller: screenshotController!,
                  child: new Swiper(
                    onIndexChanged: (value) {
                      val = value;
                      indx = value;
                      // rand.nextInt(100);

                      setState(() {});
                    },
                    indicatorLayout: PageIndicatorLayout.SLIDE,
                    loop: true,
                    viewportFraction: 0.8,
                    autoplay: false,
                    autoplayDelay: 5000,
                    itemBuilder: (BuildContext context, int index) {
                      // if (index == 9) {
                      //   return Container(
                      //     width: 300,
                      //     height: MediaQuery.of(context).size.height * 0.28,
                      //     decoration: BoxDecoration(
                      //         color: Colors.red,
                      //         borderRadius: BorderRadius.circular(20)),
                      //     child: FittedBox(
                      //       child: Image.network(
                      //         imageList[0],
                      //         fit: BoxFit.fill,
                      //       ),
                      //     ),
                      //   );
                      // }
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                              child: GestureDetector(
                            onTap: () {
                              Fluttertoast.showToast(
                                  msg: "Copied to clipboard");
                              SocialShare.copyToClipboard(
                                  widget.quotes[0].content![index].msg);
                            },
                            child: StackQuotes(
                                widget.quotes[0].content![index].msg, val),
                          )),
                        ],
                      );
                    },
                    itemCount: widget.quotes[0].content!.length,
                    itemWidth: MediaQuery.of(context).size.width,
                    itemHeight: MediaQuery.of(context).size.height,
                    layout: ref
                            .watch(mainQuotesProvider.notifier)
                            .isTakingScreenshot
                        ? SwiperLayout.STACK
                        : SwiperLayout.TINDER,
                  ),
                );
              }),
            ),
            _buildButtons(
              indx: indx,
              category: widget.category,
              msg: widget.quotes[0].content![indx].msg,
              rkey: _repaintBoundaryKey,
              sController: screenshotController!,
            )
          ],
        ),
      ),
    );
  }
}

class _buildButtons extends StatelessWidget {
  _buildButtons(
      {Key? key,
      required this.indx,
      required this.msg,
      required this.category,
      required this.sController,
      required this.rkey})
      : super(key: key);

  final int indx;

  final String msg;

  final String category;
  final ScreenshotController sController;
  final GlobalKey rkey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton.small(
            heroTag: "c",
            onPressed: () {
              Fluttertoast.showToast(msg: "$indx");
              Navigator.push(
                  context,
                  PageTransition(
                      child: SimpleEditorPage(title: "", quote: msg),
                      type: PageTransitionType.leftToRight));
            },
            child: Icon(Icons.edit),
          ),
          FavButton(index: indx, quote: msg, category: category),
          Consumer(builder: (context, ref, _) {
            return FloatingActionButton.small(
                heroTag: "d",
                onPressed: () async {
                  // ref.read(mainQuotesProvider.notifier).changeUI(true);
                  saveTextImageToGallery(context, sController);
                  // await Future.delayed(Duration(seconds: 2),
                  //         saveTextImageToGallery(context, sController))
                  //     .then((value) => ref
                  //         .read(mainQuotesProvider.notifier)
                  //         .changeUI(false));

                  ref.read(mainQuotesProvider.notifier).changeUI(false);
                },
                child: Icon(
                  Icons.download,
                ));
          }),
          FloatingActionButton.small(
              heroTag: "s",
              onPressed: () {
                SocialShare.shareOptions(msg);
              },
              child: Icon(
                Icons.share,
              )),
        ],
      ),
    );
  }
}

class StackQuotes extends ConsumerWidget {
  final String quote;
  final int ind;
  const StackQuotes(this.quote, this.ind, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(quoteProvider);
    ref.watch(mainQuotesProvider);
    return // Generated code for this Column Widget...
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.tertiary,
                  offset: Offset(1, 2)),
              BoxShadow(
                  color: Theme.of(context).colorScheme.secondary,
                  offset: Offset(1, 3))
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.mirror,
                colors:
                    ref.watch(mainQuotesProvider.notifier).defaultCategory &&
                            ref.watch(mainQuotesProvider.notifier).defaultColor
                        ? [
                            Theme.of(context).colorScheme.tertiary,
                            Theme.of(context).colorScheme.primary
                          ]
                        : [
                            Theme.of(context).colorScheme.background,
                            Theme.of(context).colorScheme.background
                          ])),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(4),
                child: AutoSizeText(
                  '❝ $quote',
                  maxFontSize: 21,
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lexend Deca',
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: ref.watch(mainQuotesProvider.notifier).defaultColor
                        ? Colors.white
                        : ref.watch(themeProvider.notifier).darkTheme
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavButton extends StatelessWidget {
  const FavButton(
      {Key? key,
      required this.index,
      required this.quote,
      required this.category})
      : super(key: key);
  final String quote;
  final String category;
  final int index;

  @override
  Widget build(BuildContext context) {
    print("rebuilding Favourites");
    return ValueListenableBuilder(
        valueListenable: Hive.box(StoreQuotes().catBoxName()).listenable(),
        builder: (BuildContext context, Box box, Widget? child) {
          bool isCatexist =
              QuotesController().favCategoryKeys().toList().contains(category);
          bool isExist =
              QuotesController().favCatKeys().toList().contains(quote) &&
                  isCatexist;
          return FloatingActionButton.small(
              heroTag: "fav",
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
              },
              child: Icon(
                isExist ? Icons.favorite : Icons.favorite_border_outlined,
                color: isExist ? Colors.red : Colors.black,
              ));
        });
  }
}
