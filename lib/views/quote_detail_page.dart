import '/Controllers/QuotesController.dart';
import '/models/love_quotes_english.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../services/store_quotes.dart';
import 'widgets/FavouritePage.dart';

final favProvider =
    ChangeNotifierProvider<QuotesController>((ref) => QuotesController());

class QuoteDetailPage extends StatelessWidget {
  final int index;
  final String typeofQuote;
  final List<QuotesModel> quoteList;
  QuoteDetailPage(this.index, this.typeofQuote, this.quoteList);

  QuotesController controller = QuotesController();

  //Function for Fetching Posts

  @override
  Widget build(BuildContext context) {
    print("Rebuilding widget main");
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavouritePage(),
                      ));
                },
                icon: Icon(Icons.delete))
          ],
          title: Text("Post List 2"),
          centerTitle: true,
        ),
        body: ListView.builder(
          cacheExtent: 10,
          shrinkWrap: true,
          itemCount: quoteList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (() {}),
              child: Card(
                shadowColor: Colors.red,
                elevation: 2.0,
                child: ListTile(
                  trailing: favoutite(quoteList[index].content![0].msg),
                  title: Text(
                    // postlist.posts[index].url\
                    quoteList[index].content![0].msg ?? "no items",
                    textAlign: TextAlign.center,
                  ),
                  subtitle:
                      Text(quoteList[index].content![0].submit ?? "No Auther"),
                ),
              ),
            );
          },
        ));
  }
}

Widget favoutite(String value) {
  // return Icon(Icons.favorite);
  print("rebuilding Widget fav");
  final sq = StoreQuotes();
  final controller = QuotesController();

  return IconButton(
      onPressed: () {
        controller.addQuotes(value);
      },
      icon: ValueListenableBuilder(
          valueListenable: Hive.box(sq.boxName()).listenable(),
          builder: (BuildContext context, Box box, Widget? child) {
            final favs = box.values;
            return Icon(
              Icons.favorite,
              color: favs.contains(value) ? Colors.red : Colors.green,
            );
          }));
}
