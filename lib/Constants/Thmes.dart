// flextherme choices dark

// flextheme.materialBAseline

// all
// brandblue ,money
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final List<FlexScheme> themeColors = [
  FlexScheme.brandBlue,
  FlexScheme.mallardGreen,
  FlexScheme.outerSpace
];
final colorsname = {
  0: "Blue",
  1: "Cosmic",
  2: "Navy",
};

// Success flutter Toast
void successToast(context) {
  Fluttertoast.showToast(
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green.shade400,
      msg: "Saved in Gallery Successfully");
}
