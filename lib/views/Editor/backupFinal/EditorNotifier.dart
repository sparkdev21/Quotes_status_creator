// import 'dart:io';

// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:quotes_status_creator/Constants/Thmes.dart';

// import '../../Monetization/AdHelpers.dart';
// import '/views/Editor/AlertStatefulDialog.dart';
// import '/views/Editor/FlutterUtils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:screenshot/screenshot.dart';

// import 'ImageCropper.dart';

// final editorNotifier =
//     ChangeNotifierProvider.autoDispose<EditorNotifier>((ref) {
//   return EditorNotifier();
// });

// enum Widgets {
//   BGColor,
//   TextColor,
//   Frames,
//   Font,
//   Gradient,
//   AssetImage,
//   Size,
//   ColorFilters,
//   None,
//   Pop
// }

// class EditorNotifier extends ChangeNotifier {
//   EditorNotifier();
//   final _screenshotController = ScreenshotController();

//   final List<Color> textColors = [
//     Colors.black,
//     Colors.white,
//     Colors.brown,
//     Colors.green,
//     Colors.deepPurple,
//     Colors.pink,
//     Colors.teal,
//     Colors.yellow,
//     Colors.black54,
//     Colors.white54
//   ];
//   final List<Color> _paletteColors = [
//     Colors.white,
//     Colors.black,
//     Colors.white,
//     Colors.red,
//     Colors.blue,
//     Colors.red,
//     Colors.brown,
//     Colors.green,
//     Colors.indigoAccent,
//     Colors.lime,
//     Colors.cyan,
//     Colors.deepPurple,
//     Colors.lightGreen,
//     Colors.pink,
//     Colors.teal,
//     Colors.yellow,
//     Colors.transparent
//   ];
//   final List<String> fonts = [
//     'Billabong',
//     'ChunkFive',
//     'Arizonia',
//     'Quicksand',
//     'Roboto',
//     'Oswald',
//     'SEASRN',
//     'Lobster',
//     'OpenSans',
//     'OstrichSans',
//   ];
//   final List<String> assetImages = [
//     "ini.png",
//     "bg.png",
//     "1.png",
//     "2.png",
//     "3.png",
//     "4.png",
//     "5.png",
//     "7.png",
//     "8.png",
//     "9.png",
//     "10.png",
//     "11.png",
//     "12.png",
//     "13.png",
//     "14.png",
//     "15.png",
//     "16.png",
//     "18.png",
//     "19.png",
//     "20.png",
//     "21.png",
//     "22.png",
//     "23.png",
//     "24.png",
//     "25.png",
//     "26.png",
//     "27.png",
//     "28.png",
//     "29.png",
//     "30.png",
//     "31.png",
//     "32.png",
//     "33.png",
//     "34.png",
//     "35.png",
//     "36.png",
//     "37.png"
//   ];

//   ///ads related
//   /////Ads Counters
//   int fontChangeCountAds = 0;
//   int gradientChnageCountAds = 0;
//   int imagechangeCounterAds = 0;
//   int textColorCountAds = 0;
//   int backgroundColorCountads = 0;
//   int nextButtonCounterAds = 0;
//   static const int maxFailedLoadAttempts = 3;
//   int _numInterstitialLoadAttempts = 0;
//   InterstitialAd? interstitialAd;
//   clearadsCount() {
//     fontChangeCountAds = 0;
//     textColorCountAds = 0;
//     backgroundColorCountads = 0;
//     nextButtonCounterAds = 0;
//     gradientChnageCountAds = 0;
//     backgroundColorCountads = 0;
//     imagechangeCounterAds = 0;
//   }

//   adsManger(int value, String button) {
//     if (button == 'font' && value >= 4) {
//       fontChangeCountAds = 0;

//       showInterstitialAd();
//       clearadsCount();
//     }
//     if (button == 'textColor' && value >= 6) {
//       textColorCountAds = 0;
//       showInterstitialAd();
//       clearadsCount();
//     }
//     if (button == 'gradient' && value >= 6) {
//       showInterstitialAd();
//       clearadsCount();
//     }
//     if (button == 'next' && value >= 6) {
//       showInterstitialAd();
//       clearadsCount();
//     }
//     if (button == 'image' && value >= 4) {
//       showInterstitialAd();
//       clearadsCount();
//     }
//     if (button == 'backColor' && value >= 8) {
//       showInterstitialAd();
//       clearadsCount();
//     }
//     if (button == 'favorite' && value >= 4) {
//       showInterstitialAd();
//       clearadsCount();
//     }
//     // if (button == 'blend' && value == 2) {
//     //   showInterstitialAd();
//     //   clearadsCount();
//     // }
//   }

