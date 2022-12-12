// import 'dart:math';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:blogger_json_example/views/Editor/EditorNotifier.dart';
// import 'package:blogger_json_example/views/Editor/Messenger.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gradient_colors/gradient_colors.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:social_share/social_share.dart';

// import 'EditButtons.dart';

// class SimpleEditorPage extends ConsumerStatefulWidget {
//   final String title;
//   final String quote;

//   SimpleEditorPage(
//       {Key? key,
//       required this.title,
//       required this.quote})
//       : super(key: key);

//   @override
//   SimpleEditorPageState createState() => SimpleEditorPageState();
// }

// class SimpleEditorPageState extends ConsumerState<SimpleEditorPage> {
//   final Random _random = Random();
//   late String quote;

//   final PageController _pageController = PageController();
//   final ScreenshotController _screenshotController = ScreenshotController();

//   @override
//   void initState() {
//     quote = widget.quote;
//     super.initState();
//   }

//   showInternetDialog(context, String text) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//               backgroundColor: Colors.red.shade100,
//               content: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   text,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 24),
//                 ),
//               ),
//               actions: [
//                 IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close))
//               ],
//             ));
//   }

//   _exit(context) async {
//     Future.delayed(const Duration(seconds: 8), () {
//       // 5s over, navigate to a new page
//       Navigator.pop(context);
//     });
//   }

//   showDownloadedDialog(context) async {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           _exit(context);
//           return AlertDialog(
//             backgroundColor: Colors.green.shade100,
//             content: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 "Successfully Downloaded and Saved in Gallery",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             actions: [
//               IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(Icons.done))
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     ref.watch(editorNotifier);
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//     //     overlays: [SystemUiOverlay.top]);
//     var bottomButtons = Material(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           EditButton(
//             ontap: () => ref.read(editorNotifier.notifier).setBackgroundImage(),
//             onLongPress: () =>
//                 ref.read(editorNotifier.notifier).widgetSetter('BgColor'),
//             title: "Sticker",
//             icon: Icons.image,
//           ),
//           EditButton(
//             ontap: () => ref.read(editorNotifier.notifier).setContainerColor(ref
//                 .read(editorNotifier.notifier)
//                 .paletteColors[_random.nextInt(12)]),
//             onLongPress: () =>
//                 ref.read(editorNotifier.notifier).widgetSetter('BgColor'),
//             title: "BgColor",
//             icon: Icons.color_lens,
//           ),
//           EditButton(
//             ontap: () => ref
//                 .read(editorNotifier.notifier)
//                 .setGradientColor(_random.nextInt(123)),
//             onLongPress: () =>
//                 ref.read(editorNotifier.notifier).widgetSetter('Gradient'),
//             title: "Gradient",
//             icon: Icons.gradient,
//           ),
//           EditButton(
//             ontap: () => ref.read(editorNotifier.notifier).randomFont(),
//             onLongPress: () =>
//                 ref.read(editorNotifier.notifier).widgetSetter('Font'),
//             title: "Font",
//             icon: Icons.font_download_outlined,
//           ),
//           // EditButton(
//           //   ontap: () => setTextColor(textColors[genTextlooper()]),
//           //   onLongPress: () => _widgetSetter('textColor'),
//           //   title: "Color",
//           //   icon: Icons.text_format_outlined,
//           // )
//           EditButton(
//             ontap: () {
//               int genInt = ref.read(editorNotifier.notifier).genTextlooper();
//               ref.read(editorNotifier.notifier).setTextColor(
//                   ref.read(editorNotifier.notifier).textColors[genInt]);
//             },
//             onLongPress: () =>
//                 ref.read(editorNotifier.notifier).widgetSetter('textColor'),
//             title: 'color',
//             icon: Icons.text_format_outlined,
//           ),

