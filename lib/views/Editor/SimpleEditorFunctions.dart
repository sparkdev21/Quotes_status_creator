import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gradient_colors/gradient_colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../Monetization/AdHelpers.dart';
import 'FlutterUtils.dart';
import 'SingleEditor.dart';

class ColorChanger extends ChangeNotifier {
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
  int textColorLooperIndex = 0;
  double _textSize = 24.0;

  List<Color> get paletteColors => paletteColors;

  double get textSize => _textSize;
  setTextSize(double value) {
    _textSize = value;
    notifyListeners();
  }

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
}

final colorChanger = ChangeNotifierProvider<ColorChanger>((ref) {
  return ColorChanger();
});

class TextColourChanger extends ConsumerWidget {
  const TextColourChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ref.read(colorChanger.notifier).paletteColors.length,
          itemBuilder: (BuildContext context, i) => GestureDetector(
              onTap: () {
                final pc = ref.read(colorChanger.notifier).paletteColors;
                ref.read(colorChanger.notifier).setTextColor(pc[i]);
              },
              child: Container(
                  height: 50,
                  width: 50,
                  color: ref.watch(colorChanger.notifier).paletteColors[i]))),
    );
  }
}

abstract class SimpleEditorModel extends ConsumerState<SimpleEditorPage> {
  @override
  void didChangeDependencies() {
    createInterstitialAd();
    super.didChangeDependencies();
  }

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
  final List<Color> paletteColors = [
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
  Random random = Random();
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
  ];
  bool longPressColorPallete = false;

  String activeWidget = 'none';
  Widget deciderWidget() {
    switch (activeWidget) {
      case "none":
        return Container(
          color: Colors.red,
        );

      case "BgColor":
        return colorPallette();

      case "Gradient":
        return gradientPallette();

      case "Font":
        return fontsPallette();

      case "textColor":
        return textColorPallette();

      default:
        return Container();
    }
  }

  Widget colorPallette() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: paletteColors.length,
          itemBuilder: (BuildContext context, i) => GestureDetector(
              onTap: () {
                setContainerColor(paletteColors[i]);
              },
              child:
                  Container(height: 50, width: 50, color: paletteColors[i]))),
    );
  }

  Widget textColorPallette() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: textColors.length,
          itemBuilder: (BuildContext context, i) => GestureDetector(
              onTap: () {
                setTextColor(textColors[i]);
              },
              child: Container(height: 50, width: 50, color: textColors[i]))),
    );
  }

  Widget fontsPallette() {
    return Container(
      height: 40,
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: fonts.length,
          itemBuilder: (BuildContext context, i) => GestureDetector(
              onTap: () {
                setFontFamily(fonts[i]);
                debugPrint("font:${fonts[i]}");
                fontChangeCountAds++;
                adsManger(fontChangeCountAds, 'font');
              },
              child: Card(
                color: Colors.white60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Abc",
                    style: TextStyle(fontFamily: fonts[i]),
                  ),
                ),
              ))),
    );
  }

  Widget gradientPallette() {
    debugPrint("Gradient Widget is BUilding");
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 100,
        itemBuilder: (BuildContext context, i) => GestureDetector(
          onTap: () {
            setGradientColor(i);
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: GradientColors.values[i]))),
              Text(GradientColors.colorsname[i].toString().split(".")[1])
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return GestureDetector(
      onTap: () {
        if (longPressColorPallete) {
          longPressColorPallete = false;
          setState(() {});
          return;
        }
        setContainerColor(paletteColors[13]);
      },
      onLongPress: () => setState(() {
        longPressColorPallete = !longPressColorPallete;
      }),
      child: const Icon(
        Icons.color_lens,
        size: 30,
      ),
    );
  }

  void showTextSizerDialog(context) {
    debugPrint("aayo");
    showDialog(
        context: context,
        barrierColor: Colors.white30,
        builder: (BuildContext context) => Consumer(builder: (context, ref, _) {
              return Container();
              //   FontSizeSlider(
              //       //   initialFontSize: ref.watch(colorChanger.notifier).textSize,
              //       //   valueChanged: (value) {
              //       //     ref.read(colorChanger.notifier).setTextSize(value);
              //       //   },
              //       // );
            }));
  }

  int textColorLooperIndex = 0;
  String initialAssetImage = 'bg.png';

  bool gradientMode = true;

  int randomGradient = 82;
  Color containerColor = Colors.white;

  ValueNotifier textSize = ValueNotifier(24.0);
  String fontfamily = 'Oswald';

  Color initialContainerColor = Colors.white;
  Color initialTextColor = Colors.black;
  bool showTextSizer = false;
  bool nextquoteButton = false;

  String? singlequote;
  String? tempQuote;
  List<String>? quotesList;
  int initialPage = 0;

  bool isOnline = true;
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? imagebytes;
  CroppedFile? croppedFile;
  //for image section
  bool changeAssetcolor = false;
  Color initialFilterColor = Colors.white;

  bool isAssetImageActive = true;
  bool isCroppedImageActive = false;
  //Ads Showing
  final int _counter = 0;
  // InterstitialAd? interstitialAd;
  static const int maxFailedLoadAttempts = 3;
  int _numInterstitialLoadAttempts = 0;
  bool isInterstitialAdReady = false;

