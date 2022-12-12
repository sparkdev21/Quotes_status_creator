// import 'dart:core';

// import '/Controllers/QuotesController.dart';
// import '/models/HiveModel/hive_quote_data_model.dart';
// import '/models/love_quotes_english.dart';
// import '/views/widgets/Favourite_categories.dart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/adapters.dart';

// import '../services/store_quotes.dart';

// class CategoryQuoteDetailPage extends StatelessWidget {
//   final int index;
//   final String typeofQuote;
//   final List<QuotesModel> quoteList;
//   CategoryQuoteDetailPage(this.index, this.typeofQuote, this.quoteList);

//   final QuotesController controller = QuotesController();
//   final _scrollController = ScrollController();
//   //Function for Fetching Posts

//   @override
//   Widget build(BuildContext context) {
//     // quoteList.shuffle();
//     print("Rebuilding widget main");
//     print(quoteList.first);
//     return Scaffold(
//         appBar: AppBar(
//           actions: [
//             IconButton(
//                 onPressed: () async {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FavouriteCategoryPage(
//                           category: typeofQuote,
//                         ),
//                       ));
//                 },
//                 icon: Icon(
//                   Icons.favorite,
//                   color: Colors.red.shade400,
//                 ))
//           ],
//           title: Text("Post List"),
//           centerTitle: true,
//         ),
//         body: Consumer(
//             builder: (BuildContext context, WidgetRef ref, Widget? child) {
//           return Stack(alignment: Alignment.bottomRight, children: [
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: quoteList[0].content!.length + 1,
//               controller: _scrollController,
//               // prototypeItem: ListTile(
//               //   trailing: Text("trailing"),
//               //   title: Text(
//               //     // postlist.posts[index].url\
//               //     "quoteList[index].msg!",
//               //     textAlign: TextAlign.center,
//               //   ),
//               //   subtitle: Text("quoteList[index].sid.toString()"),
//               // ),
//               itemBuilder: (context, index) {
//                 if (index == quoteList[0].content!.length) {
//                   return Visibility(
//                     visible: index == quoteList[0].content!.length,
//                     child: FloatingActionButton(
//                       onPressed: () async {
//                         print(
//                             "offset:${_scrollController.position.maxScrollExtent / 3}");
//                         _scrollController.animateTo(1.0,
//                             duration: Duration(seconds: 3),
//                             curve: Curves.decelerate);
//                       },
//                       child: Icon(Icons.arrow_drop_up_sharp),
//                     ),
//                   );
//                 }

//                 return GestureDetector(
//                   onTap: (() {}),
//                   child: Card(
//                     shadowColor: Colors.red,
//                     elevation: 2.0,
//                     child: ListTile(
//                       trailing: FavouriteButton(
//                         index: quoteList[0].content![index].sid,
//                         quote: quoteList[0].content![index].msg,
//                         typeOfQuote: typeofQuote,
//                       ),
//                       title: Text(
//                         // postlist.posts[index].url\
//                         quoteList[0].content![index].msg,
//                         textAlign: TextAlign.center,
//                       ),
//                       subtitle:
//                           Text(quoteList[0].content![index].sid.toString()),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ]);
//         }));
//   }
// }

// class FavouriteButton extends StatelessWidget {
//   FavouriteButton(
//       {Key? key,
//       required this.index,
//       required this.quote,
//       required this.typeOfQuote})
//       : super(key: key);
//   final String quote;
//   final String typeOfQuote;
//   final int index;

//   final sq = StoreQuotes();
//   final controller = QuotesController();

//   @override
//   Widget build(BuildContext context) {
//     print("rebuilding Favourites");
//     return ValueListenableBuilder(
//         valueListenable: Hive.box(sq.catBoxName()).listenable(),
//         builder: (BuildContext context, Box box, Widget? child) {
//           bool isCatexist =
//               controller.favCategoryKeys().toList().contains(typeOfQuote);
//           bool isExist =
//               controller.favCatKeys().toList().contains(quote) && isCatexist;
//           return IconButton(
//               onPressed: () {
//                 HiveQuoteDataModel quotes = HiveQuoteDataModel(
//                     category: typeOfQuote,
//                     id: index,
//                     isFavourite: true,
//                     language: typeOfQuote.contains(RegExp(r'hindi|Hindi'))
//                         ? 'hindi'
//                         : 'english',
//                     quote: quote);

//                 controller.addCategoryQuotes(quotes);
//               },
//               icon: Icon(
//                 isExist ? Icons.favorite : Icons.favorite_border_outlined,
//                 color: isExist ? Colors.red : Colors.black,
//               ));
//         });
//   }
// }