//           EditButton(
//             ontap: () {
//               ref.read(editorNotifier.notifier).showTextSizerDialog(context);
//               ref.read(editorNotifier.notifier).widgetSetter('none');
//             },
//             onLongPress: () {
//               ref.read(editorNotifier.notifier).showTextSizerDialog(context);
//             },
//             title: "Size",
//             icon: Icons.text_fields_outlined,
//           ),
//           EditButton(
//             ontap: () => ref.read(editorNotifier.notifier).sequentialQuote(),
//             onLongPress: () {},
//             title: "Next",
//             icon: Icons.arrow_forward,
//           ),
//         ],
//       ),
//     );
//     var topButtons = Material(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Column(
//             children: [
//               IconButton(
//                   tooltip: 'Upload Image',
//                   onPressed: ref.read(editorNotifier.notifier).uploadImage,
//                   icon: const Icon(
//                     Icons.upload_file_outlined,
//                     size: 30,
//                   )),
//               const Text("Upload", style: labelStyle),
//             ],
//           ),
//           Column(
//             children: [
//               IconButton(
//                   tooltip: 'Download Image',
//                   onPressed: () async {
//                     final isOnline =
//                         await ref.read(editorNotifier.notifier).checkNetwork();
//                     if (!isOnline) {
//                       showInternetDialog(context,
//                           "Internet Connetion is required to Download Images");
//                       return;
//                     }
//                     // showInterstitialAd();

//                     ref.read(editorNotifier.notifier).showTextSizer = false;
//                     ref
//                         .read(editorNotifier.notifier)
//                         .saveTextImageToGallery(context);

