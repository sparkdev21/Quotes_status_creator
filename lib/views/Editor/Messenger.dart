import 'package:fluttertoast/fluttertoast.dart';

class Messenger {
  Messenger();
  showAlert(msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
