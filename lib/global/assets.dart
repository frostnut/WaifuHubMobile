// This file is used to define global assets settings
import 'package:flutter/material.dart';

// app color scheme defintion
// darkPinkColor is used mainly for the bottom
// navigation icons and text for forms
// itemSelectedColor is used in the bottom
// navigation menu to define the chosen item
// lightPinkColor is used for the buttons
// and lits view containers
// headingsPinkColor is used for headings
// for reference see the mocks in the assets
// folder
const darkPinkColor = const Color(0xFF880E4F);
const itemSelectedColor = const Color(0xFFE91E63);
const lightPinkColor = const Color(0xFFEC407A);
const headingsPinkColor = const Color(0xFFD81B60);

// Text style definition for large headings
TextStyle headingLarge = new TextStyle(
  color: headingsPinkColor,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

// Text style definition for normal headings
TextStyle headingNormal = new TextStyle(
  color: lightPinkColor,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

// Text style definition for form text
TextStyle textForm = new TextStyle(
  color: darkPinkColor,
  fontSize: 14,
);

// Text style definition for normal text
TextStyle textStandard = new TextStyle(
  color: darkPinkColor,
  fontSize: 17,
);
