// import 'dart:core';

// import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
// import 'package:social_share/social_share.dart';

// import '/Controllers/QuotesController.dart';
// import '/models/HiveModel/hive_quote_data_model.dart';
// import '/models/love_quotes_english.dart';
// import '/views/widgets/Favourite_categories.dart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/adapters.dart';

// import '../services/store_quotes.dart';
// import 'QuotesUI/ElevatedQuotesCard.dart';

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
//           title: Text("Post List 2"),
//           centerTitle: true,
//         ),
//         body: Consumer(
//             builder: (BuildContext context, WidgetRef ref, Widget? child) {
//           return Stack(alignment: Alignment.bottomRight, children: [
//             ListView.builder(
//               padding: const EdgeInsets.only(top: 8),
//               itemCount: quoteList[0].content!.length,
//               itemBuilder: (context, i) {
//                 return Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     children: [
//                       ElevatedQuotesCard(
//                           quote: quoteList[0].content![i].msg,
//                           category: typeofQuote,
//                           // notifier: quoteList[0].content![i].msg,

//                           copyCallback: () {
//                             SocialShare.copyToClipboard(
//                                 quoteList[0].content![i].msg);
//                             SnackBar snackBar = SnackBar(
//                               content: Text(
//                                 "Copied to Clipboard",
//                                 textAlign: TextAlign.center,
//                               ),
//                             );
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackBar);
//                           },
//                           editCallback: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => SimpleEditorPage(
//                                     title: typeofQuote,
//                                     quote: quoteList[0].content![i].msg,
//                                   ),
//                                 ));
//                           },
//                           favoriteCallback: () {},
//                           shareCallback: () {
//                             SocialShare.shareOptions(
//                                 quoteList[0].content![i].msg);
//                           },
//                           textClickcallBack: () {}),
//                     ],
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
//       required this.category})
//       : super(key: key);
//   final String quote;
//   final String category;
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
//               controller.favCategoryKeys().toList().contains(category);
//           bool isExist =
//               controller.favCatKeys().toList().contains(quote) && isCatexist;
//           return Column(
//             children: [
//               IconButton(
//                   onPressed: () {
//                     HiveQuoteDataModel quotes = HiveQuoteDataModel(
//                         category: category,
//                         id: index,
//                         isFavourite: true,
//                         language: category.contains(RegExp(r'hindi|Hindi'))
//                             ? 'hindi'
//                             : 'english',
//                         quote: quote);

//                     controller.addCategoryQuotes(quotes);
//                   },
//                   icon: Icon(
//                     isExist ? Icons.favorite : Icons.favorite_border_outlined,
//                     color: isExist ? Colors.red : Colors.white,
//                   )),
//             ],
//           );
//         });
//   }
// }
