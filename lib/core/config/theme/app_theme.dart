import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jusicool_design_system/jusicool_design_system.dart';

ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: JusicoolColor.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: JusicoolColor.white,
    elevation: 0,
  ),
);
