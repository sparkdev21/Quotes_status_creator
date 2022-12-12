import 'dart:io';

import '/views/Editor/EditorNotifier.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCropperWidget extends StatefulWidget {
  final String title;
  // final CroppedFile mycroppedFile;

  const ImageCropperWidget({
    Key? key,
    required this.title,
    // required this.mycroppedFile,
  }) : super(key: key);

  @override
  _ImageCropperWidgetState createState() => _ImageCropperWidgetState();
}

class _ImageCropperWidgetState extends State<ImageCropperWidget> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;
  bool isInterstitialAdReady = false;
  // InterstitialAd? interstitialAd;
  static const int maxFailedLoadAttempts = 3;
  int _numInterstitialLoadAttempts = 0;

  int readyForAdsCounter = 0;
  @override
  void initState() {
    // createInterstitialAd();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: !kIsWeb ? AppBar(title: Text(widget.title)) : null,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (kIsWeb)
              Padding(
                padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                child: Text(
                  widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Theme.of(context).highlightColor),
                ),
              ),
            Expanded(child: _body()),
            const SizedBox(
              height: 6,
            )
          ],
        ),
        bottomNavigationBar:
            Container(color: Colors.transparent, child: Text("ads")));
  }

  Widget _body() {
    if (_croppedFile != null || _pickedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.9 * screenWidth,
          maxHeight: 0.44 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.9 * screenWidth,
          maxHeight: 0.44 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            _clear();
          },
          backgroundColor: Colors.redAccent,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        if (_croppedFile != null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                debugPrint(_croppedFile?.path);
                Navigator.pop(context);
              },
              backgroundColor: Colors.green,
              tooltip: 'Done',
              child: const Icon(
                Icons.done,
                color: Colors.white,
              ),
            ),
          ),
        if (_croppedFile == null)
          Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Consumer(builder: (context, ref, _) {
                return FloatingActionButton(
                  onPressed: () async {
                    // _cropImage();
                    // showInterstitialAd();
                    if (_pickedFile != null) {
                      final croppedFile = await ImageCropper().cropImage(
                        sourcePath: _pickedFile!.path,
                        compressFormat: ImageCompressFormat.jpg,
                        compressQuality: 100,
                        uiSettings: buildUiSettings(context),
                      );
                      if (croppedFile != null) {
                        setState(() {
                          _croppedFile = croppedFile;
                        });
                        ref
                            .read(editorNotifier.notifier)
                            .setCroppedImage(_croppedFile);
                      }
                    }
                  },
                  backgroundColor: const Color(0xFFBC764A),
                  tooltip: 'Crop',
                  child: const Icon(Icons.crop),
                );
              }))
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: kIsWeb ? 380.0 : 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.4),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context).highlightColor,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Upload an image to start',
                            style: kIsWeb
                                ? Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Theme.of(context).highlightColor)
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color:
                                            Theme.of(context).highlightColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                  },
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    // showInterstitialAd();
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: buildUiSettings(context),
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }

  // void createInterstitialAd() {
  //   InterstitialAd.load(
  //       adUnitId: AdHelper.interstitialImageOnlyAdId,
  //       request: const AdRequest(),
  //       adLoadCallback: InterstitialAdLoadCallback(
  //         onAdLoaded: (InterstitialAd ad) {
  //           debugPrint('$ad loaded');
  //           interstitialAd = ad;
  //           _numInterstitialLoadAttempts = 0;
  //           interstitialAd!.setImmersiveMode(true);
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           debugPrint('InterstitialAd failed to load: $error.');
  //           _numInterstitialLoadAttempts += 1;
  //           interstitialAd = null;
  //           if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
  //             createInterstitialAd();
  //           }
  //         },
  //       ));
  // }

  // void showInterstitialAd() {
  //   if (interstitialAd == null) {
  //     debugPrint('Warning: attempt to show interstitial before loaded.');
  //     return;
  //   }
  //   interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (InterstitialAd ad) => {},
  //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //       debugPrint('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       createInterstitialAd();
  //     },
  //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //       debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       createInterstitialAd();
  //     },
  //   );
  //   interstitialAd!.show();
  //   interstitialAd = null;
  // }
}

List<PlatformUiSettings>? buildUiSettings(BuildContext context) {
  return [
    AndroidUiSettings(
        toolbarTitle: 'Edit Image',
        toolbarColor: Colors.black,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false),
    IOSUiSettings(
      title: 'Edit Image',
    ),
  ];
}
