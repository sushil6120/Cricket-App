import 'package:flutter/material.dart';
import 'package:you_got_world/themes/colors.dart';

class AppTheme {


  // Font Families
  static const String fontFamilyRegular = 'Poppins';
  static const String fontFamilyBold = 'Poppins';

  // TextStyles
  static TextStyle headline1(BuildContext context) {
    return TextStyle(
      fontFamily: fontFamilyBold,
      fontSize: MediaQuery.of(context).size.width * 0.08, // Example calculation
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headline2(BuildContext context) {
    return TextStyle(
      fontFamily: fontFamilyBold,
      fontSize: MediaQuery.of(context).size.width * 0.06, // Example calculation
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle bodyText1(BuildContext context) {
    return TextStyle(
      fontFamily: fontFamilyRegular,
      fontSize:
          MediaQuery.of(context).size.width * 0.045, // Example calculation
      color: textColor,
    );
  }

  static TextStyle bodyText2(BuildContext context) {
    return TextStyle(
      fontFamily: fontFamilyRegular,
      fontSize: MediaQuery.of(context).size.width * 0.04, // Example calculation
      color: textColor,
    );
  }

  static TextStyle buttonText(BuildContext context) {
    return TextStyle(
      fontFamily: fontFamilyBold,
      fontSize: MediaQuery.of(context).size.width * 0.05, // Example calculation
      color: textLightColor,
      fontWeight: FontWeight.bold,
    );
  }

  // ThemeData
  static ThemeData getThemeData(BuildContext context) {
    return ThemeData(
      primaryColor: primaryColor,
      hintColor: accentColor,
      cardColor: errorColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: TextTheme(
        displayLarge: headline1(context),
        displayMedium: headline2(context),
        bodyLarge: bodyText1(context),
        bodyMedium: bodyText2(context),
        labelLarge: buttonText(context),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