//Ads Counters
  InterstitialAd? interstitialAd;
  int fontChangeCountAds = 0;
  int gradientChnageCountAds = 0;
  int imagechangeCounterAds = 0;
  int textColorCountAds = 0;
  int backgroundColorCountads = 0;
  int nextButtonCounterAds = 0;

  TextEditingController textEditingController = TextEditingController();
  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialGoogleTestAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded');
            interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            // _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  void showExitInterstitialAd() {
    if (interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      Navigator.pop(context);
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        Navigator.pop(context);
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  //Ads Counter for displaying ads
  int adscounter = 0;
  _adsCounter() {
    adscounter++;
  }

  setFilterColor(Color value) {
    setState(() {
      initialFilterColor = value;
    });
  }

  bool isTakingScreenshot = false;
  readyforScreenshot(bool value) {
    setState(() {
      isTakingScreenshot = value;
    });
  }

  setTextColor(Color value) {
    textColorCountAds++;
    adsManger(textColorCountAds, 'textColor');
    initialTextColor = value;
    setState(() {});
  }

  setContainerColor(Color value) {
    backgroundColorCountads++;
    adsManger(backgroundColorCountads, 'backColor');

    if (croppedFile != null) {
      return;
    }
    gradientMode = false;
    changeAssetcolor = true;
    showTextSizer = false;
    setState(() {
      initialContainerColor = value;
    });
  }

  setGradientColor(int value) {
    gradientChnageCountAds++;
    adsManger(gradientChnageCountAds, 'gradient');
    if (croppedFile != null) {
      return;
    }
    gradientMode = true;
    changeAssetcolor = false;
    showTextSizer = false;
    setState(() {
      randomGradient = value;
    });
  }

  setFontFamily(String value) {
    showTextSizer = false;
    fontfamily = value;
    setState(() {});
  }

  imageReturn() {
    if (croppedFile == null && isAssetImageActive) {
      return AssetImage('assets/images/$initialAssetImage');
    }
    if (croppedFile != null && !isAssetImageActive) {
      return FileImage(File(croppedFile!.path));
    }
  }

  void randomFont() {
    fontChangeCountAds++;
    adsManger(fontChangeCountAds, 'font');
    int currentIndex = fonts.indexOf(fontfamily);
    if (currentIndex >= fonts.length - 1) {
      currentIndex = fonts.indexOf('Billabong');
    }

    setState(() {
      String nextFlashcard = fonts[currentIndex + 1];
      fontfamily = nextFlashcard;
    });
  }

  void setBackgroundImage() {
    imagechangeCounterAds++;
    adsManger(imagechangeCounterAds, 'image');
    isAssetImageActive = true;
    croppedFile = null;
    gradientMode = false;
    int assetIndex = assetImages.indexOf(initialAssetImage);
    if (assetIndex >= (assetImages.length) - 1) {
      assetIndex = -1;
    }

    setState(() {
      String nextAssetImage = assetImages[assetIndex + 1];
      initialAssetImage = nextAssetImage;
      debugPrint(initialAssetImage);
    });
  }

  void sequentialQuote() {
    nextButtonCounterAds++;

    adsManger(nextButtonCounterAds, 'next');
    int? currentIndex = quotesList?.indexOf(tempQuote!);
    if (currentIndex! >= (quotesList?.length)! - 1) {
      currentIndex = 0;
    }

    setState(() {
      String nextFlashcard = quotesList![currentIndex! + 1];
      tempQuote = nextFlashcard;
    });
  }

  void nextQuote(int index) {
    int? currentIndex = index;
    if (currentIndex >= (quotesList?.length)! - 1) {
      currentIndex = 0;
    }

    setState(() {
      String nextFlashcard = quotesList![currentIndex! + 1];
      tempQuote = nextFlashcard;
    });
  }

  callback(var s) async {
    imagebytes = await s.readAsBytes();
    setState(() {
      croppedFile = s;
    });
  }

  void uploadImage() {
    isAssetImageActive = false;
    changeAssetcolor = false;
    gradientMode = false;
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => ImageCropperWidget(
    //           title: "Dashain and Tihar",
    //           callBackFunction: callback,
    //         )));
  }

  void shareManager() async {
    isOnline = await InternetConnectionChecker().hasConnection;
    if (!isOnline) {
      showInternetDialog(
          context, "Internet Connetion is required to Share Images");
      return;
    }

    screenshotController.capture().then((Uint8List? image) {
      showInterstitialAd();
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => SharePageFinal(
      //           imageBytes: image as Uint8List,
      //           quote: tempQuote!,
      //         )));

      readyforScreenshot(false);
    }).catchError((err) => debugPrint(err));
  }

  saveTextImageToGallery(BuildContext context) {
    readyforScreenshot(true);
    screenshotController.capture().then((Uint8List? image) {
      saveTextImage(image!);
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

  genTextlooper() {
    if (textColorLooperIndex == textColors.length - 1) {
      textColorLooperIndex = 0;
    } else {
      textColorLooperIndex++;
      // dooper = looper.clamp(0, 4);

    }
    setState(() {});
    return textColorLooperIndex;
  }

  _exit(context) async {
    Future.delayed(const Duration(seconds: 8), () {
      // 5s over, navigate to a new page
      Navigator.pop(context);
    });
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

  showDownloadedDialog(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          _exit(context);
          return AlertDialog(
            backgroundColor: Colors.green.shade100,
            content: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Successfully Downloaded and Saved in Gallery",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.done))
            ],
          );
        });
  }

  adsManger(int value, String button) {
    if (button == 'font' && value >= 4) {
      fontChangeCountAds = 0;

      showInterstitialAd();
      clearadsCount();
    }
    if (button == 'textColor' && value >= 6) {
      textColorCountAds = 0;
      showInterstitialAd();
      clearadsCount();
    }
    if (button == 'gradient' && value >= 6) {
      showInterstitialAd();
      clearadsCount();
    }
    if (button == 'next' && value >= 6) {
      showInterstitialAd();
      clearadsCount();
    }
    if (button == 'image' && value >= 4) {
      showInterstitialAd();
      clearadsCount();
    }
    if (button == 'backColor' && value >= 8) {
      showInterstitialAd();
      clearadsCount();
    }
    if (button == 'favorite' && value >= 4) {
      showInterstitialAd();
      clearadsCount();
    }
    // if (button == 'blend' && value == 2) {
    //   showInterstitialAd();
    //   clearadsCount();
    // }
  }

  clearadsCount() {
    fontChangeCountAds = 0;
    textColorCountAds = 0;
    backgroundColorCountads = 0;
    nextButtonCounterAds = 0;
    gradientChnageCountAds = 0;
    backgroundColorCountads = 0;
    imagechangeCounterAds = 0;
  }
}
