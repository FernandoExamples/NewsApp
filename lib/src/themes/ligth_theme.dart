import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
  accentColor: Colors.blue,
  buttonColor: Colors.blue,
  textTheme: ThemeData.light().textTheme.copyWith(
        button: TextStyle(color: Colors.white),
      ),
);
