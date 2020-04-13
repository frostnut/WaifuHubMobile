import 'package:flutter/material.dart';
import '../global/assets.dart';

/// form fields
Widget registrationTextFormField(
    String labelText,
    TextEditingController inputController,
    Function validator,
    bool obscureText) {
  return TextFormField(
    cursorColor: lightPinkColor,
    decoration: InputDecoration(
      enabledBorder: new UnderlineInputBorder(
        borderSide: BorderSide(
          color: lightPinkColor,
        ),
      ),
      focusedBorder: new UnderlineInputBorder(
        borderSide: BorderSide(
          color: lightPinkColor,
        ),
      ),
      labelText: labelText,
      labelStyle: textForm,
    ),
    controller: inputController,
    obscureText: obscureText,
    validator: validator,
  );
}
