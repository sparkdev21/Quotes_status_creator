import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quotes_status_creator/Monetization/AdProviders/BannerAdProvider.dart';
import 'package:quotes_status_creator/providers/QuotesUINotifier.dart';
import 'package:quotes_status_creator/providers/dataProvider.dart';
import 'package:quotes_status_creator/repositories/Quotes/quote_repository.dart';
import 'package:quotes_status_creator/utils/PageTrasition.dart';
import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
import 'package:social_share/social_share.dart';

import '../single_quote_page.dart';

class FeaturedQuotesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mainQuotesProvider);
    final datas = ref.watch(mainQuotesProvider.notifier).featuredQuotes;

    const minHeight = kToolbarHeight;
    final windowHeight = MediaQuery.of(context).size.height - minHeight;
    final minSize = minHeight / windowHeight;
    return Scaffold(
        appBar: AppBar(
          title: Text("Random quotes"),
          centerTitle: true,
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: ref.watch(bannerWidget)),
        
        body: Container(
            height: windowHeight,
            child: LayoutBuilder(builder: (_, box) {
              print('minHeight: $minHeight');
              print('height: ${box.maxHeight}');
              return Container(
                // color: Theme.of(context).cardColor,
                child: ListView(children: [
                  for (int i = 0; i < datas.length; i++)
                    QuotesCards(datas[i].quote!, datas[i].author!)
                ]),
              );
            })));
  }
}

class QuotesCards extends ConsumerWidget {
  final String quote;
  final String author;
  const QuotesCards(this.quote, this.author, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch(quotesProvider);
    return GestureDetector(
        onDoubleTap: () {
          SocialShare.shareOptions(quote);
          Fluttertoast.showToast(msg: "Share using ...");
        },
        onLongPress: () {
          SocialShare.copyToClipboard(quote);
          Fluttertoast.showToast(msg: "Copied to clipboard");
        },
        onTap: () => Navigator.push(
            context,
            PageTransition(
                child: SimpleEditorPage(quote: quote, title: ""),
                type: PageTransitionType.leftToRight)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              style: ListTileStyle.list,
              minVerticalPadding: 6,
              title: AutoSizeText(
                '❝ $quote In nostrud velit fugi ipsum velit.rud velit fugi ipsum velit.',
                textAlign: TextAlign.center,
              ),
              subtitle: Padding(
                padding: EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    AutoSizeText('- $author ',
                        style: TextStyle(fontFamily: 'Lexend Deca')),

                    // Icon(Icons.format_quote_sharp),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
