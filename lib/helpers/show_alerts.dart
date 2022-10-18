import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Text(titulo),
              content: Text(subtitulo),
              actions: <Widget>[
                MaterialButton(
                    child: Text('Ok'),
                    elevation: 5,
                    textColor: Colors.red[700],
                    onPressed: () => Navigator.pop(context))
              ],
            ));
  } else {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(titulo),
              content: Text(subtitulo),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
}
