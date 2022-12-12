// import 'dart:math';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:blogger_json_example/views/Editor/Messenger.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gradient_colors/gradient_colors.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:social_share/social_share.dart';

// import 'EditButtons.dart';
// import 'SimpleEditorFunctions.dart';

// class SimpleEditorPage extends StatefulWidget {
//   final String title;
//   final String quote;
//   final List<String>? quotes;

//   const SimpleEditorPage(
//       {Key? key,
//       required this.quotes,
//       required this.title,
//       required this.quote})
//       : super(key: key);

//   @override
//   State<SimpleEditorPage> createState() => _SimpleEditorPageState();
// }

// class _SimpleEditorPageState extends SimpleEditorModel {
//   final Random _random = Random();
//   TextStyle maintextStyle = const TextStyle(
//       fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black12);

//   @override
//   void initState() {
//     createInterstitialAd();
//     setState(() {
//       singlequote = widget.quote;
//       quotesList = widget.quotes;
//       tempQuote = widget.quote;
//       initialPage = quotesList!.indexOf(singlequote!);
//     });
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
//     super.initState();
//   }

//   showSnackBar2() {
//     debugPrint("hjo");
//     Messenger().showAlert(colorPallette());
//   }

//   var boolColorPallete = BoolenValue(false);
//   var boolgradientPallette = BoolenValue(false);
//   final PageController _pageController = PageController();

//   _onTap(BoolenValue dataval) {
//     if (dataval.value) {
//       dataval.value = false;
//       setState(() {});

//       return;
//     }

//     setState(() {});
//     // //Function Call
//     // setContainerColor(paletteColors[_random.nextInt(10)]);
//     // if (dataval.value) {
//     //   debugPrint(" Executed:${dataval.value}");
//     // }
//   }

//   _onLongPress(BoolenValue dataval) {
//     setState(() {
//       dataval.value = !dataval.value;
//       debugPrint("Status2:${dataval.value}");
//     });
//   }

//   _widgetSetter(String value) {
//     if (activeWidget == value) {
//       activeWidget = 'none';
//       setState(() {});
//       return;
//     }
//     activeWidget = value;

//     setState(() {});
//     debugPrint("active:$activeWidget");
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     // interstitialAd?.dispose();

//     debugPrint("Disposed paged");
//     super.dispose();
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//     //     overlays: SystemUiOverlay.values);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//     //     overlays: [SystemUiOverlay.top]);
//     var bottomButtons = Material(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           EditButton(
//             ontap: () => setBackgroundImage(),
//             onLongPress: () => _widgetSetter('BgColor'),
//             title: "Sticker",
//             icon: Icons.image,
//           ),
//           EditButton(
//             ontap: () => setContainerColor(paletteColors[_random.nextInt(12)]),
//             onLongPress: () => _widgetSetter('BgColor'),
//             title: "BgColor",
//             icon: Icons.color_lens,
//           ),
//           EditButton(
//             ontap: () => setGradientColor(_random.nextInt(123)),
//             onLongPress: () => _widgetSetter('Gradient'),
//             title: "Gradient",
//             icon: Icons.gradient,
//           ),
//           EditButton(
//             ontap: () => randomFont(),
//             onLongPress: () => _widgetSetter('Font'),
//             title: "Font",
//             icon: Icons.font_download_outlined,
//           ),
//           // EditButton(
//           //   ontap: () => setTextColor(textColors[genTextlooper()]),
//           //   onLongPress: () => _widgetSetter('textColor'),
//           //   title: "Color",
//           //   icon: Icons.text_format_outlined,
//           // )
//           Consumer(builder: (BuildContext context, ref, _) {
//             ref.watch<ColorChanger>(colorChanger);
//             int genInts = ref.read(colorChanger.notifier).genTextlooper();

//             return EditButton(
//               ontap: () {
//                 int genInt = ref.read(colorChanger.notifier).genTextlooper();
//                 ref
//                     .read(colorChanger.notifier)
//                     .setTextColor(textColors[genInt]);
//               },
//               onLongPress: () => null,
//               title: genInts.toString(),
//               icon: Icons.text_format_outlined,
//             );
//           }),
//           EditButton(
//             ontap: () {
//               showTextSizerDialog(context);
//               // _widgetSetter('none');
//             },
//             onLongPress: () {
//               showTextSizerDialog(context);
//             },
//             title: "Size",
//             icon: Icons.text_fields_outlined,
//           ),
//           EditButton(
//             ontap: () {
//               sequentialQuote();
//             },
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
//                   onPressed: uploadImage,
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
//                     isOnline = await InternetConnectionChecker().hasConnection;
//                     if (!isOnline) {
//                       showInternetDialog(context,
//                           "Internet Connetion is required to Download Images");
//                       return;
//                     }
//                     showInterstitialAd();

