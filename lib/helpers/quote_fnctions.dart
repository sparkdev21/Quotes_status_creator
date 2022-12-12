import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import '../helpers/quote_image_generator.dart' as generator;
import '../views/Editor/FlutterUtils.dart';

GlobalKey _repaintBoundaryKey = new GlobalKey();

late Uint8List _memoryImage;

var loading = false;
var _debugMode = false;
var _screenPadding = 0.0;
Future<image.Image?>takeScreenShot( previewContainer) async {
  RenderRepaintBoundary boundary = previewContainer.currentContext!
      .findRenderObject() as RenderRepaintBoundary;
  ui.Image images = await boundary.toImage();
    final bytes = await images.toByteData(format: ui.ImageByteFormat.png);

    return image.decodePng(bytes!.buffer.asUint8List());
}
// takeScreenShot(GlobalKey previewContainer) async {
//   RenderRepaintBoundary boundary = previewContainer.currentContext!
//       .findRenderObject() as RenderRepaintBoundary;
//   ui.Image image = await boundary.toImage();
//   final directory = (await getApplicationDocumentsDirectory()).path;
//   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   Uint8List pngBytes = byteData!.buffer.asUint8List();
//   print(pngBytes);
//   File imgFile = new File('$directory/screenshot.png');
//   imgFile.writeAsBytes(pngBytes);
// }


Future<image.Image?> captureQuoteImage({pixelRatio: 1.0}) async {
  RenderRepaintBoundary? boundary = _repaintBoundaryKey.currentContext!
      .findRenderObject()! as RenderRepaintBoundary;
  ui.Image quoteShot = await boundary.toImage(pixelRatio: pixelRatio);
  final bytes = await quoteShot.toByteData(format: ui.ImageByteFormat.png);

  return image.decodePng(bytes!.buffer.asUint8List());
}

void _toggleLoader(bool enabled) {
  loading = enabled;
}

void onImageSharePressed(context) {
  _toggleLoader(true);

  captureQuoteImage(pixelRatio: 3.0).then((quoteImage) {
    rootBundle.load('assets/icon.png').then((footerImage) {
      return compute(generator.generateQuoteImage, {
        'quoteImage': quoteImage,
        'backgroundColor': Theme.of(context).backgroundColor,
        'footerLogo': image.decodePng(footerImage.buffer.asUint8List())
      });
    }).then((generatedImage) {
      _toggleLoader(false);
      saveTextImage(generatedImage as Uint8List);
      // Share.file("A Quote from Quotesbook", 'quote.jpg', generatedImage, 'image/jpg');

      if (_debugMode) {
        _memoryImage = generatedImage;
      }
    }).catchError(() => _toggleLoader(false));
  });
}

// captureScreen(BuildContext context, ScreenshotController screenshotController) {
//   // readyforScreenshot(true);
//   screenshotController.capture().then((Uint8List? image) {
//     rootBundle.load('assets/icon.png').then((footerImage) {
//       return compute(generator.generateQuoteImage, {
//         'quoteImage': image,
//         'backgroundColor': Theme.of(context).backgroundColor,
//         'footerLogo': image!.decodePng(footerImage.buffer.asUint8List())
//       });
//     }).then((generatedImage) {

//     });
//   }).catchError((err) => debugPrint(err));
// }

// void _onTextSharePressed() {
//   Share.text('A quote from Quotesbook', _quote.toText(), 'text/plain');
// }

saveTextImageToGallery(
    BuildContext context, ScreenshotController screenshotController) {
  // readyforScreenshot(true);
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
  // readyforScreenshot(false);
  debugPrint(name.toString());
}
