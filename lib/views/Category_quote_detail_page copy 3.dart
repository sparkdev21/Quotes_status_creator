// import 'dart:core';

// import 'package:flutter/services.dart';
// import 'package:quotes_status_creator/providers/QuotesUINotifier.dart';
// import 'package:quotes_status_creator/views/Editor/SingleEditor.dart';
// import 'package:quotes_status_creator/views/QuotesUI/TinderSwipe.dart';
// import 'package:social_share/social_share.dart';

// import '/Controllers/QuotesController.dart';
// import '/models/HiveModel/hive_quote_data_model.dart';
// import '/models/love_quotes_english.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/adapters.dart';

// import '../services/store_quotes.dart';
// import 'QuotesUI/ElevatedQuotesCard.dart';
// import 'widgets/Favourite_categories.dart.dart';

// enum CategoryUI { Tinder, List }

// class CategoryQuoteDetailPage extends ConsumerWidget {
//   final int index;
//   final String typeofQuote;
//   final List<QuotesModel> quoteList;
//   CategoryQuoteDetailPage(this.index, this.typeofQuote, this.quoteList);

//   final QuotesController controller = QuotesController();
//   final _scrollController = ScrollController();
//   bool defaultCategory = true;
//   //Function for Fetching Posts

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
//         overlays: [SystemUiOverlay.bottom]);
//     ref.watch(mainQuotesProvider);
//     // quoteList.shuffle();
//     print("Rebuilding widget main");
//     print(quoteList.first);
//     return Scaffold(
//       appBar: AppBar(actions: [
        
//       ]),
//       persistentFooterButtons: [
//         Container(
//           color: Colors.red,
//           height: 50,
//         )
//       ],
//       body: Stack(
//         children: [
//           ref.watch(mainQuotesProvider.notifier).defaultCategory
//               ? InnerSwiper()
//               : Padding(
//                   padding: EdgeInsets.only(top: kToolbarHeight / 2),
//                   child: Stack(alignment: Alignment.bottomRight, children: [
//                     ListView.builder(
//                       padding: const EdgeInsets.only(top: 8),
//                       itemCount: quoteList[0].content!.length,
//                       itemBuilder: (context, i) {
//                         return Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             children: [
//                               ElevatedQuotesCard(
//                                   quote: quoteList[0].content![i].msg,
//                                   category: typeofQuote,
//                                   // notifier: quoteList[0].content![i].msg,

//                                   copyCallback: () {
//                                     SocialShare.copyToClipboard(
//                                         quoteList[0].content![i].msg);
//                                     SnackBar snackBar = SnackBar(
//                                       content: Text(
//                                         "Copied to Clipboard",
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     );
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(snackBar);
//                                   },
//                                   editCallback: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               SimpleEditorPage(
//                                             title: typeofQuote,
//                                             quote: quoteList[0].content![i].msg,
//                                           ),
//                                         ));
//                                   },
//                                   favoriteCallback: () {},
//                                   shareCallback: () {
//                                     SocialShare.shareOptions(
//                                         quoteList[0].content![i].msg);
//                                   },
//                                   textClickcallBack: () {}),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ]),
//                 ),
//           Align(
//               alignment: Alignment.topLeft,
//               child: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_ios_new,
//                   size: 24,
//                   color: Colors.white,
//                 ),
//                 onPressed: (() {
//                   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//                       overlays: [SystemUiOverlay.top]);
//                   Navigator.pop(context);
//                 }),
//               )),
//           Positioned(
//             right: 1,
//             child: Row(
//               children: [
//                 IconButton(
//                     onPressed: () async {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => FavouriteCategoryPage(
//                               category: typeofQuote,
//                             ),
//                           ));
//                     },
//                     icon: Icon(
//                       Icons.favorite,
//                       color: Colors.red.shade400,
//                     )),
//                 IconButton(
//                     icon: Icon(Icons.dashboard),
//                     onPressed: () {
//                       defaultCategory = !defaultCategory;

//                       ref
//                           .read(mainQuotesProvider.notifier)
//                           .changeUi(defaultCategory);
//                     }),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FavouriteButton extends StatelessWidget {
//   const FavouriteButton(
//       {Key? key,
//       required this.index,
//       required this.quote,
//       required this.category})
//       : super(key: key);
//   final String quote;
//   final String category;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     print("rebuilding Favourites");
//     return ValueListenableBuilder(
//         valueListenable: Hive.box(StoreQuotes().catBoxName()).listenable(),
//         builder: (BuildContext context, Box box, Widget? child) {
//           bool isCatexist =
//               QuotesController().favCategoryKeys().toList().contains(category);
//           bool isExist =
//               QuotesController().favCatKeys().toList().contains(quote) &&
//                   isCatexist;
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

//                     QuotesController().addCategoryQuotes(quotes);
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
