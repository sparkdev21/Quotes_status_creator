// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:blogger_json_example/views/Editor/EditorNotifier.dart';
// import 'package:blogger_json_example/views/Editor/Messenger.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gradient_colors/gradient_colors.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:social_share/social_share.dart';

// import 'EditButtons.dart';
// import 'FlutterUtils.dart';
// import 'ImageCropper.dart';

// class SimpleEditorPage extends ConsumerWidget {
//   final String title;
//   final String quote;

//   SimpleEditorPage({super.key, required this.title, required this.quote});

//   final Random _random = Random();
//   final ScreenshotController screenshotController = ScreenshotController();

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
//           // _exit(context);
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

//   saveTextsImage(Uint8List bytes) async {
//     final time = DateTime.now()
//         .toIso8601String()
//         .replaceAll('.', '-')
//         .replaceAll(':', '-');
//     final name = "screenshot_$time";
//     // Navigator.of(context).push(MaterialPageRoute(
//     //     builder: (context) => WidgetEditableImage(
//     //           imagem: bytes,
//     //           callBackFunc: callback2,
//     //           key: UniqueKey(),
//     //         )));

//     await requestPermission(Permission.storage);
//     await ImageGallerySaver.saveImage(bytes, name: name);

//     debugPrint(name.toString());
//   }

//   void download(context) async {
//     // bool isOnline = await InternetConnectionChecker().hasConnection;
//     // if (!isOnline) {
//     //   showInternetDialog(
//     //       context, "Internet Connetion is required to Share Images");
//     //   return;
//     // }
//     // _screenshotController
//     //     .captureFromWidget(Container(
//     //         padding: const EdgeInsets.all(30.0),
//     //         decoration: BoxDecoration(
//     //           border: Border.all(color: Colors.blueAccent, width: 5.0),
//     //           color: Colors.redAccent,
//     //         ),
//     //         child: Text("This is an invisible widget")))
//     //     .then((capturedImage) {
//     //   Fluttertoast.showToast(msg: "Image is is captured:$capturedImage");
//     // });

//     await screenshotController
//         .capture(delay: const Duration(milliseconds: 10))
//         .then((Uint8List? image) async {
//       if (image == null) {
//         Fluttertoast.showToast(msg: "Image is null");
//       }

//       if (image != null) {
//         final directory = await getApplicationDocumentsDirectory();
//         final imagePath = await File('${directory.path}/image.png').create();
//         await imagePath.writeAsBytes(image);
//         Fluttertoast.showToast(msg: "Image is capture");
//       }

//       //   final directory = await getApplicationDocumentsDirectory();
//       //   final imagePath = await File('${directory.path}/image.png').create();
//       //   await imagePath.writeAsBytes(image);

//       //   /// Share Plugin
//       // }

//       // showInterstitialAd();
//       // Navigator.of(context).push(MaterialPageRoute(
//       //     builder: (context) => SharePageFinal(
//       //           imageBytes: image as Uint8List,
//       //           quote: tempQuote!,
//       //         )));
//     });
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.watch(editorNotifier);
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//     //     overlays: [SystemUiOverlay.top]);
//     var bottomButtons = Material(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           EditButton(
//             ontap: () => ref.read(editorNotifier.notifier).setBackgroundImage(),
//             onLongPress: () => ref
//                 .read(editorNotifier.notifier)
//                 .widgetSetter(Widgets.AssetImage),
//             title: "Sticker",
//             icon: Icons.image,
//           ),
          
//           EditButton(
//             // ontap: () => ref.read(editorNotifier.notifier).setContainerColor(ref
//             //     .read(editorNotifier.notifier)
//             //     .paletteColors[_random.nextInt(12)]),
//             ontap: () => ref
//                 .read(editorNotifier.notifier)
//                 .setContainerColor(_random.nextInt(12)),

//             onLongPress: () =>
//                 ref.read(editorNotifier.notifier).widgetSetter(Widgets.BGColor),
//             title: "BgColor",
//             icon: Icons.color_lens,
//           ),
//           EditButton(
//             ontap: () => ref
//                 .read(editorNotifier.notifier)
//                 .setGradientColor(_random.nextInt(123)),
//             onLongPress: () => ref
//                 .read(editorNotifier.notifier)
//                 .widgetSetter(Widgets.Gradient),
//             title: "Gradient",
//             icon: Icons.gradient,
//           ),
//           EditButton(
//             ontap: () => ref.read(editorNotifier.notifier).randomFont(),
//             onLongPress: () =>
//                 ref.read(editorNotifier.notifier).widgetSetter(Widgets.Font),
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
//             onLongPress: () => ref
//                 .read(editorNotifier.notifier)
//                 .widgetSetter(Widgets.TextColor),
//             title: 'color',
//             icon: Icons.text_format_outlined,
//           ),

