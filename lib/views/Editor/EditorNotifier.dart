import 'dart:io';

import '/views/Editor/AlertStatefulDialog.dart';
import '/views/Editor/FlutterUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import 'ImageCropper.dart';

final editorNotifier =
    ChangeNotifierProvider.autoDispose<EditorNotifier>((ref) {
  return EditorNotifier();
});

enum Widgets {
  BGColor,
  TextColor,
  Frames,
  Font,
  Gradient,
  AssetImage,
  Size,
  ColorFilters,
  None,
  Pop
}

class EditorNotifier extends ChangeNotifier {
  EditorNotifier();
  final _screenshotController = ScreenshotController();

  final List<Color> textColors = [
    Colors.black,
    Colors.white,
    Colors.brown,
    Colors.green,
    Colors.deepPurple,
    Colors.pink,
    Colors.teal,
    Colors.yellow,
    Colors.black54,
    Colors.white54
  ];
  final List<Color> _paletteColors = [
    Colors.white,
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.blue,
    Colors.red,
    Colors.brown,
    Colors.green,
    Colors.indigoAccent,
    Colors.lime,
    Colors.cyan,
    Colors.deepPurple,
    Colors.lightGreen,
    Colors.pink,
    Colors.teal,
    Colors.yellow
  ];
  final List<String> fonts = [
    'Billabong',
    'ChunkFive',
    'Arizonia',
    'Quicksand',
    'Roboto',
    'Oswald',
    'SEASRN',
    'Lobster',
    'OpenSans',
    'OstrichSans',
  ];
  final List<String> assetImages = [
    "bg.png",
    "card5.png",
    "1.png",
    "2.png",
    "3.png",
    "4.png",
    "5.png",
    "7.png",
    "8.png",
    "9.png",
    "10.png",
    "11.png",
    "12.png",
    "13.png",
    "14.png",
    "15.png",
    "16.png",
    "18.png",
    "19.png",
    "20.png",
    "21.png",
    "22.png",
    "23.png",
    "24.png",
    "25.png",
    "26.png",
    "27.png",
    "28.png",
    "29.png",
    "30.png",
    "31.png",
    "32.png",
    "33.png",
    "34.png",
    "35.png",
    "36.png",
    "37.png"
  ];

// protrait Mode
  void protraitMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    notifyListeners();
  }

// Active Widget Setter
  Enum _activeWidget = Widgets.None;
  get activeWidget => _activeWidget;
  widgetSetter(Enum value) {
    if (_activeWidget == value) {
      _activeWidget = Widgets.None;
      notifyListeners();
      return;
    }
    _activeWidget = value;

    notifyListeners();
  }

// Text Colour Widgets
  int textColorLooperIndex = 0;

  List<Color> get paletteColors => _paletteColors;
  Color initialTextColor = Colors.black;
  genTextlooper() {
    if (textColorLooperIndex == textColors.length - 1) {
      textColorLooperIndex = 0;
    } else {
      textColorLooperIndex++;
    }
    notifyListeners();
    return textColorLooperIndex;
  }

  setTextColor(Color value) {
    initialTextColor = value;
    notifyListeners();
  }

// Text Size
  double _textSize = 24.0;
  double get textSize => _textSize;
  setTextSize(double value) {
    _textSize = value;
    notifyListeners();
  }

  // Text Style
  TextStyle _maintextStyle = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black12);

  get mainTextStyle => _maintextStyle;

  // font Changer
  String _fontfamily = 'Billabong';
  get fontfamily => _fontfamily;
  bool _showTextSizer = false;
  get showTextSizer => _showTextSizer;
  setShowTextSizer(bool value) {
    _showTextSizer = false;
    notifyListeners();
  }

  setFontFamily(String value) {
    _showTextSizer = false;
    _fontfamily = value;
    notifyListeners();
  }

  void randomFont() {
    int currentIndex = fonts.indexOf(_fontfamily);
    if (currentIndex >= fonts.length - 1) {
      currentIndex = fonts.indexOf('Billabong');
    }
    String nextFlashcard = fonts[currentIndex + 1];
    _fontfamily = nextFlashcard;
    notifyListeners();
  }

// Background Image
  String initialAssetImage = 'upload.jpg';
  Uint8List? imagebytes;

  bool _isAssetImageActive = true;
  get isAssetImageActive => _isAssetImageActive;

  // String getAssetImage(int value) {
  //   Future.delayed(Duration(milliseconds: 2,))
  //   return assetImages[value];
  // }

  setAssetImage(int value) {
    _isAssetImageActive = true;
    croppedFile = null;
    gradientMode = false;
    initialAssetImage = assetImages[value];

    notifyListeners();
  }

  void setBackgroundImage() {
    _isAssetImageActive = true;
    croppedFile = null;
    gradientMode = false;
    int assetIndex = assetImages.indexOf(initialAssetImage);
    if (assetIndex >= (assetImages.length) - 1) {
      assetIndex = -1;
    }

    String nextAssetImage = assetImages[assetIndex + 1];
    initialAssetImage = nextAssetImage;
    debugPrint(initialAssetImage);
    notifyListeners();
  }

  void uploadImage(BuildContext context) {
    _isAssetImageActive = false;
    changeAssetcolor = false;
    gradientMode = false;
    notifyListeners();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImageCropperWidget(
                  title: "Dashain and Tihar",
                )));
  }
