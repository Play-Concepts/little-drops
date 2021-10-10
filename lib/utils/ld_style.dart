import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drops/utils/ld_colors.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/src/extensions/color_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

TextStyle titleStyle({int size = 36}) {
  return GoogleFonts.fredokaOne(
    textStyle: TextStyle(
      color: ldTextTitleColor,
      fontSize: size.toDouble(),
    ),
  );
}

TextStyle primaryTextStyle(
    {int size = 16, Color textColor = ldTextPrimaryColor}) {
  return TextStyle(
    fontSize: size.toDouble(),
    color: textColor,
  );
}

TextStyle secondaryTextStyle(
    {int size = 14, Color textColor = ldTextSecondaryColor}) {
  return TextStyle(
    fontSize: size.toDouble(),
    color: textColor,
  );
}

TextStyle warningTextStyle(
    {int size = 14, Color textColor = ldSecondaryColorRed}) {
  return TextStyle(
    fontSize: size.toDouble(),
    fontWeight: FontWeight.bold,
    color: textColor,
  );
}

TextStyle boldTextStyle(
    {int size = 18,
    Color textColor = ldTextPrimaryColor,
    FontWeight textWeight = FontWeight.bold,
    double? letterSpacing,
    double? wordSpacing}) {
  return TextStyle(
      fontSize: size.toDouble(),
      color: textColor,
      fontWeight: textWeight,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing);
}

BoxDecoration boxDecorations(
    {double radius = 8,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      boxShadow: showShadow
          ? [BoxShadow(color: ldShadowColor, blurRadius: 10, spreadRadius: 2)]
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

BoxDecoration boxDecoration(
    {double radius = 80.0,
    Color backGroundColor = ldPrimaryColor,
    double blurRadius = 8.0,
    double spreadRadius = 8.0,
    Color radiusColor = Colors.black12,
    Gradient? gradient}) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: radiusColor,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ],
      color: backGroundColor,
      gradient: gradient);
}

class SDButton extends StatefulWidget {
  static String tag = '/T4Button';
  var textContent;
  VoidCallback? onPressed;
  var isStroked = false;
  var height = 40.0;

  SDButton(
      {required this.textContent,
      required this.onPressed,
      this.isStroked = false,
      this.height = 45.0});

  @override
  SDButtonState createState() => SDButtonState();
}

class SDButtonState extends State<SDButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        alignment: Alignment.center,
        child: Text(
          widget.textContent,
          textAlign: TextAlign.center,
          style: boldTextStyle(
              size: 16, textColor: Colors.white, letterSpacing: 2),
        ),
        decoration: widget.isStroked
            ? boxDecorations(bgColor: Colors.transparent, color: ldPrimaryColor)
            : boxDecorations(bgColor: ldPrimaryColor, radius: 6),
      ),
    );
  }
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

/// Change status bar Color and Brightness
Future<void> setStatusBarColor(
  Color statusBarColor, {
  Color? systemNavigationBarColor,
  Brightness? statusBarBrightness,
  Brightness? statusBarIconBrightness,
  int delayInMilliSeconds = 200,
}) async {
  await Future.delayed(Duration(milliseconds: delayInMilliSeconds));

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      systemNavigationBarColor: systemNavigationBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarIconBrightness ??
          (statusBarColor.isDark() ? Brightness.light : Brightness.dark),
    ),
  );
}