//                     showDownloadedDialog(context);
//                   },
//                   icon: const Icon(
//                     Icons.download,
//                     size: 30,
//                   )),
//               const Text(
//                 "Download",
//                 style: labelStyle,
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               IconButton(
//                   tooltip: 'Share ',
//                   onPressed: () =>
//                       ref.read(editorNotifier.notifier).shareManager,
//                   icon: const Icon(
//                     Icons.share,
//                     size: 30,
//                   )),
//               const Text("Share", style: labelStyle),
//             ],
//           ),
//           Column(
//             children: [
//               IconButton(
//                   tooltip: 'Close ',
//                   onPressed: () {
//                     // showExitInterstitialAd();
//                   },
//                   icon: const Icon(
//                     Icons.close,
//                     size: 30,
//                   )),
//               const Text("Close", style: labelStyle),
//             ],
//           ),
//         ],
//       ),
//     );
//     return Material(
//       color: Theme.of(context).colorScheme.background,
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: [
//               // const BannerSmall(),
//               topButtons,
//               Expanded(
//                 child: Screenshot(
//                   controller: _screenshotController,
//                   child: Stack(
//                     children: [
//                       PageView.builder(
//                           onPageChanged: (value) {
//                             ref.read(editorNotifier.notifier).sequentialQuote();
//                             ref.read(editorNotifier.notifier).changeQuote(ref
//                                 .read(editorNotifier.notifier)
//                                 .quotesList![value]);
//                           },
//                           controller: _pageController,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: ref
//                               .read(editorNotifier.notifier)
//                               .quotesList!
//                               .length,
//                           itemBuilder: (context, int index) {
//                             // if (index ==
//                             //     ref.read(editorNotifier.notifier)
//                             //             .quotesList!
//                             //             .length -
//                             //         1) {
//                             //   return Center(
//                             //     child: Column(
//                             //       mainAxisAlignment: MainAxisAlignment.center,
//                             //       children: [
//                             //         // const Expanded(
//                             //         //     flex: 2,
//                             //         //     child: BannerMediumRectangle()),
//                             //         const Text('You have Reached to the End!'),
//                             //         IconButton(
//                             //             onPressed: () {
//                             //               if (_pageController.hasClients) {
//                             //                 _pageController.animateToPage(
//                             //                   0,
//                             //                   duration: const Duration(
//                             //                       milliseconds: 500),
//                             //                   curve: Curves.decelerate,
//                             //                 );
//                             //               }
//                             //             },
//                             //             icon: const Icon(Icons.arrow_back)),
//                             //         const SizedBox(
//                             //           height: 20,
//                             //         )
//                             //       ],
//                             //     ),
//                             //   );
//                             // }
//                             return Container(
//                               color: ref
//                                   .read(editorNotifier.notifier)
//                                   .initialContainerColor,
//                               child: Container(
//                                 height: MediaQuery.of(context).size.height,
//                                 width: MediaQuery.of(context).size.width,
//                                 decoration: !ref
//                                         .read(editorNotifier.notifier)
//                                         .gradientMode
//                                     ? BoxDecoration(
//                                         image: DecorationImage(
//                                             colorFilter: ColorFilter.mode(
//                                                 ref
//                                                     .read(
//                                                         editorNotifier.notifier)
//                                                     .initialFilterColor,
//                                                 ref
//                                                         .read(editorNotifier
//                                                             .notifier)
//                                                         .changeAssetcolor
//                                                     ? BlendMode.srcATop
//                                                     : BlendMode.dstATop),
//                                             fit: BoxFit.fill,
//                                             image: ref
//                                                 .read(editorNotifier.notifier)
//                                                 .imageReturn()),
//                                       )
//                                     : BoxDecoration(
//                                         gradient: ref
//                                                 .watch(editorNotifier.notifier)
//                                                 .gradientMode
//                                             ? LinearGradient(
//                                                 colors: GradientColors.values[
//                                                     ref
//                                                         .watch(editorNotifier
//                                                             .notifier)
//                                                         .randomGradient
//                                                         .toInt()],

//                                                 tileMode: TileMode.clamp,
//                                                 //begin: Alignment(-1, gradientvalues),
//                                                 //  end: Alignment(gradientvalues, gradientvalues2),
//                                                 // begin: const Alignment(-1, 1),
//                                                 // end: const Alignment(1, 1),

//                                                 // transform: const GradientRotation(-1 * 2),
//                                                 //stops: [1, 4],
//                                               )
//                                             : null,
//                                         color: ref
//                                             .watch(editorNotifier.notifier)
//                                             .initialContainerColor,
//                                       ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       SocialShare.copyToClipboard(quote);
//                                       Messenger()
//                                           .showAlert("Copied to Clipboard");
//                                     },
//                                     onLongPress: () {
//                                       SocialShare.shareOptions(quote);
//                                     },
//                                     child: Consumer(builder:
//                                         (BuildContext context, ref, _) {
//                                       ref.watch(editorNotifier);

//                                       return Center(
//                                         child: RepaintBoundary(
//                                           child: AutoSizeText(quote,
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ref
//                                                     .watch(
//                                                         editorNotifier.notifier)
//                                                     .initialTextColor,
//                                                 fontSize: ref
//                                                     .watch(
//                                                         editorNotifier.notifier)
//                                                     .textSize,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontFamily: ref
//                                                     .watch(
//                                                         editorNotifier.notifier)
//                                                     .fontfamily,
//                                               )),
//                                         ),
//                                       );
//                                     }),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                       Visibility(
//                         visible: ref
//                                     .watch(editorNotifier.notifier)
//                                     .croppedFile ==
//                                 null &&
//                             !ref.watch(editorNotifier.notifier).gradientMode &&
//                             !ref
//                                 .watch(editorNotifier.notifier)
//                                 .isTakingScreenshot,
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 0),
//                           child: Align(
//                             alignment: Alignment.bottomCenter,
//                             child: FloatingActionButton.small(
//                               backgroundColor: ref
//                                   .watch(editorNotifier.notifier)
//                                   .initialFilterColor,
//                               onPressed: () => ref
//                                   .read(editorNotifier.notifier)
//                                   .setFilterColor(ref
//                                       .watch(editorNotifier.notifier)
//                                       .paletteColors[_random.nextInt(12)]),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: ref
//                                     .watch(editorNotifier.notifier)
//                                     .croppedFile !=
//                                 null &&
//                             !ref.watch(editorNotifier.notifier).gradientMode,
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 0),
//                           child: Align(
//                             alignment: Alignment.bottomCenter,
//                             child: FloatingActionButton.small(
//                               backgroundColor: Colors.red,
//                               onPressed: () => ref
//                                   .read(editorNotifier.notifier)
//                                   .setBackgroundImage(),
//                               child: const Icon(
//                                   Icons.image_not_supported_outlined),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               //BottomButtons
//               deciderWidget(ref.watch(editorNotifier.notifier).activeWidget),
//               Visibility(
//                   visible:
//                       ref.watch(editorNotifier.notifier).showGradientPallette,
//                   child: gradientPallette()),