//           EditButton(
//             ontap: () {
//               ref.read(editorNotifier.notifier).showTextSizerDialog(context);
//               ref.read(editorNotifier.notifier).widgetSetter(Widgets.None);
//             },
//             onLongPress: () {
//               ref.read(editorNotifier.notifier).showTextSizerDialog(context);
//             },
//             title: "Size",
//             icon: Icons.text_fields_outlined,
//           ),
//           EditButton(
//             ontap: () => null,
//             onLongPress: () => ref
//                 .read(editorNotifier.notifier)
//                 .widgetSetter(Widgets.ColorFilters),
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
//                   onPressed: () async {
//                     // ref.read(editorNotifier.notifier).uploadImage(context);
//                     final _pickedFile = await ImagePicker()
//                         .pickImage(source: ImageSource.gallery);

//                     if (_pickedFile != null)
//                       await ImageCropper()
//                           .cropImage(
//                             sourcePath: _pickedFile.path,
//                             compressFormat: ImageCompressFormat.jpg,
//                             compressQuality: 100,
//                             uiSettings: buildUiSettings(context),
//                           )
//                           .then(
//                             (value) => ref
//                                 .read(editorNotifier.notifier)
//                                 .setCroppedImage(value),
//                           );
//                   },
//                   icon: const Icon(
//                     Icons.image_outlined,
//                     size: 30,
//                   )),
//               const Text("Add Image", style: labelStyle),
//             ],
//           ),
//           Column(
//             children: [
//               IconButton(
//                   tooltip: 'Download Image',
//                   onPressed: () {
//                     // if (!await ref
//                     //     .read(editorNotifier.notifier)
//                     //     .checkNetwork()) {
//                     //   showInternetDialog(context,
//                     //       "Internet Connetion is required to Download Images");
//                     //   return;
//                     // }
//                     // showInterstitialAd();

//                     ref.read(editorNotifier.notifier).setShowTextSizer(false);
//                     download(context);

//                     // showDownloadedDialog(context);
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
//                   onPressed: () => download(context),
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
//                     Navigator.pop(context);
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
//                   key: UniqueKey(),
//                   controller: screenshotController,
//                   child: Stack(
//                     children: [
//                       Container(
//                         color: ref
//                             .watch(editorNotifier.notifier)
//                             .initialContainerColor,
//                         child: Container(
//                           height: MediaQuery.of(context).size.height,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: !ref
//                                   .watch(editorNotifier.notifier)
//                                   .gradientMode
//                               ? BoxDecoration(
//                                   image: DecorationImage(
//                                       colorFilter: ColorFilter.mode(
//                                           ref
//                                               .watch(editorNotifier.notifier)
//                                               .initialFilterColor,
//                                           ref
//                                                   .watch(
//                                                       editorNotifier.notifier)
//                                                   .changeAssetcolor
//                                               ? BlendMode.srcATop
//                                               : BlendMode.dstATop),
//                                       fit: BoxFit.fill,
//                                       image: ref
//                                           .watch(editorNotifier.notifier)
//                                           .imageReturn()),
//                                 )
//                               : BoxDecoration(
//                                   gradient: ref
//                                           .watch(editorNotifier.notifier)
//                                           .gradientMode
//                                       ? LinearGradient(
//                                           colors: GradientColors.values[ref
//                                               .watch(editorNotifier.notifier)
//                                               .randomGradient
//                                               .toInt()],

//                                           tileMode: TileMode.clamp,
//                                           //begin: Alignment(-1, gradientvalues),
//                                           //  end: Alignment(gradientvalues, gradientvalues2),
//                                           // begin: const Alignment(-1, 1),
//                                           // end: const Alignment(1, 1),

//                                           // transform: const GradientRotation(-1 * 2),
//                                           //stops: [1, 4],
//                                         )
//                                       : null,
//                                   color: ref
//                                       .watch(editorNotifier.notifier)
//                                       .initialContainerColor,
//                                 ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: GestureDetector(
//                               onTap: () {
//                                 SocialShare.copyToClipboard(quote);
//                                 Messenger().showAlert("Copied to Clipboard");
//                               },
//                               onLongPress: () {
//                                 SocialShare.shareOptions(quote);
//                               },
//                               child: Center(
//                                 child: AutoSizeText(quote,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: ref
//                                           .watch(editorNotifier.notifier)
//                                           .initialTextColor,
//                                       fontSize: ref
//                                           .watch(editorNotifier.notifier)
//                                           .textSize,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: ref
//                                           .watch(editorNotifier.notifier)
//                                           .fontfamily,
//                                     )),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
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
//                             alignment: Alignment.bottomRight,
//                             child: FloatingActionButton.small(
//                               heroTag: "color",
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
//                             !ref.watch(editorNotifier.notifier).gradientMode &&
//                             !ref
//                                 .read(editorNotifier.notifier)
//                                 .isTakingScreenshot,
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 0),
//                           child: Align(
//                             alignment: Alignment.topLeft,
//                             child: FloatingActionButton.small(
//                               tooltip: "Remove Photo",
//                               heroTag: "album",
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
//               // if (ref.watch(editorNotifier.notifier).croppedFile != null)
//               // WidgetDecider.deciderWidget(
//               //     ref.watch(editorNotifier.notifier).activeWidget),
//               WrapWidgets(),
//               // WidgetDecider.deciderWidget(
//               //     ref.watch(editorNotifier.notifier).activeWidget),

