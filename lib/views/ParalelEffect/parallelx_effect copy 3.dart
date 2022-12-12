// import 'dart:convert';

// import 'package:blogger_json_example/models/post_list_model.dart';
// import 'package:blogger_json_example/post_list_view_hive_data.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// import '../../models/love_quotes_english.dart';
// import '../Category_quote_detail_page.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/src/widgets/image.dart' as Real;

// const urlPrefixs =
//     'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
// const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

// final List<Location> locs = [];

// final imagesx = "https://docs.flutter.dev/assets/images/404/dash_nest.png";

// // final postProvider = FutureProvider<PostModel>((ref) async {
// //   // access the provider above
// //   final repository = ref.watch(blogRepositoryProvider);
// //   print("post provider execur=ted");

// //   // use it to return a Future
// //   return repository.fetchPosts();
// // });

// class ExampleParallax extends ConsumerWidget {
//   ExampleParallax({super.key, required this.isHideBottomNavBar});
//   final Function(bool) isHideBottomNavBar;

//   bool _handleScrollNotification(ScrollNotification notification) {
//     if (notification.depth == 0) {
//       if (notification is UserScrollNotification) {
//         final UserScrollNotification userScroll = notification;
//         switch (userScroll.direction) {
//           case ScrollDirection.forward:
//             isHideBottomNavBar(true);
//             break;
//           case ScrollDirection.reverse:
//             isHideBottomNavBar(false);
//             break;
//           case ScrollDirection.idle:
//             break;
//         }
//       }
//     }
//     return false;
//   }

//   final imagesx = "https://docs.flutter.dev/assets/images/404/dash_nest.png";

//   var mydata = <Location>[];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<PostModel> locationd = ref.watch(blogProvider);
//     return NotificationListener<ScrollNotification>(
//       onNotification: _handleScrollNotification,
//       child: locationd.when(
//           loading: () => Center(child: const CircularProgressIndicator()),
//           error: (error, stack) => Center(child: const Text('Oopsies')),
//           data: (datas) {
//             return ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 itemCount: datas.items!.length,
//                 itemBuilder: (context, int i) {
//                   PostModel posts = datas;
//                   List gb = json.decode(posts.items![i].content!);
//                   var quotes =
//                       gb.map((e) => new QuotesModel.fromJson(e)).toList();

//                   return LocationListItem(
//                       onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => CategoryQuoteDetailPage(
//                                   i, posts.items![i].title!, quotes))),
//                       imageUrl: quotes[0].image!,
//                       name: datas.items![i].title!,
//                       country: quotes[0].content!.length.toString());
//                 });
//           }),
//     );
//   }
// }

// class LocationListItem extends StatelessWidget {
//   LocationListItem({
//     super.key,
//     required this.imageUrl,
//     required this.name,
//     required this.country,
//     required this.onTap,
//   });

//   final String imageUrl;
//   final String name;
//   final String country;
//   final VoidCallback onTap;
//   final GlobalKey _backgroundImageKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//       child: AspectRatio(
//         aspectRatio: 16 / 9,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(16),
//           child: GestureDetector(
//             onTap: onTap,
//             child: Stack(
//               children: [
//                 _buildParallaxBackground(context),
//                 _buildGradient(),
//                 _buildTitleAndSubtitle(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildParallaxBackground(BuildContext context) {
//     return Flow(
//       delegate: ParallaxFlowDelegate(
//         scrollable: Scrollable.of(context)!,
//         listItemContext: context,
//         backgroundImageKey: _backgroundImageKey,
//       ),
//       children: [
//         CachedNetworkImage(
//           imageUrl: imageUrl,
//           key: _backgroundImageKey,
//           placeholder: (context, url) => Real.Image.asset('assets/image.jpg'),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         ),
//         // CachedNetworkImage(
//         //   imageUrl: imageUrl,

//         //   errorWidget: (context, url, error) => Icon(Icons.error),
//         // ),
//       ],
//     );
//   }