//   void createInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: AdHelper.interstitialGoogleTestAdUnitId,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             debugPrint('$ad loaded');
//             interstitialAd = ad;
//             _numInterstitialLoadAttempts = 0;
//             // _interstitialAd!.setImmersiveMode(true);
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             debugPrint('InterstitialAd failed to load: $error.');
//             _numInterstitialLoadAttempts += 1;
//             interstitialAd = null;
//             if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
//               createInterstitialAd();
//             }
//           },
//         ));
//   }

//   void showDownInterstitialAd(context) {
//     if (interstitialAd == null) {
//       successToast(context);
//       debugPrint('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           debugPrint('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         debugPrint('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         successToast(context);
//         createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         createInterstitialAd();
//       },
//     );
//     interstitialAd!.show();
//     interstitialAd = null;
//   }

//   void showInterstitialAd() {
//     if (interstitialAd == null) {
//       debugPrint('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           debugPrint('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         debugPrint('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         createInterstitialAd();
//       },
//     );
//     interstitialAd!.show();
//     interstitialAd = null;
//   }

//   void showExitInterstitialAd(context) {
//     if (interstitialAd == null) {
//       debugPrint('Warning: attempt to show interstitial before loaded.');
//       Navigator.pop(context);
//       return;
//     }
//     interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           debugPrint('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         debugPrint('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         Navigator.pop(context);
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         createInterstitialAd();
//       },
//     );
//     interstitialAd!.show();
//     interstitialAd = null;
//   }

// // protrait Modeown
//   void protraitMode() {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
//     notifyListeners();
//   }

// // Active Widget Setter
//   Enum _activeWidget = Widgets.None;
//   get activeWidget => _activeWidget;
//   widgetSetter(Enum value) {
//     if (_activeWidget == value) {
//       _activeWidget = Widgets.None;
//       notifyListeners();
//       return;
//     }
//     _activeWidget = value;

//     notifyListeners();
//   }

// // Text Colour Widgets
//   int textColorLooperIndex = 0;

//   List<Color> get paletteColors => _paletteColors;
//   Color initialTextColor = Colors.black;
//   genTextlooper() {
//     if (textColorLooperIndex == textColors.length - 1) {
//       textColorLooperIndex = 0;
//     } else {
//       textColorLooperIndex++;
//     }
//     notifyListeners();
//     return textColorLooperIndex;
//   }

//   setTextColor(Color value) {
//     textColorCountAds++;
//     adsManger(textColorCountAds, 'textColor');
//     initialTextColor = value;
//     notifyListeners();
//   }

// // Text Size
//   double _textSize = 24.0;
//   double get textSize => _textSize;
//   setTextSize(double value) {
//     _textSize = value;
//     notifyListeners();
//   }

//   // Text Style
//   TextStyle _maintextStyle = const TextStyle(
//       fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black12);

//   get mainTextStyle => _maintextStyle;

//   // font Changer
//   String _fontfamily = 'Billabong';
//   get fontfamily => _fontfamily;
//   bool _showTextSizer = false;
//   get showTextSizer => _showTextSizer;
//   setShowTextSizer(bool value) {
//     _showTextSizer = false;
//     notifyListeners();
//   }

//   setFontFamily(String value) {
//     _showTextSizer = false;
//     _fontfamily = value;
//     notifyListeners();
//   }

//   void randomFont() {
//     fontChangeCountAds++;
//     adsManger(fontChangeCountAds, 'font');
//     int currentIndex = fonts.indexOf(_fontfamily);
//     if (currentIndex >= fonts.length - 1) {
//       currentIndex = fonts.indexOf('Billabong');
//     }
//     String nextFlashcard = fonts[currentIndex + 1];
//     _fontfamily = nextFlashcard;
//     notifyListeners();
//   }

// // Background Image
//   String initialAssetImage = 'upload.jpg';
//   Uint8List? imagebytes;

//   bool _isAssetImageActive = true;
//   get isAssetImageActive => _isAssetImageActive;

