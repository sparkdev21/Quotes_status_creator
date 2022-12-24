import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../Controllers/QuotesController.dart';
import '../../Monetization/Banners/small_banner.dart';
import '../../models/HiveModel/hive_quote_data_model.dart';
import '/views/Editor/EditorNotifier.dart';
import '/views/Editor/Messenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_colors/gradient_colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';
import 'package:share_plus/share_plus.dart';
import 'EditButtons.dart';
import 'FlutterUtils.dart';
import 'ImageCropper.dart';

class SimpleEditorPage extends ConsumerStatefulWidget {
  final String title;
  final String quote;

  const SimpleEditorPage({super.key, required this.title, required this.quote});

  @override
  ConsumerState<SimpleEditorPage> createState() => _SimpleEditorPageState();
}

class _SimpleEditorPageState extends ConsumerState<SimpleEditorPage> {
  final Random _random = Random();

  final ScreenshotController screenshotController = ScreenshotController();

  final TextEditingController _nameController = TextEditingController();
  late String mainQuote;
  late String title;
  @override
  void initState() {
    mainQuote = widget.quote;
    title = widget.title;
    ref.read(editorNotifier.notifier).createInterstitialAd();
    super.initState();
  }

  bool isFavadded = false;
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

  _exit(context) async {
    Future.delayed(const Duration(seconds: 8), () {
      // 5s over, navigate to a new page
      Navigator.pop(context);
    });
  }

  showDownloadedDialog(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // _exit(context);
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

  saveTextsImage(Uint8List bytes) async {
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

    debugPrint(name.toString());
  }

  void download(context) async {
    await requestPermission(Permission.storage)
        .then((value) => print("status:$value"));
    bool isOnline = await InternetConnectionChecker().hasConnection;
    if (!isOnline) {
      showInternetDialog(
          context, "Internet Connetion is required to Download Images");
      return;
    }
    // _screenshotController
    //     .captureFromWidget(Container(
    //         padding: const EdgeInsets.all(30.0),
    //         decoration: BoxDecoration(
    //           border: Border.all(color: Colors.blueAccent, width: 5.0),
    //           color: Colors.redAccent,
    //         ),
    //         child: Text("This is an invisible widget")))
    //     .then((capturedImage) {
    //   Fluttertoast.showToast(msg: "Image is is captured:$capturedImage");
    // });

    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
          if (image == null) {
            Fluttertoast.showToast(msg: "Image Couldn't Be Saved");
          }
          final time = DateTime.now()
              .toIso8601String()
              .replaceAll('.', '')
              .replaceAll(':', '');
          final name = "Image_$time";
          if (image != null) {
            // final directory = await getApplicationDocumentsDirectory();
            // final imagePath =
            //     await File('${directory.path}/image_$name.png').create();

            // await imagePath.writeAsBytes(image);
            await ImageGallerySaver.saveImage(image, name: name);

            // Fluttertoast.showToast(msg: "statsu:");
          }

          //   final directory = await getApplicationDocumentsDirectory();
          //   final imagePath = await File('${directory.path}/image.png').create();
          //   await imagePath.writeAsBytes(image);

          //   /// Share Plugin
          // }

          // showInterstitialAd();
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => SharePageFinal(
          //           imageBytes: image as Uint8List,
          //           quote: tempQuote!,
          //         )));
        })
        .then((value) =>
            ref.read(editorNotifier.notifier).showDownInterstitialAd(context))
        .then((value) =>
            ref.read(editorNotifier.notifier).readyforScreenshot(false));
  }