//   Widget _buildGradient() {
//     return Positioned.fill(
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             stops: const [0.6, 0.95],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTitleAndSubtitle() {
//     return Positioned(
//       left: 20,
//       bottom: 20,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             name,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(
//             height: 3,
//           ),
//           Text(
//             country,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ParallaxFlowDelegate extends FlowDelegate {
//   ParallaxFlowDelegate({
//     required this.scrollable,
//     required this.listItemContext,
//     required this.backgroundImageKey,
//   }) : super(repaint: scrollable.position);

//   final ScrollableState scrollable;
//   final BuildContext listItemContext;
//   final GlobalKey backgroundImageKey;

//   @override
//   BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
//     return BoxConstraints.tightFor(
//       width: constraints.maxWidth,
//     );
//   }

//   @override
//   void paintChildren(FlowPaintingContext context) {
//     // Calculate the position of this list item within the viewport.
//     final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
//     final listItemBox = listItemContext.findRenderObject() as RenderBox;
//     final listItemOffset = listItemBox.localToGlobal(
//         listItemBox.size.centerLeft(Offset.zero),
//         ancestor: scrollableBox);

//     // Determine the percent position of this list item within the
//     // scrollable area.
//     final viewportDimension = scrollable.position.viewportDimension;
//     final scrollFraction =
//         (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

//     // Calculate the vertical alignment of the background
//     // based on the scroll percent.
//     final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

//     // Convert the background alignment into a pixel offset for
//     // painting purposes.
//     final backgroundSize =
//         (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
//             .size;
//     final listItemSize = context.size;
//     final childRect =
//         verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

//     // Paint the background.
//     context.paintChild(
//       0,
//       transform:
//           Transform.translate(offset: Offset(0.0, childRect.top)).transform,
//     );
//   }

//   @override
//   bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
//     return scrollable != oldDelegate.scrollable ||
//         listItemContext != oldDelegate.listItemContext ||
//         backgroundImageKey != oldDelegate.backgroundImageKey;
//   }
// }

// class Parallax extends SingleChildRenderObjectWidget {
//   const Parallax({
//     super.key,
//     required Widget background,
//   }) : super(child: background);

//   @override
//   RenderObject createRenderObject(BuildContext context) {
//     return RenderParallax(scrollable: Scrollable.of(context)!);
//   }

//   @override
//   void updateRenderObject(
//       BuildContext context, covariant RenderParallax renderObject) {
//     renderObject.scrollable = Scrollable.of(context)!;
//   }
// }

// class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

// class RenderParallax extends RenderBox
//     with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
//   RenderParallax({
//     required ScrollableState scrollable,
//   }) : _scrollable = scrollable;

//   ScrollableState _scrollable;

//   ScrollableState get scrollable => _scrollable;

//   set scrollable(ScrollableState value) {
//     if (value != _scrollable) {
//       if (attached) {
//         _scrollable.position.removeListener(markNeedsLayout);
//       }
//       _scrollable = value;
//       if (attached) {
//         _scrollable.position.addListener(markNeedsLayout);
//       }
//     }
//   }

//   @override
//   void attach(covariant PipelineOwner owner) {
//     super.attach(owner);
//     _scrollable.position.addListener(markNeedsLayout);
//   }

//   @override
//   void detach() {
//     _scrollable.position.removeListener(markNeedsLayout);
//     super.detach();
//   }

//   @override
//   void setupParentData(covariant RenderObject child) {
//     if (child.parentData is! ParallaxParentData) {
//       child.parentData = ParallaxParentData();
//     }
//   }

//   @override
//   void performLayout() {
//     size = constraints.biggest;

//     // Force the background to take up all available width
//     // and then scale its height based on the image's aspect ratio.
//     final background = child!;
//     final backgroundImageConstraints =
//         BoxConstraints.tightFor(width: size.width);
//     background.layout(backgroundImageConstraints, parentUsesSize: true);

//     // Set the background's local offset, which is zero.
//     (background.parentData as ParallaxParentData).offset = Offset.zero;
//   }

//   @override
//   void paint(PaintingContext context, Offset offset) {
//     // Get the size of the scrollable area.
//     final viewportDimension = scrollable.position.viewportDimension;

//     // Calculate the global position of this list item.
//     final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
//     final backgroundOffset =
//         localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

//     // Determine the percent position of this list item within the
//     // scrollable area.
//     final scrollFraction =
//         (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

//     // Calculate the vertical alignment of the background
//     // based on the scroll percent.
//     final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

//     // Convert the background alignment into a pixel offset for
//     // painting purposes.
//     final background = child!;
//     final backgroundSize = background.size;
//     final listItemSize = size;
//     final childRect =
//         verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

//     // Paint the background.
//     context.paintChild(
//         background,
//         (background.parentData as ParallaxParentData).offset +
//             offset +
//             Offset(0.0, childRect.top));
//   }
// }

// class Location {
//   const Location({
//     required this.name,
//     required this.place,
//     required this.imageUrl,
//   });

//   final String name;
//   final String place;
//   final String imageUrl;
// }

// const urlPrefix =
//     'https://docs.flutter.dev/cookbook/img-files/effects/parallax';
// const locations = [
//   Location(
//     name: 'Mount Rushmore',
//     place: 'U.S.A',
//     imageUrl: '$urlPrefix/01-mount-rushmore.jpg',
//   ),
//   Location(
//     name: 'Gardens By The Bay',
//     place: 'Singapore',
//     imageUrl: '$urlPrefix/02-singapore.jpg',
//   ),
//   Location(
//     name: 'Machu Picchu',
//     place: 'Peru',
//     imageUrl: '$urlPrefix/03-machu-picchu.jpg',
//   ),
//   Location(
//     name: 'Vitznau',
//     place: 'Switzerland',
//     imageUrl: '$urlPrefix/04-vitznau.jpg',
//   ),
//   Location(
//     name: 'Bali',
//     place: 'Indonesia',
//     imageUrl: '$urlPrefix/05-bali.jpg',
//   ),
//   Location(
//     name: 'Mexico City',
//     place: 'Mexico',
//     imageUrl: '$urlPrefix/06-mexico-city.jpg',
//   ),
//   Location(
//     name: 'Cairo',
//     place: 'Egypt',
//     imageUrl: '$urlPrefix/07-cairo.jpg',
//   ),
// ];