//                     setState(() {
//                       showTextSizer = false;
//                       saveTextImageToGallery(context);
//                     });
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
//                   onPressed: shareManager,
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
//                     showExitInterstitialAd();
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
//                   controller: screenshotController,
//                   child: Stack(
//                     children: [
//                       PageView.builder(
//                           onPageChanged: (value) {
//                             sequentialQuote();
//                             tempQuote = quotesList![value];
//                           },
//                           controller: _pageController,
//                           scrollDirection: Axis.horizontal,
//                           itemCount: quotesList!.length,
//                           itemBuilder: (context, int index) {
//                             if (index == quotesList!.length - 1) {
//                               return Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     // const Expanded(
//                                     //     flex: 2,
//                                     //     child: BannerMediumRectangle()),
//                                     const Text('You have Reached to the End!'),
//                                     IconButton(
//                                         onPressed: () {
//                                           if (_pageController.hasClients) {
//                                             _pageController.animateToPage(
//                                               0,
//                                               duration: const Duration(
//                                                   milliseconds: 500),
//                                               curve: Curves.decelerate,
//                                             );
//                                           }
//                                         },
//                                         icon: const Icon(Icons.arrow_back)),
//                                     const SizedBox(
//                                       height: 20,
//                                     )
//                                   ],
//                                 ),
//                               );
//                             }
//                             return Container(
//                               color: initialContainerColor,
//                               child: Container(
//                                 height: MediaQuery.of(context).size.height,
//                                 width: MediaQuery.of(context).size.width,
//                                 decoration: !gradientMode
//                                     ? BoxDecoration(
//                                         image: DecorationImage(
//                                             colorFilter: ColorFilter.mode(
//                                                 initialFilterColor,
//                                                 changeAssetcolor
//                                                     ? BlendMode.srcATop
//                                                     : BlendMode.dstATop),
//                                             fit: BoxFit.fill,
//                                             image: imageReturn()),
//                                       )
//                                     : BoxDecoration(
//                                         gradient: gradientMode
//                                             ? LinearGradient(
//                                                 colors: GradientColors.values[
//                                                     randomGradient.toInt()],

//                                                 tileMode: TileMode.clamp,
//                                                 //begin: Alignment(-1, gradientvalues),
//                                                 //  end: Alignment(gradientvalues, gradientvalues2),
//                                                 // begin: const Alignment(-1, 1),
//                                                 // end: const Alignment(1, 1),

//                                                 // transform: const GradientRotation(-1 * 2),
//                                                 //stops: [1, 4],
//                                               )
//                                             : null,
//                                         color: initialContainerColor,
//                                       ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       SocialShare.copyToClipboard(tempQuote!);
//                                       Messenger()
//                                           .showAlert("Copied to Clipboard");
//                                     },
//                                     onLongPress: () {
//                                       SocialShare.shareOptions(tempQuote!);
//                                     },
//                                     child: Consumer(builder:
//                                         (BuildContext context, ref, _) {
//                                       ref.watch(colorChanger);

//                                       return Center(
//                                         child: RepaintBoundary(
//                                           child: AutoSizeText(tempQuote!,
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                 color: ref
//                                                     .watch(colorChanger.notifier)
//                                                     .initialTextColor,
//                                                 fontSize: ref
//                                                     .watch(colorChanger.notifier)
//                                                     .textSize,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontFamily: fontfamily,
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
//                         visible: croppedFile == null &&
//                             !gradientMode &&
//                             !isTakingScreenshot,
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 0),
//                           child: Align(
//                             alignment: Alignment.bottomCenter,
//                             child: FloatingActionButton.small(
//                               backgroundColor: initialFilterColor,
//                               onPressed: () => setFilterColor(
//                                   paletteColors[_random.nextInt(12)]),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: croppedFile != null && !gradientMode,
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 0),
//                           child: Align(
//                             alignment: Alignment.bottomCenter,
//                             child: FloatingActionButton.small(
//                               backgroundColor: Colors.red,
//                               onPressed: () {
//                                 setState(() {
//                                   setBackgroundImage();
//                                 });
//                               },
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
//               deciderWidget(),
//               Visibility(
//                   visible: boolgradientPallette.value,
//                   child: gradientPallette()),

//               bottomButtons
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// const Color iconcolor = Colors.red;
// const TextStyle labelStyle =
//     TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