//   // String getAssetImage(int value) {
//   //   Future.delayed(Duration(milliseconds: 2,))
//   //   return assetImages[value];
//   // }

//   setAssetImage(int value) {
//     _isAssetImageActive = true;
//     croppedFile = null;
//     gradientMode = false;
//     initialAssetImage = assetImages[value];

//     notifyListeners();
//   }

//   bool _showFloatingColorButtion = false;
//   get showFloatingButtion => _showFloatingColorButtion;

//   void setBackgroundImage() {
//     _showFloatingColorButtion = true;

//     adsManger(imagechangeCounterAds, 'image');
//     _isAssetImageActive = true;
//     croppedFile = null;
//     gradientMode = false;
//     int assetIndex = assetImages.indexOf(initialAssetImage);
//     if (assetIndex >= (assetImages.length) - 1) {
//       assetIndex = -1;
//     }

//     String nextAssetImage = assetImages[assetIndex + 1];
//     initialAssetImage = nextAssetImage;
//     debugPrint(initialAssetImage);
//     notifyListeners();
//   }

//   void clearbackground() {
//     _isAssetImageActive = false;
//     croppedFile = null;
//     changeAssetcolor = false;
//     initialContainerColor = Colors.white;
//     initialFilterColor = Colors.white;
//     _showFloatingColorButtion = false;
//     notifyListeners();
//   }

