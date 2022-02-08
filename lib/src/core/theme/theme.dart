import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hon_app/src/core/constants/constants.dart';

ThemeData honTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    systemOverlayStyle: uiOverlayStyle,
  ),
  scaffoldBackgroundColor: const Color(0xFFF8F8F8),
  textTheme: GoogleFonts.nunitoTextTheme(),
);
