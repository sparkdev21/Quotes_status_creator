import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_colors/gradient_colors.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quotes_status_creator/models/love_quotes_english.dart';
import 'package:quotes_status_creator/providers/QuotesUINotifier.dart';
import 'package:quotes_status_creator/repositories/Quotes/quote_repository.dart';
import 'package:quotes_status_creator/utils/PageTrasition.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
import 'package:quotes_status_creator/views/QuotesUI/Categories_grid.dart';
import 'package:social_share/social_share.dart';

import '../../Controllers/QuotesController.dart';
import '../../models/HiveModel/hive_quote_data_model.dart';
import '../../services/store_quotes.dart';
import '../single_quote_page.dart';
import 'flutter_flow_theme.dart';

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
  int val = 1;
  int indx = 0;
  Random rand = Random();
  late List<SwiperController> controllers;

  @override
  void initState() {
    controller = new SwiperController();

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

                return new Swiper(
                  onIndexChanged: (value) {
                    val = value;
                    // rand.nextInt(100);
                    if (value < 127) {
                      Fluttertoast.showToast(
                          msg:
                              "index:${GradientColors.colorsname.entries.elementAt(val).key} color:${GradientColors.colorsname.entries.elementAt(val).value}");
                    }

                    setState(() {});
                  },
                  indicatorLayout: PageIndicatorLayout.SCALE,
                  loop: true,
                  viewportFraction: 1,
                  autoplay: false,
                  autoplayDelay: 5000,
                  autoplayDisableOnInteraction: true,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 9) {
                      return Container(
                        width: 300,
                        height: MediaQuery.of(context).size.height * 0.28,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        child: FittedBox(
                          child: Image.network(
                            imageList[0],
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                            child: GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Copied to clipboard");
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
                  layout: SwiperLayout.TINDER,
                );
              }),
            ),
            _buildButtons(
              indx: indx,
              category: widget.category,
              msg: widget.quotes[0].content![indx].msg,
            )
          ],
        ),
      ),
    );
  }
}

class _buildButtons extends StatelessWidget {
  const _buildButtons({
    Key? key,
    required this.indx,
    required this.msg,
    required this.category,
  }) : super(key: key);

  final int indx;

  final String msg;
  final String category;

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
          FloatingActionButton.small(
              heroTag: "a",
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
    // ref.watch(quotesProvider);
    return // Generated code for this Column Widget...
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.teal.shade100, offset: Offset(1, 2)),
              BoxShadow(color: Colors.blue.shade300, offset: Offset(1, 3))
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.mirror,
                colors: ind < 10
                    ? GradientColors.values[ind]
                    : GradientColors.royalBlack)),
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
                  style: FlutterFlowTheme.of(context).title1.override(
                        fontFamily: 'Lexend Deca',
                        fontSize: 19,
                        color: Colors.white,
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
