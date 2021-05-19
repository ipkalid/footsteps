import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

showAlertDialog(BuildContext context,
    {required String title, required String content}) {
  var iOSDialog = CupertinoAlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text("Close"),
        onPressed: () => Navigator.pop(context),
      )
    ],
  );

  var androidDialog = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text("Close"),
      )
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Platform.isIOS ? iOSDialog : androidDialog;
    },
  );
}
