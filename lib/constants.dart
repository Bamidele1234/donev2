import 'package:flutter/material.dart';

// Essential Colors
const kScaffoldColor = Color(0xFF0D1020);
const kListTileColor = Color(0xFF1D1E33);
const kSecondaryColor = Color(0xFFEB1555);
const kTertiaryColor = Color(0xff8A95D0);
const kShadowColor = Color(0xffEE2F69);
const kPopUpColor = Color(0xff12172B);
double kIconSize = 30;

// The shape of the bottomModalSheet
const kRoundedBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30.0),
    topRight: Radius.circular(30.0),
  ),
);

// The shape of the alert dialog and the showTime picker
const kAlertShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(30),
  ),
);

/// The style for the 'CATEGORIES' and 'YOUR TASKS' on the home page
const kText1 = TextStyle(
  fontSize: 16,
  color: Colors.white70,
  letterSpacing: 1.2,
);