//   void uploadImage(BuildContext context) {
//     _isAssetImageActive = false;
//     changeAssetcolor = false;
//     gradientMode = false;
//     notifyListeners();
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => ImageCropperWidget(
//                   title: "Dashain and Tihar",
//                 )));
//   }
// //Image Container decide

//   var _containerImage = AssetImage('assets/images/upload.jpg');
//   get containerImage => _containerImage;

//   setContainerImage(value) {
//     _containerImage = FileImage(File(value.path)) as AssetImage;
//   }

//   imageReturn() {
//     if (croppedFile == null && isAssetImageActive) {
//       return AssetImage('assets/images/$initialAssetImage');
//     }
//     if (croppedFile != null && !isAssetImageActive) {
//       return FileImage(File(croppedFile!.path));
//     }

//     return _isAssetImageActive
//         ? AssetImage('assets/images/upload.jpg')
//         : croppedFile == null
//             ? AssetImage('assets/images/$initialAssetImage')
//             : (File(croppedFile!.path));
//   }

//   setCroppedImage(var s) {
//     _isAssetImageActive = false;
//     changeAssetcolor = false;
//     gradientMode = false;
//     croppedFile = s;
//     notifyListeners();
//   }

//   notifyCrop() {
//     _isAssetImageActive = false;
//     notifyListeners();
//   }

// // filter Colors
//   Color initialFilterColor = Colors.white;

//   int _colorIndex = 0;
//   setFilterColor() {
//     _colorIndex++;
//     if (_colorIndex >= (paletteColors.length) - 1) {
//       _colorIndex = 0;
//     }

//     initialFilterColor = paletteColors[_colorIndex];
//     notifyListeners();
//   }

//   setDefaultContainerColor() {
//     initialContainerColor = Colors.transparent;
//     notifyListeners();
//   }

//   setDefaultAssetColor() {
//     initialFilterColor = Colors.transparent;
//     notifyListeners();
//   }

// // Gradient Colors
//   bool _showGradientPallette = false;

//   get showGradientPallette => _showGradientPallette;
//   int _randomGradient = 82;
//   bool gradientMode = true;
//   // get gradientMode => gradientMode;
//   bool changeAssetcolor = false;
//   int get randomGradient => _randomGradient;
//   CroppedFile? croppedFile;

//   void setGradientColor(int value) {
//     gradientChnageCountAds++;
//     adsManger(gradientChnageCountAds, 'gradient');
//     if (croppedFile != null) {
//       return;
//     }
//     gradientMode = true;
//     changeAssetcolor = false;
//     _showTextSizer = false;
//     _randomGradient = value;
//     notifyListeners();
//   }

//   //Container Colour
//   Color initialContainerColor = Colors.white;
//   int _bgcColorIndex = 0;

//   void setContainerColor() {
//     if (croppedFile != null) {
//       return;
//     }

//     gradientMode = false;
//     changeAssetcolor = true;
//     _showTextSizer = false;
//     _bgcColorIndex++;
//     if (_bgcColorIndex >= (paletteColors.length) - 1) {
//       _bgcColorIndex = 0;
//     }
//     backgroundColorCountads++;
//     adsManger(backgroundColorCountads, 'backColor');

//     initialContainerColor = paletteColors[_bgcColorIndex];
//     initialFilterColor = paletteColors[_bgcColorIndex < 0 ? 0 : _bgcColorIndex];
//     if (!_isAssetImageActive) {
//       initialFilterColor =
//           paletteColors[_bgcColorIndex < 0 ? 0 : _bgcColorIndex];
//     }

//     print("color:${paletteColors[_bgcColorIndex].toString()}");
//     _showFloatingColorButtion = false; //hide two buttons
//     notifyListeners();
//   }

//   //from floating action button
//   int _counterfb = 0;
//   void setContainerColorfb() {
//     _counterfb += 1;
//     if (_counterfb >= (paletteColors.length) - 1) {
//       _counterfb = 0;
//     }
//     backgroundColorCountads++;
//     adsManger(backgroundColorCountads, 'backColor');

//     gradientMode = false;
//     changeAssetcolor = true;
//     _showTextSizer = false;

//     initialContainerColor = paletteColors[_counterfb];
//     if (!_isAssetImageActive) {
//       initialFilterColor = paletteColors[_counterfb];
//     }

//     notifyListeners();
//   }

//   void setContainerColorloop(int i) {
//     backgroundColorCountads++;
//     adsManger(backgroundColorCountads, 'backColor');

//     gradientMode = false;
//     changeAssetcolor = true;
//     _showTextSizer = false;

//     initialContainerColor = paletteColors[i];
//     if (!_isAssetImageActive) {
//       initialFilterColor = paletteColors[i];
//     }

//     notifyListeners();
//   }

// // Quotes Handling
//   List<String> _quotesList = ["empty"];
//   String _tempQuote = "Empty";
//   get quotesList => _quotesList;
//   get tempQuote => _tempQuote;

//   void changeQuote(String value) {
//     _tempQuote = value;
//     notifyListeners();
//   }

//   setQuotes(List<String> quotes, String quote) {
//     _quotesList = quotes;
//     _tempQuote = quote;
//     notifyListeners();
//   }

//   void sequentialQuote() {
//     int? currentIndex = _quotesList.indexOf(tempQuote);
//     if (currentIndex >= (_quotesList.length) - 1) {
//       currentIndex = 0;
//     }

//     String nextFlashcard = _quotesList[currentIndex + 1];
//     _tempQuote = nextFlashcard;

//     notifyListeners();
//   }

//   void nextQuote(int index) {
//     int? currentIndex = index;
//     if (currentIndex >= (_quotesList.length) - 1) {
//       currentIndex = 0;
//     }
//     String nextFlashcard = _quotesList[currentIndex + 1];
//     _tempQuote = nextFlashcard;
//   }
//   // todo

// // save Images
//   bool _isTakingScreenshot = false;
//   get isTakingScreenshot => _isTakingScreenshot;
//   readyforScreenshot(bool value) {
//     _isTakingScreenshot = value;
//     notifyListeners();
//   }

//   saveTextImageToGallery(context) async {
//     readyforScreenshot(true);

//     _screenshotController
//         .capture(delay: Duration(seconds: 1))
//         .then((Uint8List? image) {
//       if (image != null) {
//         saveTextImage(image);
//       }
//       Fluttertoast.showToast(msg: "Couldnot Capture");

//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(
//       //     content: Text('Image saved to gallery.'),
//       //   ),
//       // );
//     }).catchError((err) => debugPrint(err));
//   }

//   saveTextImage(Uint8List bytes) async {
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
//     readyforScreenshot(false);
//     debugPrint(name.toString());
//   }

//   // Internet Checker
//   checkNetwork() async {
//     return await InternetConnectionChecker().hasConnection;
//   }

//   showTextSizerDialog(context) {
//     debugPrint("aayo");
//     showDialog(
//         context: context,
//         barrierColor: Colors.white30,
//         builder: (BuildContext context) => FontSizeSlider());
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

//   // not from Editor
//   bool _showFloatingButton = true;
//   get showFloatingButton => _showFloatingButton;

//   setFloatingStatus(bool value) {
//     _showFloatingButton = value;
//     notifyListeners();
//   }
// }
