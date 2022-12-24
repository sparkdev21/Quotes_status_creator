import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_status_creator/views/Category_quote_detail_page.dart';

class ElevatedQuotesCard extends StatelessWidget {
  final String quote;
  final String category;
  final VoidCallback shareCallback;
  final VoidCallback favoriteCallback;
  final VoidCallback copyCallback;
  final VoidCallback editCallback;
  final VoidCallback textClickcallBack;
  final ValueNotifier<List<String>>? notifier;
  const ElevatedQuotesCard({
    Key? key,
    required this.quote,
    required this.category,
    required this.shareCallback,
    required this.favoriteCallback,
    required this.copyCallback,
    required this.editCallback,
    required this.textClickcallBack,
    this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 4,
                    ),
                    child: GestureDetector(
                      onTap: (() => textClickcallBack()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: AutoSizeText(
                                "❝ ${quote.split(',').join(',')} ",
                                maxLines: 4,
                                minFontSize: 16,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.notoSansPsalterPahlavi()
                                            .fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        tileMode: TileMode.mirror,
                        colors: [
                          Theme.of(context).colorScheme.background,
                          Theme.of(context).colorScheme.primaryContainer,
                        ])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: shareCallback,
                              icon: const Icon(
                                FontAwesomeIcons.share,
                              )),
                          const Text(
                            "Share",
                            style: labelStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          FavouriteButton(
                              index: 1, quote: quote, category: category),
                          const Text(
                            "Favourite",
                            style: labelStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: copyCallback,
                              icon: const Icon(
                                Icons.copy,
                              )),
                          const Text(
                            "Copy",
                            style: labelStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: editCallback,
                              icon: const Icon(
                                FontAwesomeIcons.penToSquare,
                              )),
                          const Text(
                            "Edit",
                            style: labelStyle,
                          ),
                        ],
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
  }
}

const TextStyle labelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
);
const Color iconcolor = Colors.white;
