import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

// URL of the video to downloadvoid
void downloader() async {
  String videoUrl =
      "https://www.tiktok.com/@charlidamelio/video/7145116147929648427";

// Create a new HTTP client and send a GET request to the URL
  var client = http.Client();
  var response = await client.get(Uri.parse(videoUrl));

// Check the status code of the response
  if (response.statusCode == 200) {
    // If the response is successful, read the response body as a binary data
    var bytes = response.bodyBytes;

    // Save the binary data to a file using the `path_provider` package

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/video.mp4');

    await file.writeAsBytes(bytes);
   await ImageGallerySaver.saveFile(file.path);

    // Show a notification that the download is completed
    Fluttertoast.showToast(
      msg: "Video downloaded successfully to ${file.path}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else {
    // If the response is not successful, show an error message
    Fluttertoast.showToast(
      msg: "Failed to download the video. Error: ${response.statusCode}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
