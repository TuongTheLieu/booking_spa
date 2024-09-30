import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Thông báo
toastInfo({
  required String msg,
  Color backgroundColor = Colors.red,
  Color textColor = Colors.white,
}) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg: msg,
    backgroundColor: backgroundColor,
    textColor: textColor,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    fontSize: 16,
  );
}