  void share(context) async {
    await requestPermission(Permission.storage);
    bool isOnline = await InternetConnectionChecker().hasConnection;
    if (!isOnline) {
      showInternetDialog(
          context, "Internet Connetion is required to Download Images");
      return;
    }
    // bool isOnline = await InternetConnectionChecker().hasConnection;
    // if (!isOnline) {
    //   showInternetDialog(
    //       context, "Internet Connetion is required to Share Images");
    //   return;
    // }

    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image == null) {
        Fluttertoast.showToast(msg: "Image is null");
      }
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '-')
          .replaceAll(':', '-');
      final name = "Image_$time";

      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();

        final imagePath = await File('${directory.path}/image.png').create();

        await imagePath.writeAsBytes(image);
        await ImageGallerySaver.saveImage(image);

        // SocialShare.shareFacebookStory(
        //     imagePath.path, "#00FFFFE", "#7HBDHBS", "https;google.com");

        // Share.shareXFiles([file], text: 'Great picture');
        // Share.shareXFiles([XFile(imagePath.path)],
        //     subject: widget.quote, text: 'Great picture');
        _onShareImageWithResult(context, imagePath.path);
        // Fluttertoast.showToast(msg: "statsu:");
      }

      //   final directory = await getApplicationDocumentsDirectory();
      //   final imagePath = await File('${directory.path}/image.png').create();
      //   await imagePath.writeAsBytes(image);

      //   /// Share Plugin
      // }

      // showInterstitialAd();
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => SharePageFinal(
      //           imageBytes: image as Uint8List,
      //           quote: tempQuote!,
      //         )));
    }).then((value) =>
            ref.read(editorNotifier.notifier).readyforScreenshot(false));
  }

  void _onShareTextWithResult(BuildContext context, String msg) async {
    Fluttertoast.showToast(
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.CENTER,
        msg: "Share Quote Using...");

    ShareResult shareResult;

    shareResult = await Share.shareWithResult(msg);
    if (shareResult.status == ShareResultStatus.success) {
      ref.read(editorNotifier.notifier).showShareInterstitialAd(context);
    }
  }

  void _onShareImageWithResult(BuildContext context, String filePath) async {
    final box = context.findRenderObject() as RenderBox?;
    ShareResult shareResult;
    if (filePath != '') {
      final files = XFile(filePath);

      shareResult = await Share.shareXFiles([files],
          text: "Text",
          subject: "subject",
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      shareResult = await Share.shareWithResult("text",
          subject: "subject",
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
    if (shareResult.status == ShareResultStatus.success) {
      ref.read(editorNotifier.notifier).showDownInterstitialAd(context);
    }
  }

  showRemoveDialog(context, WidgetRef ref) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text("Do you want to remove Image?")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                        ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(editorNotifier.notifier)
                                  .setBackgroundImage();
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.done))
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  // showEditText(context, WidgetRef ref) {
  //   setState(() {
  //     _nameController.text = mainQuote;
  //   });
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text(
  //         'Edit Text',
  //       ),
  //       content: TextField(
  //         scrollPadding: const EdgeInsets.all(8),
  //         textAlign: TextAlign.center,
  //         controller: _nameController,
  //         maxLines: 20,
  //         minLines: 1,
  //         decoration: InputDecoration(
  //           suffixIcon: const Icon(
  //             Icons.edit,
  //           ),
  //           filled: true,
  //           hintText: "YouR tExt Here",
  //         ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 mainQuote = _nameController.text;
  //                 Navigator.pop(context);
  //               });
  //             },
  //             child: const Text("Add"))
  //       ],
  //     ),
  //   );
  // }

  showEditText(context, WidgetRef ref) {
    setState(() {
      _nameController.text = mainQuote;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.all(16),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    ref.read(editorNotifier.notifier).showInterstitialAd();
                    Navigator.pop(context);
                  },
                  child: Text("Apply"))
            ],
            contentPadding: EdgeInsets.all(8),
            content: Flexible(
              child: TextField(
                showCursor: true,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.go,
                controller: _nameController,
                maxLines: 15,
                minLines: 1,
                onChanged: ((value) {
                  mainQuote = value;

                  setState(() {});
                }),
                onSubmitted: ((value) {
                  mainQuote = value;
                  _nameController.text = value;

                  setState(() {});

                  Navigator.pop(context);
                }),
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () => _nameController.text = '',
                    child: Icon(
                      Icons.close,
                    ),
                  ),
                  hintText: 'Your Text Here..',
                ),
              ),
            ),
          );
        });
  }

  final Color _selectedColor = Colors.green.shade200;

  @override
  Widget build(BuildContext context) {
    ref.watch(editorNotifier);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top]);
    var bottomButtons = Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          EditButton(
            color: ref.watch(editorNotifier.notifier).currentWidget == 0
                ? _selectedColor
                : null,
            ontap: () {
              ref.read(editorNotifier.notifier).setBackgroundImage();
              ref.read(editorNotifier.notifier).setCurrentActiveWidget(0);
            },
            onLongPress: () => ref
                .read(editorNotifier.notifier)
                .widgetSetter(Widgets.AssetImage),
            title: "Sticker",
            icon: Icons.image,
          ),

          EditButton(
            color: ref.watch(editorNotifier.notifier).currentWidget == 1
                ? _selectedColor
                : null,
            // ontap: () => ref.read(editorNotifier.notifier).setContainerColor(ref
            //     .read(editorNotifier.notifier)
            //     .paletteColors[_random.nextInt(12)]),
            ontap: () {
              if (ref.watch(editorNotifier.notifier).croppedFile != null) {
                showRemoveDialog(context, ref);
              }
              ref.read(editorNotifier.notifier).setContainerColor();
              ref.read(editorNotifier.notifier).setCurrentActiveWidget(1);
            },

            onLongPress: () =>
                ref.read(editorNotifier.notifier).widgetSetter(Widgets.BGColor),
            title: "BgColor",
            icon: Icons.color_lens,
          ),
          EditButton(
            color: ref.watch(editorNotifier.notifier).currentWidget == 2
                ? _selectedColor
                : null,
            ontap: () {
              if (ref.watch(editorNotifier.notifier).croppedFile != null) {
                //read to watch
                showRemoveDialog(context, ref);
              }
              ref.read(editorNotifier.notifier).setCurrentActiveWidget(2);

              ref
                  .read(editorNotifier.notifier)
                  .setGradientColor(_random.nextInt(123));
            },
            onLongPress: () => ref
                .read(editorNotifier.notifier)
                .widgetSetter(Widgets.Gradient),
            title: "Gradient",
            icon: Icons.gradient,
          ),
          EditButton(
            color: ref.watch(editorNotifier.notifier).currentWidget == 3
                ? _selectedColor
                : null,
            ontap: () {
              ref.read(editorNotifier.notifier).randomFont();
              ref.read(editorNotifier.notifier).setCurrentActiveWidget(3);
            },
            onLongPress: () =>
                ref.read(editorNotifier.notifier).widgetSetter(Widgets.Font),
            title: "Font",
            icon: Icons.font_download_outlined,
          ),
          // EditButton(
          //   ontap: () => setTextColor(textColors[genTextlooper()]),
          //   onLongPress: () => _widgetSetter('textColor'),
          //   title: "Color",
          //   icon: Icons.text_format_outlined,
          // )
          EditButton(
            color: ref.watch(editorNotifier.notifier).currentWidget == 4
                ? _selectedColor
                : null,
            ontap: () {
              int genInt = ref.watch(editorNotifier.notifier).genTextlooper();
              ref.read(editorNotifier.notifier).setTextColor(
                  ref.read(editorNotifier.notifier).textColors[genInt]);
              ref.read(editorNotifier.notifier).setCurrentActiveWidget(4);
            },
            onLongPress: () => ref
                .read(editorNotifier.notifier)
                .widgetSetter(Widgets.TextColor),
            title: 'color',
            icon: Icons.text_format_outlined,
          ),

          EditButton(
            color: ref.watch(editorNotifier.notifier).currentWidget == 5
                ? _selectedColor
                : null,
            ontap: () {
              ref.read(editorNotifier.notifier).showTextSizerDialog(context);
              ref.read(editorNotifier.notifier).widgetSetter(Widgets.None);
              ref.read(editorNotifier.notifier).setCurrentActiveWidget(5);
            },
            onLongPress: () {
              ref.read(editorNotifier.notifier).showTextSizerDialog(context);
            },
            title: "Size",
            icon: Icons.text_fields_outlined,
          ),
          // EditButton(
          //   ontap: () => null,
          //   onLongPress: () => ref
          //       .read(editorNotifier.notifier)
          //       .widgetSetter(Widgets.ColorFilters),
          //   title: "Edit",
          //   icon: Icons.edit,
          // ),
          EditButton(
            color: ref.watch(editorNotifier.notifier).currentWidget == 6
                ? _selectedColor
                : null,
            ontap: () {
              ref.read(editorNotifier.notifier).setCurrentActiveWidget(6);
              showEditText(context, ref);
            },
            onLongPress: () {},
            title: "Edit",
            icon: Icons.edit,
          ),
        ],
      ),
    );
    var topButtons = Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                  tooltip: 'Upload Image',
                  onPressed: () async {
                    // ref.read(editorNotifier.notifier).uploadImage(context);
                    final _pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (_pickedFile != null)
                      await ImageCropper()
                          .cropImage(
                            sourcePath: _pickedFile.path,
                            compressFormat: ImageCompressFormat.jpg,
                            compressQuality: 100,
                            uiSettings: buildUiSettings(context),
                          )
                          .onError((error, stackTrace) {
                            print("color:Error cropiing");
                            return ref
                                .read(editorNotifier.notifier)
                                .setCroppedImage(null);
                          })
                          .then(
                            (value) => ref
                                .read(editorNotifier.notifier)
                                .setCroppedImage(value),
                          )
                          .then((value) => ref
                              .read(editorNotifier.notifier)
                              .showInterstitialAd());
                  },
                  icon: const Icon(
                    Icons.image_outlined,
                    size: 30,
                  )),
              const Text("Add Image", style: labelStyle),
            ],
          ),
          Column(
            children: [
              IconButton(
                  tooltip: 'Download Image',
                  onPressed: () {
                    // if (!await ref
                    //     .read(editorNotifier.notifier)
                    //     .checkNetwork()) {
                    //   showInternetDialog(context,
                    //       "Internet Connetion is required to Download Images");
                    //   return;
                    // }
                    // showInterstitialAd();

                    ref.read(editorNotifier.notifier).setShowTextSizer(false);
                    ref.read(editorNotifier.notifier).readyforScreenshot(true);
                    download(context);

                    // showDownloadedDialog(context);
                  },
                  icon: const Icon(
                    Icons.download,
                    size: 30,
                  )),
              const Text(
                "Download",
                style: labelStyle,
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  tooltip: 'Share ',
                  onPressed: () {
                    ref.read(editorNotifier.notifier).setShowTextSizer(false);
                    ref.read(editorNotifier.notifier).readyforScreenshot(true);
                    share(context);
                  },
                  icon: const Icon(
                    Icons.share,
                    size: 30,
                  )),
              const Text("Share", style: labelStyle),
            ],
          ),
          if (title.contains('notify'))
            Column(
              children: [
                IconButton(
                    tooltip: 'Add to Favourite ',
                    onPressed: () {
                      HiveQuoteDataModel quotes = HiveQuoteDataModel(
                          category: "notification",
                          id: 1,
                          isFavourite: true,
                          language: 'hinglish',
                          quote: mainQuote);

                      isFavadded = !isFavadded;

                      QuotesController().addNotificationQuotes(quotes);
                      ref.read(editorNotifier.notifier).showFavInterstitialAd();
                      ref.read(editorNotifier.notifier).setFav(isFavadded);
                    },
                    icon: Icon(
                      ref.read(editorNotifier.notifier).isFav
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      size: 30,
                    )),
                const Text("Favourite", style: labelStyle),
              ],
            ),
          Column(
            children: [
              IconButton(
                  tooltip: 'Close ',
                  onPressed: () {
                    ref
                        .read(editorNotifier.notifier)
                        .showExitInterstitialAd(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  )),
              const Text("Close", style: labelStyle),
            ],
          ),
        ],
      ),
    );
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Scaffold(
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: Colors.blue,
        //   backgroundColor: Colors.amberAccent,
        //   items: <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.camera),
        //       label: 'Categories',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.local_fire_department_rounded),
        //       label: 'User Quotes',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.settings),
        //       label: 'Settings',
        //     ),

        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.settings),
        //       label: 'Settings',
        //     ),
        //     // BottomNavigationBarItem(
        //     //   icon: Icon(Icons.settings),
        //     //   label: 'Settings',
        //     // ),
        //   ],
        //   currentIndex: selectedIndex,
        //   onTap: ((value) {
        //     setState(() {
        //       selectedIndex = value;
        //     });
        //   }),
        // ),
        body: SafeArea(
          child: Column(
            children: [
              const BannerSmall(),
              topButtons,
              Expanded(
                child: Screenshot(
                  key: UniqueKey(),
                  controller: screenshotController,
                  child: Stack(
                    children: [
                      Container(
                        color: ref
                            .watch(editorNotifier.notifier)
                            .initialContainerColor,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: !ref
                                  .watch(editorNotifier.notifier)
                                  .gradientMode
                              ? BoxDecoration(
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          ref
                                              .watch(editorNotifier.notifier)
                                              .initialFilterColor,
                                          !ref
                                                      .watch(editorNotifier
                                                          .notifier)
                                                      .showFloatingButtion &&
                                                  ref
                                                      .watch(editorNotifier
                                                          .notifier)
                                                      .changeAssetcolor
                                              ? BlendMode.srcATop
                                              : BlendMode.dstATop),
                                      fit: BoxFit.fill,
                                      image: ref
                                          .watch(editorNotifier.notifier)
                                          .imageReturn()),
                                )
                              : BoxDecoration(
                                  gradient: ref
                                          .watch(editorNotifier.notifier)
                                          .gradientMode
                                      ? LinearGradient(
                                          colors: GradientColors.values[ref
                                              .watch(editorNotifier.notifier)
                                              .randomGradient
                                              .toInt()],

                                          tileMode: TileMode.clamp,
                                          //begin: Alignment(-1, gradientvalues),
                                          //  end: Alignment(gradientvalues, gradientvalues2),
                                          // begin: const Alignment(-1, 1),
                                          // end: const Alignment(1, 1),

                                          // transform: const GradientRotation(-1 * 2),
                                          //stops: [1, 4],
                                        )
                                      : null,
                                  color: ref
                                      .watch(editorNotifier.notifier)
                                      .initialContainerColor,
                                ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                SocialShare.copyToClipboard(widget.quote);
                                Messenger().showAlert("Copied to Clipboard");
                              },
                              onLongPress: () {
                                _onShareTextWithResult(context, widget.quote);
                              },
                              child: Center(
                                child: AutoSizeText(mainQuote,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ref
                                          .watch(editorNotifier.notifier)
                                          .initialTextColor,
                                      fontSize: ref
                                          .watch(editorNotifier.notifier)
                                          .textSize,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: ref
                                          .watch(editorNotifier.notifier)
                                          .fontfamily,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Visibility(
                      //   visible: ref
                      //               .watch(editorNotifier.notifier)
                      //               .croppedFile ==
                      //           null &&
                      //       !ref.watch(editorNotifier.notifier).gradientMode &&
                      //       !ref
                      //           .watch(editorNotifier.notifier)
                      //           .isTakingScreenshot,
                      //   child: InkWell(
                      //     onLongPress: () => ref
                      //         .read(editorNotifier.notifier)
                      //         .setDefaultContainerColor(),
                      //     child: Visibility(
                      //       visible: !ref
                      //               .watch(editorNotifier.notifier)
                      //               .isTakingScreenshot &&
                      //           ref
                      //               .watch(editorNotifier.notifier)
                      //               .showFloatingButtion,
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(bottom: 0),
                      //         child: Align(
                      //           alignment: Alignment.bottomRight,
                      //           child: FloatingActionButton.small(
                      //             heroTag: "color",
                      //             backgroundColor: ref
                      //                 .watch(editorNotifier.notifier)
                      //                 .initialContainerColor,
                      //             onPressed: () => ref
                      //                 .read(editorNotifier.notifier)
                      //                 .setContainerColorfb(),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Visibility(
                        visible: ref
                                    .watch(editorNotifier.notifier)
                                    .croppedFile ==
                                null &&
                            !ref.watch(editorNotifier.notifier).gradientMode &&
                            !ref
                                .watch(editorNotifier.notifier)
                                .isTakingScreenshot,
                        child: InkWell(
                          onLongPress: () => ref
                              .read(editorNotifier.notifier)
                              .setDefaultAssetColor(),
                          child: Visibility(
                            visible: !ref
                                .watch(editorNotifier.notifier)
                                .isTakingScreenshot,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton.small(
                                  heroTag: "assetColor",
                                  backgroundColor: ref
                                      .watch(editorNotifier.notifier)
                                      .initialFilterColor,
                                  onPressed: () => ref
                                      .read(editorNotifier.notifier)
                                      .setFilterColor(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ref
                                    .watch(editorNotifier.notifier)
                                    .croppedFile !=
                                null &&
                            !ref.watch(editorNotifier.notifier).gradientMode &&
                            !ref
                                .read(editorNotifier.notifier)
                                .isTakingScreenshot,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: FloatingActionButton.small(
                              tooltip: "Remove Photo",
                              heroTag: "album",
                              backgroundColor: Colors.red,
                              onPressed: () => ref
                                  .read(editorNotifier.notifier)
                                  .setBackgroundImage(),
                              child: const Icon(
                                  Icons.image_not_supported_outlined),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //BottomButtons
              // if (ref.watch(editorNotifier.notifier).croppedFile != null)
              // WidgetDecider.deciderWidget(
              //     ref.watch(editorNotifier.notifier).activeWidget),
              WrapWidgets(),
              // WidgetDecider.deciderWidget(
              //     ref.watch(editorNotifier.notifier).activeWidget),

              bottomButtons
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetDecider {
  static Widget deciderWidget(Enum value) {
    switch (value) {
      case Widgets.None:
        return SizedBox.shrink();

      case Widgets.BGColor:
        return ColorPallette();

      case Widgets.AssetImage:
        return FramePallette();

      case Widgets.Gradient:
        return GradientPallette();

      case Widgets.Font:
        return FontPallette();

      case Widgets.TextColor:
        return TextColorPallette();

      case Widgets.ColorFilters:
        return Container(
          color: Colors.red,
          child: Text("not Implemented"),
        );

      default:
        return SizedBox.shrink();
    }
  }
}

class CloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const CloseButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: IconButton(
        padding: EdgeInsets.all(2),
        splashColor: Colors.red,
        color: Colors.red,
        onPressed: onTap,
        icon: Icon(
          Icons.cancel,
          color: Colors.black,
          size: 24,
        ),
      ),
    );
  }
}

class WrapWidgets extends StatelessWidget {
  const WrapWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Stack(
        alignment: AlignmentDirectional(0, -29.4),
        children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: WidgetDecider.deciderWidget(
                (ref.watch(editorNotifier.notifier).activeWidget)),
          ),
          if (ref.watch(editorNotifier.notifier).activeWidget != Widgets.None)
            CloseButton(
                onTap: (() => ref
                    .read(editorNotifier.notifier)
                    .widgetSetter(Widgets.None))),
        ],
      );
    });
  }
}

class ColorPallette extends StatelessWidget {
  const ColorPallette({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Consumer(builder: (context, ref, _) {
      return SizedBox(
        height: 50,
        child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
                  width: 1,
                ),
            scrollDirection: Axis.horizontal,
            itemCount: ref.watch(editorNotifier.notifier).paletteColors.length,
            itemBuilder: (BuildContext context, i) => GestureDetector(
                onTap: () {
                  ref.read(editorNotifier.notifier).setContainerColorloop(i);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  color: ref.watch(editorNotifier.notifier).paletteColors[i],
                  child: i == 0
                      ? Center(
                          child: Text(
                          "None",
                        ))
                      : null,
                ))),
      );
    });
  }
}

class FramePallette extends StatelessWidget {
  const FramePallette({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return SizedBox(
        height: 50,
        child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
                  width: 1,
                ),
            scrollDirection: Axis.horizontal,
            itemCount: ref.watch(editorNotifier.notifier).assetImages.length,
            itemBuilder: (BuildContext context, i) => i == 0
                ? Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                    child: IconButton(
                        onPressed: () {
                          ref.read(editorNotifier.notifier).clearbackground();
                        },
                        icon: Icon(Icons.not_interested_sharp)))
                : GestureDetector(
                    onTap: () =>
                        ref.read(editorNotifier.notifier).setAssetImage(i),
                    child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.transparent, BlendMode.srcATop),
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/${ref.watch(editorNotifier.notifier).assetImages[i]}"),
                            ))),
                  )),
      );
    });
  }
}

