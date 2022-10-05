
import 'package:flutter/material.dart';

///Makes the login app bar.
///Returns the appbar.
AppBar makeLoginAppBar(){
  return AppBar(
    title: Text(
        "Sign in",
        style: TextStyle(
            fontSize: 30,
        ),
    ),
    toolbarHeight: 80,
    centerTitle: true,
  );
}