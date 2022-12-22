// import 'dart:core';

// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:quotes_status_creator/Monetization/AdmobHelper/AdmobHelper.dart';
// import 'package:quotes_status_creator/Monetization/Banners/small_banner.dart';
// import 'package:quotes_status_creator/providers/QuotesUINotifier.dart';
// import 'package:quotes_status_creator/providers/ThemeProvider.dart';
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

// class CategoryQuoteDetailPage extends ConsumerStatefulWidget {
//   final int index;
//   final String typeofQuote;
//   final List<QuotesModel> quoteList;
//   CategoryQuoteDetailPage(this.index, this.typeofQuote, this.quoteList);

//   @override
//   ConsumerState<CategoryQuoteDetailPage> createState() =>
//       _CategoryQuoteDetailPageState();
// }

// class _CategoryQuoteDetailPageState
//     extends ConsumerState<CategoryQuoteDetailPage> {
//   final QuotesController controller = QuotesController();
//   final AdmobHelper admobHelper = AdmobHelper();

//   bool defaultCategory = true;

//   bool defaultColor = true;
//   late List<Object> quotesWithAds;
//   @override
//   void initState() {
//     quotesWithAds = List.from(widget.quoteList);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     admobHelper.dispose();
//     super.dispose();
//   }

//   //Function for Fetching Posts
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
//         overlays: [SystemUiOverlay.bottom]);
//     ref.watch(mainQuotesProvider);
//     ref.watch(themeProvider);
//     // quoteList.shuffle();;
//     print("Rebuilding widget main");
//     print(widget.quoteList.first);
//     return Scaffold(
//       bottomNavigationBar:
//           BottomAppBar(child: Container(height: 50, child: BannerSmall())),
//       appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios_new),
//             onPressed: () => Navigator.pop(context),
//           ),
//           centerTitle: true,
//           title: Text(
//             widget.typeofQuote,
//             textAlign: TextAlign.center,
//           ),
//           actions: [
//             PopupMenuButton(
//                 elevation: 2,
//                 color: Theme.of(context).colorScheme.primaryContainer,
//                 // add icon, by default "3 dot" icon
//                 // icon: Icon(Icons.book)
//                 itemBuilder: (context) {
//                   return [
//                     PopupMenuItem<int>(
//                       value: 1,
//                       child: Row(
//                         children: [
//                           Icon(Icons.dashboard),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text("Change UI")
//                         ],
//                       ),
//                     ),
//                     PopupMenuItem<int>(
//                       value: 3,
//                       child: Visibility(
//                         visible: ref
//                             .read(mainQuotesProvider.notifier)
//                             .defaultCategory,
//                         child: Row(
//                           children: [
//                             Icon(Icons.color_lens),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text("Change Color")
//                           ],
//                         ),
//                       ),
//                     ),
//                     PopupMenuItem<int>(
//                       value: 0,
//                       child: Row(
//                         children: [
//                           Icon(
//                             ref.watch(themeProvider.notifier).darkTheme
//                                 ? Icons.light_mode_outlined
//                                 : Icons.dark_mode_outlined,
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text("Change Theme")
//                         ],
//                       ),
//                     ),
//                     PopupMenuItem<int>(
//                       value: 2,
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.favorite,
//                             color: Colors.red.shade400,
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text("Favourites")
//                         ],
//                       ),
//                     ),
//                   ];
//                 },
//                 onSelected: (value) {
//                   if (value == 0) {
//                     ref.watch(themeProvider.notifier).darkTheme =
//                         !ref.watch(themeProvider.notifier).darkTheme;
//                     ref.read(themeProvider.notifier).toggleTheme(
//                         ref.watch(themeProvider.notifier).darkTheme);
//                     // showModalBottomSheet(
//                     //     context: context,
//                     //     builder: (context) => AboutdialogWidget());
//                     // print("My account menu is selected.");
//                   } else if (value == 1) {
//                     defaultCategory = !defaultCategory;

//                     ref
//                         .read(mainQuotesProvider.notifier)
//                         .changeUi(defaultCategory);
//                     print("Settings menu is selected.");
//                   } else if (value == 2) {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => FavouriteCategoryPage(
//                             category: widget.typeofQuote,
//                           ),
//                         ));
//                     print("Logout menu is selected.");
//                   } else if (value == 3) {
//                     defaultColor = !defaultColor;
//                     ref
//                         .read(mainQuotesProvider.notifier)
//                         .changeDefualtColor(defaultColor);
//                   }
//                   // Navigator.pop(context);
//                 }),

//             // IconButton(
//             //   icon: Icon(
//             //     Icons.arrow_back_ios_new,
//             //     size: 24,
//             //     color: Colors.white,
//             //   ),
//             //   onPressed: (() {
//             //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//             //         overlays: [SystemUiOverlay.top]);
//             //     Navigator.pop(context);
//             //   }),
//             // ),
//           ]),
//       body: ref.watch(mainQuotesProvider.notifier).defaultCategory
//           ? InnerSwiper(widget.typeofQuote, widget.quoteList)
//           : Stack(alignment: Alignment.bottomRight, children: [
//               ListView.builder(
//                 padding: const EdgeInsets.only(top: 4),
//                 itemCount: widget.quoteList[0].content!.length,
//                 itemBuilder: (context, i) {
//                   return Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       children: [
//                         ElevatedQuotesCard(
//                             quote: widget.quoteList[0].content![i].msg,
//                             category: widget.typeofQuote,
//                             // notifier: quoteList[0].content![i].msg,

//                             copyCallback: () {
//                               admobHelper
//                                   .decideIntersialAd(ActionAds.twoClicks);
//                               SocialShare.copyToClipboard(
//                                   widget.quoteList[0].content![i].msg);
//                               Fluttertoast.showToast(
//                                   msg: "copied to clipboard");
//                               // SnackBar snackBar = SnackBar(
//                               //   content: Text(
//                               //     "Copied to Clipboard",
//                               //     textAlign: TextAlign.center,
//                               //   ),
//                               // );
//                               // ScaffoldMessenger.of(context)
//                               //     .showSnackBar(snackBar);
//                             },
//                             editCallback: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => SimpleEditorPage(
//                                       title: widget.typeofQuote,
//                                       quote:
//                                           widget.quoteList[0].content![i].msg,
//                                     ),
//                                   ));
//                             },
//                             favoriteCallback: () {},
//                             shareCallback: () {
//                               SocialShare.shareOptions(
//                                   widget.quoteList[0].content![i].msg);
//                             },
//                             textClickcallBack: () {}),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ]),
//     );
//   }
// }

// class FavouriteButton extends StatelessWidget {
//   const FavouriteButton({
//     Key? key,
//     required this.index,
//     required this.quote,
//     required this.category,
//   }) : super(key: key);
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
//                     color: isExist
//                         ? Theme.of(context).colorScheme.tertiary
//                         : Theme.of(context).colorScheme.secondary,
//                   )),
//             ],
//           );
//         });
//   }
// }
