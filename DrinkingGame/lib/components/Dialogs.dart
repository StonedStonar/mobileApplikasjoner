import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///Shows an alert that is defined
///[context] the build context
///[title] the title of the dialog
///[content] the content of the dialog
///[defaultActionText] the default action text. Like ok
///Returns true if the user has pressed Ok.Otherwise false.
Future<bool?> showAlertDialog(BuildContext context,
    {required String title,
    required String content,
    required String defaultActionText,
    String? cancelActionText}) {
  if (!Platform.isIOS) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            TextButton(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(defaultActionText)),
        ],
      ),
    );
  } else {
    return showDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(defaultActionText)),
        ],
      ),
    );
  }
}

///Shows an exception alert dialog.
///[context] the build context.
///[title] the tile of the alert.
///[exception] the exception
///Returns a dialog with the exception as error.
Future<void> showExceptionAlertDialog(BuildContext context,
    {required String title, required Exception exception}){
  return showAlertDialog(
      context,
      title: title,
      content: _getExceptionMessage(exception),
      defaultActionText: "Ok");
}

///Gets the exception message from the exception
///[exception] the exception itself.
///Returns the exception message.
String _getExceptionMessage(Exception exception){
  String errorString;
  if(exception is FirebaseException){
    errorString = exception.message.toString();
  }else{
    errorString = exception.toString();
  }
  return errorString;
}
