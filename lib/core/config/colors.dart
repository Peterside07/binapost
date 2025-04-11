import 'package:flutter/material.dart';

final appColor = PoColors();

class PoColors {
  // PoColors();
  static PoColors? _instance;

  factory PoColors() {
    return _instance ??= PoColors._internal();
  }

  PoColors._internal();

  final purple = const Color(0xff522583);
  final purpleCardVariant = const Color(0xffF7EFFD);
  final orangeBeginGrad = const Color(0xffFF5041);
  final red = const Color(0xffF22E52);
  final pink = const Color(0xffC3B0D1);

  final orangeEndGrad = const Color(0xffFF6A13);
  final primary = const Color(0xff521c78);
  final accent = const Color(0xFFDA9A19);
  final backgroundDeep = const Color(0xFFFEEBDD);
  final transparent = Colors.transparent;
  final gray = const Color(0xFFB1B0B0);
  final lightGrey3 = const Color(0xFFCECECE);
  final lightGrey4 = const Color(0xFFEDEDED);
  final lightGrey5 = const Color(0xFF9F9F9F);
  final green = const Color(0xFF3E781C);
  final statusGreen = const Color(0xFF018D6A);
  final successDarkGreen = const Color(0xFF38651D);
  final purpleAccent = const Color(0xFFFDFAFE);
  final purpleAccent2 = const Color(0xFFFAF4FF);
  final purpleAccent3 = const Color(0xFFF8EEFF);
  final backgroundGreen = const Color(0xFFE8FFDB);
  final black = const Color(0xFF010101);
  final textBlack = const Color(0xFF34302F);
  final popupItemBlack = const Color(0xFF060507);
  final blackMedium = const Color(0xFF303030);
  final background = const Color(0xFFEEEDED);
  final background1 = const Color(0xFFFFFFFF);
  final shadowGrey2 = const Color(0x112F2F2F);
  final darkGray = const Color(0xFF8A838E);
  final lightGray = const Color(0xFFC8C8C8); //0xFFF8F8F8
  final lightGray2 = const Color(0xFFF9F8F9); //0xFFF8F8F8
  final lightGray3 = const Color(0xFFF9F2FF);
  final purpleGray2 = const Color(0xFFF8F8F8);
  final purpleGray = const Color(0xFFF9F8F9);
  final darkGray2 = const Color(0xFF646464);
  final darkGray3 = const Color(0xFF4E4E4E);
  final darkGray5 = const Color(0xFF737373);
  final darkGray6 = const Color(0xFFD8D8D8);
  final darkGray7 = const Color(0xFFC9C9C9);
  final transparentBlack = const Color(0xD8010101);
  final shadowGrey = const Color(0x232F2F2F);
  final success = const Color(0xFF43C084);
  final blue = const Color(0xFF379BF6);
  final offWhite = const Color(0xFFF7F7F7);
  final white = const Color(0xFFFFFFFF);
  final formError = Colors.red.shade400;
  final yellow = const Color(0xFFF2C364);
  final backgroundYellow = const Color(0xFFFFF2DB);
  final bottomSheetPillColor = const Color(0xFFE6E6E6);
  final borderColor = const Color(0xFFEFECF0);
  final faintGrey = const Color(0xFF929292);
  final filterByBorderColor = const Color(0xFFEDEDED);


  final smallGradient = const LinearGradient(
      begin: Alignment(-0.9449995756149292, -1.0066247582435608),
      end: Alignment(-1.10259151458740234, 0.8449995756149292),
      // stops: [0.1,0.4,0.5],
      colors: [
        Color.fromRGBO(163, 0, 5, 1),
        Color.fromRGBO(47, 46, 52, 1),
      ]);

  final primaryGradient = const LinearGradient(
      begin: Alignment(-0.9449995756149292, -1.0066247582435608),
      end: Alignment(-1.10259151458740234, 0.8449995756149292),
      colors: [
        Color.fromRGBO(163, 0, 5, 1),
        Color.fromRGBO(47, 46, 52, 1),
      ]);

  final secondaryGradient =
      const LinearGradient(begin: Alignment(-0.3, -1), end: Alignment(-0.9, 6), colors: [
    Color.fromRGBO(163, 0, 5, 1),
    Color.fromRGBO(47, 46, 52, 1),
  ]);
}
