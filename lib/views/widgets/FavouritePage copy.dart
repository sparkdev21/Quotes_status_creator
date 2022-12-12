// import 'package:blogger_json_example/post_list_view_hive_data.dart';
// import 'package:blogger_json_example/services/store_quotes.dart';
// import 'package:flutter/material.dart';

// import 'package:hive_flutter/hive_flutter.dart';

// class FavouritePage extends StatefulWidget {
//   const FavouritePage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _FavouritePageState createState() => _FavouritePageState();
// }

// class _FavouritePageState extends State<FavouritePage> {
//   late final Box contactBox;
//   StoreQuotes sq = StoreQuotes();
//   // Delete info from people box
//   _deleteInfo(int index) {
//     contactBox.deleteAt(index);

//     print('Item deleted from box at index: $index');
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Get reference to an already opened box
//     contactBox = Hive.box(sq.catBoxName());
//   }

//   @override
//   Widget build(BuildContext context) {
//     var valueListenableBuilder = ValueListenableBuilder(
//       valueListenable: contactBox.listenable(),
//       builder: (context, Box box, widget) {
//         if (box.isEmpty) {
//           return const Center(
//             child: Text('Empty'),
//           );
//         } else {
//           return ListView.builder(
//             itemCount: box.length,
//             itemBuilder: (context, index) {
//               var currentBox = box;
//               var personData = currentBox.getAt(index)!;

//               return InkWell(
//                 // onTap: () => Navigator.of(context).push(
//                 //   MaterialPageRoute(
//                 //     builder: (context) => UpdateScreen(
//                 //       index: index,
//                 //       person: personData,
//                 //     ),
//                 //   ),
//                 // ),
//                 child: Material(
//                   elevation: 7,
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.all(8),
//                     style: ListTileStyle.list,
//                     minVerticalPadding: 10,
//                     title: Text(personData.toString()),
//                     subtitle: Column(
//                       children: [
//                         const Divider(
//                           color: Colors.white60,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             IconButton(
//                               onPressed: () => _deleteInfo(index),
//                               icon: const Icon(
//                                 Icons.edit,
//                                 color: Colors.red,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () => _deleteInfo(index),
//                               icon: const Icon(
//                                 Icons.share,
//                                 color: Colors.red,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () => _deleteInfo(index),
//                               icon: const Icon(
//                                 Icons.delete,
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     // trailing: IconButton(
//                     //   padding: EdgeInsets.symmetric(vertical: 8),
//                     //   focusColor: Colors.amber,
//                     //   autofocus: true,
//                     //   onPressed: () => _deleteInfo(index),
//                     //   icon: Icon(
//                     //     Icons.delete,
//                     //     color: Colors.red,
//                     //   ),
//                     // ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favourites'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => PostHiveData(),
//           ),
//         ),
//         child: const Icon(Icons.add),
//       ),
//       body: valueListenableBuilder,
//     );
//   }
// }
// class FavouriteButton extends ConsumerWidget {
//   final String quote;
//   final String typeOfQuote;
//   const FavouriteButton(
//       {Key? key, required this.quote, required this.typeOfQuote})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final favProvider = ref.watch(favNotifier);
//     return IconButton(
//         onPressed: () {
//           final quotes = HiveQuoteDataModel(
//               category: typeOfQuote,
//               language: typeOfQuote.contains(RegExp(r'hindi|hindi'))
//                   ? 'hindi'
//                   : 'english',
//               isFavourite: true,
//               quote: quote);
//           favProvider.addToFav(quotes);
//           favProvider.changeFav();
//         },
//         icon: Icon(favProvider.isFav(quote)
//             ? Icons.favorite
//             : Icons.favorite_outline,color: favProvider.isFav(quote)?Colors.red:Colors.black,)); // Hello world
//   }
// }
