import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ProgressDialog {
  static show(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return WillPopScope(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(0.9),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            onWillPop: () async => false,
          );
        });
  }

  static dissmiss(BuildContext context) {
    Navigator.pop(context);
  }
}

abstract class Dialogs {
  static alert(BuildContext context,
      {required String title, required String description}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(_);
              },
              child: Text("OK"))
        ],
      ),
    );
  }
}