//               bottomButtons
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WidgetDecider {
//   static Widget deciderWidget(Enum value) {
//     switch (value) {
//       case Widgets.None:
//         return SizedBox.shrink();

//       case Widgets.BGColor:
//         return ColorPallette();

//       case Widgets.AssetImage:
//         return FramePallette();

//       case Widgets.Gradient:
//         return GradientPallette();

//       case Widgets.Font:
//         return FontPallette();

//       case Widgets.TextColor:
//         return TextColorPallette();

//       case Widgets.ColorFilters:
//         return Container(
//           color: Colors.red,
//           child: Text("not Implemented"),
//         );

//       default:
//         return SizedBox.shrink();
//     }
//   }
// }

// class CloseButton extends StatelessWidget {
//   final VoidCallback onTap;
//   const CloseButton({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.topCenter,
//       child: IconButton(
//         padding: EdgeInsets.all(2),
//         splashColor: Colors.red,
//         color: Colors.red,
//         onPressed: onTap,
//         icon: Icon(
//           Icons.cancel,
//           color: Colors.black,
//           size: 24,
//         ),
//       ),
//     );
//   }
// }

// class WrapWidgets extends StatelessWidget {
//   const WrapWidgets({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, _) {
//       return Stack(
//         alignment: AlignmentDirectional(0, -29.4),
//         children: [
//           Align(
//             alignment: AlignmentDirectional(0, 0),
//             child: WidgetDecider.deciderWidget(
//                 (ref.watch(editorNotifier.notifier).activeWidget)),
//           ),
//           if (ref.watch(editorNotifier.notifier).activeWidget != Widgets.None)
//             CloseButton(
//                 onTap: (() => ref
//                     .read(editorNotifier.notifier)
//                     .widgetSetter(Widgets.None))),
//         ],
//       );
//     });
//   }
// }

// class ColorPallette extends StatelessWidget {
//   const ColorPallette({super.key});

//   @override
//   Widget build(BuildContext ctx) {
//     return Consumer(builder: (context, ref, _) {
//       return SizedBox(
//         height: 50,
//         child: ListView.separated(
//             separatorBuilder: (context, index) => SizedBox(
//                   width: 1,
//                 ),
//             scrollDirection: Axis.horizontal,
//             itemCount: ref.watch(editorNotifier.notifier).paletteColors.length,
//             itemBuilder: (BuildContext context, i) => GestureDetector(
//                 onTap: () {
//                   ref.read(editorNotifier.notifier).setContainerColor(i);
//                 },
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   color: ref.watch(editorNotifier.notifier).paletteColors[i],
//                   child: i == 0
//                       ? Center(
//                           child: Text(
//                           "None",
//                         ))
//                       : null,
//                 ))),
//       );
//     });
//   }
// }

// class FramePallette extends StatelessWidget {
//   const FramePallette({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, ref, _) {
//       return SizedBox(
//         height: 50,
//         child: ListView.separated(
//             separatorBuilder: (context, index) => SizedBox(
//                   width: 1,
//                 ),
//             scrollDirection: Axis.horizontal,
//             itemCount: ref.watch(editorNotifier.notifier).assetImages.length,
//             itemBuilder: (BuildContext context, i) => GestureDetector(
//                 onTap: () {
//                   ref.read(editorNotifier.notifier).setAssetImage(i);
//                 },
//                 child: Container(
//                     height: 100,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         image: DecorationImage(
//                           colorFilter: ColorFilter.mode(
//                               Colors.transparent, BlendMode.srcATop),
//                           fit: BoxFit.fill,
//                           image: AssetImage(
//                               "assets/images/${ref.watch(editorNotifier.notifier).assetImages[i]}"),
//                         ))))),
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
//         child: ListView.separated(
//             separatorBuilder: (context, index) => SizedBox(
//                   width: 1,
//                 ),
//             scrollDirection: Axis.horizontal,
//             itemCount: ref.watch(editorNotifier.notifier).textColors.length,
//             itemBuilder: (BuildContext context, i) => GestureDetector(
//                 onTap: () {
//                   ref.read(editorNotifier.notifier).setTextColor(
//                       ref.watch(editorNotifier.notifier).textColors[i]);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   height: 50,
//                   width: 50,
//                   color: i == 0
//                       ? Colors.deepOrangeAccent
//                       : ref.watch(editorNotifier.notifier).textColors[i],
//                   child: i == 0
//                       ? Center(
//                           child: Text(
//                           "None",
//                         ))
//                       : null,
//                 ))),
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
//         height: 50,
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
//         height: 50,
//         // color: Theme.of(context).colorScheme.tertiaryContainer,
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
//                 child: SizedBox(
//                   width: 50,
//                   child: Card(
//                     color: Colors.white60,
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Center(
//                         child: AutoSizeText(
//                           "Abc",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontFamily:
//                                   ref.watch(editorNotifier.notifier).fonts[i]),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ))),
//       );
//     });
//   }
// }