class TextColorPallette extends StatelessWidget {
  const TextColorPallette({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return SizedBox(
        height: 50,
        child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
                  width: 1,
                ),
            scrollDirection: Axis.horizontal,
            itemCount: ref.watch(editorNotifier.notifier).textColors.length,
            itemBuilder: (BuildContext context, i) => GestureDetector(
                onTap: () {
                  ref.read(editorNotifier.notifier).setTextColor(
                      ref.watch(editorNotifier.notifier).textColors[i]);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: 50,
                  width: 50,
                  color: i == 0
                      ? Colors.deepOrangeAccent
                      : ref.watch(editorNotifier.notifier).textColors[i],
                  child: i == 0
                      ? Center(
                          child: Text(
                          "None",
                        ))
                      : null,
                ))),
      );
    });
  }
}

const Color iconcolor = Colors.red;
const TextStyle labelStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

class GradientPallette extends StatelessWidget {
  const GradientPallette({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 100,
          itemBuilder: (BuildContext context, i) => GestureDetector(
            onTap: () => ref.read(editorNotifier.notifier).setGradientColor(i),
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
    });
  }
}

class FontPallette extends StatelessWidget {
  const FontPallette({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Container(
        height: 50,
        // color: Theme.of(context).colorScheme.tertiaryContainer,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ref.watch(editorNotifier.notifier).fonts.length,
            itemBuilder: (BuildContext context, i) => GestureDetector(
                onTap: () {
                  ref.read(editorNotifier.notifier).setFontFamily(
                      ref.read(editorNotifier.notifier).fonts[i]);
                  debugPrint(
                      "font:${ref.read(editorNotifier.notifier).fonts[i]}");
                },
                child: SizedBox(
                  width: 50,
                  child: Card(
                    color: Colors.white60,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: AutoSizeText(
                          "Abc",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily:
                                  ref.watch(editorNotifier.notifier).fonts[i]),
                        ),
                      ),
                    ),
                  ),
                ))),
      );
    });
  }
}
