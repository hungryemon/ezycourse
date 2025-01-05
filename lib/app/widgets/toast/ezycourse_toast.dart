import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EzyCourseToast {
  static success(
      {required String msg,
      ToastGravity toastPosition = ToastGravity.BOTTOM}) {
        Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: toastPosition,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  
  }

  static error(
       {required String msg,
      ToastGravity toastPosition = ToastGravity.BOTTOM}) {
        Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: toastPosition,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  
  }

  static info(
       {required String msg,
      ToastGravity toastPosition = ToastGravity.BOTTOM}) {
        Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: toastPosition,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  
  }

  static warning(
       {required String msg,
      ToastGravity toastPosition = ToastGravity.BOTTOM}) {
        Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: toastPosition,
        backgroundColor: Colors.orangeAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  
  }
}


