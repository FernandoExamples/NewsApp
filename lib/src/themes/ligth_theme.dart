import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
  accentColor: Colors.red,
  textTheme: ThemeData.light().textTheme.copyWith(
        button: TextStyle(color: Colors.white),
      ),
);
