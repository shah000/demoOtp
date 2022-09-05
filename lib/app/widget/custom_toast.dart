import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

customToast(
    {required String message,
    required Color bgColor,
    required Color textColor}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: 12);
}