//Image Container decide

  var _containerImage = AssetImage('assets/images/upload.jpg');
  get containerImage => _containerImage;

  setContainerImage(value) {
    _containerImage = FileImage(File(value.path)) as AssetImage;
  }

  imageReturn() {
    if (croppedFile == null && isAssetImageActive) {
      return AssetImage('assets/images/$initialAssetImage');
    }
    if (croppedFile != null && !isAssetImageActive) {
      return FileImage(File(croppedFile!.path));
    }

    return _isAssetImageActive
        ? AssetImage('assets/images/upload.jpg')
        : FileImage(File(croppedFile!.path));
  }

  setCroppedImage(var s) {
    _isAssetImageActive = false;
    changeAssetcolor = false;
    gradientMode = false;
    croppedFile = s;
    notifyListeners();
  }

  notifyCrop() {
    _isAssetImageActive = false;
    notifyListeners();
  }

// filter Colors
  Color initialFilterColor = Colors.white;
  setFilterColor(Color value) {
    initialFilterColor = value;
    notifyListeners();
  }

// Gradient Colors
  bool _showGradientPallette = false;

  get showGradientPallette => _showGradientPallette;
  int _randomGradient = 82;
  bool gradientMode = true;
  // get gradientMode => gradientMode;
  bool changeAssetcolor = false;
  int get randomGradient => _randomGradient;
  CroppedFile? croppedFile;

  void setGradientColor(int value) {
    if (croppedFile != null) {
      return;
    }
    gradientMode = true;
    changeAssetcolor = false;
    _showTextSizer = false;
    _randomGradient = value;
    notifyListeners();
  }

  //Container Colour
  Color initialContainerColor = Colors.white;

  void setContainerColor(value) {
    if (croppedFile != null) {
      return;
    }
    gradientMode = false;
    changeAssetcolor = true;
    _showTextSizer = false;
    initialContainerColor = paletteColors[value];
    notifyListeners();
  }

// Quotes Handling
  List<String> _quotesList = ["empty"];
  String _tempQuote = "Empty";
  get quotesList => _quotesList;
  get tempQuote => _tempQuote;

  void changeQuote(String value) {
    _tempQuote = value;
    notifyListeners();
  }

  setQuotes(List<String> quotes, String quote) {
    _quotesList = quotes;
    _tempQuote = quote;
    notifyListeners();
  }

  void sequentialQuote() {
    int? currentIndex = _quotesList.indexOf(tempQuote);
    if (currentIndex >= (_quotesList.length) - 1) {
      currentIndex = 0;
    }

    String nextFlashcard = _quotesList[currentIndex + 1];
    _tempQuote = nextFlashcard;

    notifyListeners();
  }

  void nextQuote(int index) {
    int? currentIndex = index;
    if (currentIndex >= (_quotesList.length) - 1) {
      currentIndex = 0;
    }
    String nextFlashcard = _quotesList[currentIndex + 1];
    _tempQuote = nextFlashcard;
  }
  // todo

// save Images
  bool _isTakingScreenshot = false;
  get isTakingScreenshot => _isTakingScreenshot;
  readyforScreenshot(bool value) {
    _isTakingScreenshot = value;
    notifyListeners();
  }

  saveTextImageToGallery(context) async {
    if (await requestPermission(Permission.storage)) {
      Fluttertoast.showToast(msg: "Storage Available");
    }

    readyforScreenshot(true);
    _screenshotController
        .capture(delay: Duration(seconds: 1))
        .then((Uint8List? image) {
      if (image != null) {
        saveTextImage(image);
      }
      Fluttertoast.showToast(msg: "Couldnot Capture");

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Image saved to gallery.'),
      //   ),
      // );
    }).catchError((err) => debugPrint(err));
  }

  saveTextImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => WidgetEditableImage(
    //           imagem: bytes,
    //           callBackFunc: callback2,
    //           key: UniqueKey(),
    //         )));

    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
    readyforScreenshot(false);
    debugPrint(name.toString());
  }

//share manger
  // void shareManager(context) async {
  //   // bool isOnline = await InternetConnectionChecker().hasConnection;
  //   // if (!isOnline) {
  //   //   showInternetDialog(
  //   //       context, "Internet Connetion is required to Share Images");
  //   //   return;
  //   // }

  //   _screenshotController
  //       .capture(delay: Duration(milliseconds: 1))
  //       .then((Uint8List? image) async {
  //     saveTextImage(image!);

  //     // showInterstitialAd();
  //     // Navigator.of(context).push(MaterialPageRoute(
  //     //     builder: (context) => SharePageFinal(
  //     //           imageBytes: image as Uint8List,
  //     //           quote: tempQuote!,
  //     //         )));

  //     readyforScreenshot(false);
  //   });
  // }

  // Internet Checker
  checkNetwork() async {
    return await InternetConnectionChecker().hasConnection;
  }

  showTextSizerDialog(context) {
    debugPrint("aayo");
    showDialog(
        context: context,
        barrierColor: Colors.white30,
        builder: (BuildContext context) => FontSizeSlider());
  }

  showInternetDialog(context, String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.red.shade100,
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close))
              ],
            ));
  }

  // not from Editor
  bool _showFloatingButton = true;
  get showFloatingButton => _showFloatingButton;

  setFloatingStatus(bool value) {
    _showFloatingButton = value;
    notifyListeners();
  }
}