//               bottomButtons
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget deciderWidget(value) {
//   switch (value) {
//     case "none":
//       return Container(
//         color: Colors.red,
//       );

//     case "BgColor":
//       return ColorPallette();

//     case "Gradient":
//       return GradientPallette();

//     case "Font":
//       return FontPallette();

//     case "textColor":
//       return TextColorPallette();

//     default:
//       return Container();
//   }
// }

// Widget fontsPallette() {
//   return Consumer(builder: (context, ref, _) {
//     return Container(
//       height: 40,
//       color: Theme.of(context).colorScheme.tertiaryContainer,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: ref.read(editorNotifier.notifier).fonts.length,
//           itemBuilder: (BuildContext context, i) => GestureDetector(
//               onTap: () {
//                 ref
//                     .read(editorNotifier.notifier)
//                     .setFontFamily(ref.read(editorNotifier.notifier).fonts[i]);
//                 debugPrint(
//                     "font:${ref.read(editorNotifier.notifier).fonts[i]}");
//               },
//               child: Card(
//                 color: Colors.white60,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Abc",
//                     style: TextStyle(
//                         fontFamily: ref.read(editorNotifier.notifier).fonts[i]),
//                   ),
//                 ),
//               ))),
//     );
//   });
// }

// Widget gradientPallette() {
//   debugPrint("Gradient Widget is BUilding");
//   return Consumer(builder: (context, ref, _) {
//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 100,
//         itemBuilder: (BuildContext context, i) => GestureDetector(
//           onTap: () => ref.read(editorNotifier.notifier).setGradientColor(i),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                   height: 100,
//                   width: 100,
//                   decoration: BoxDecoration(
//                       gradient:
//                           LinearGradient(colors: GradientColors.values[i]))),
//               Text(GradientColors.colorsname[i].toString().split(".")[1])
//             ],
//           ),
//         ),
//       ),
//     );
//   });
// }

// class ColorPallette extends StatelessWidget {
//   const ColorPallette({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, _) {
//       return SizedBox(
//         height: 50,
//         child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: ref.watch(editorNotifier.notifier).paletteColors.length,
//             itemBuilder: (BuildContext context, i) => GestureDetector(
//                 onTap: () {
//                   ref.read(editorNotifier.notifier).setContainerColor(
//                       ref.read(editorNotifier.notifier).paletteColors[i]);
//                 },
//                 child: Container(
//                     height: 50,
//                     width: 50,
//                     color:
//                         ref.watch(editorNotifier.notifier).paletteColors[i]))),
//       );
//     });
//   }
// }

// class TextColorPallette extends StatelessWidget {
//   const TextColorPallette({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, _) {
//       return SizedBox(
//         height: 50,
//         child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: ref.watch(editorNotifier.notifier).textColors.length,
//             itemBuilder: (BuildContext context, i) => GestureDetector(
//                 onTap: () {
//                   ref.read(editorNotifier.notifier).setTextColor(
//                       ref.read(editorNotifier.notifier).textColors[i]);
//                 },
//                 child: Container(
//                     height: 50,
//                     width: 50,
//                     color: ref.watch(editorNotifier.notifier).textColors[i]))),
//       );
//     });
//   }
// }

// const Color iconcolor = Colors.red;
// const TextStyle labelStyle =
//     TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

// class GradientPallette extends StatelessWidget {
//   const GradientPallette({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, _) {
//       return SizedBox(
//         height: 100,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: 100,
//           itemBuilder: (BuildContext context, i) => GestureDetector(
//             onTap: () => ref.read(editorNotifier.notifier).setGradientColor(i),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                     height: 100,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         gradient:
//                             LinearGradient(colors: GradientColors.values[i]))),
//                 Text(GradientColors.colorsname[i].toString().split(".")[1])
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// class FontPallette extends StatelessWidget {
//   const FontPallette({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, _) {
//       return Container(
//         height: 40,
//         color: Theme.of(context).colorScheme.tertiaryContainer,
//         child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: ref.watch(editorNotifier.notifier).fonts.length,
//             itemBuilder: (BuildContext context, i) => GestureDetector(
//                 onTap: () {
//                   ref.read(editorNotifier.notifier).setFontFamily(
//                       ref.read(editorNotifier.notifier).fonts[i]);
//                   debugPrint(
//                       "font:${ref.read(editorNotifier.notifier).fonts[i]}");
//                 },
//                 child: Card(
//                   color: Colors.white60,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Abc",
//                       style: TextStyle(
//                           fontFamily:
//                               ref.watch(editorNotifier.notifier).fonts[i]),
//                     ),
//                   ),
//                 ))),
//       );
//     });
//   }
// }
