import 'package:fluttertoast/fluttertoast.dart';

bool debug = true;



showToast(value, msg) {
  if (value) {
    Fluttertoast.showToast(msg: msg);
  }
}