import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/* Colors */
class AppColors {
  static const bronce = Color.fromRGBO(235, 219, 206, 1);
  static const grey = Color.fromARGB(255, 163, 161, 161);
  static const orange = Color(0xFFFE9301);
  static const darkOrange = Color.fromRGBO(255, 135, 44, 1);
  static const green = Color(0xFFA8C638);
  static const brownLight = Color.fromRGBO(1, 125, 197, 1);
  static const blue = Color.fromRGBO(1, 125, 197, 1);
  static const blueDark = Color.fromRGBO(1, 112, 185, 1);
  static const white = Color.fromARGB(255, 255, 255, 255);
  static const gold = Color.fromRGBO(222, 158, 61, 1);
  static const cream = Color.fromRGBO(255, 247, 235, 1);
  static const lightGreen = Color.fromRGBO(46, 226, 146, 1);
  static const newBrownBlblueDark = Color.fromRGBO(109, 68, 32, 1);
}

class AppIcons {
  static const paperPlane = FontAwesomeIcons.paperPlane;
  static const pencilAlt = FontAwesomeIcons.penToSquare;
  static const closeCircle = Icons.cancel_outlined;
  static const accountOutline = Icons.account_circle_outlined;
  static const messageOutline = Icons.messenger_outline_sharp;
  static const checkCircle = Icons.check_circle_outline;
  static const iconPlus = Icons.add_circle_outline;
  static const save = Icons.save;
  static const personOutline = Icons.person_outline;
  static const nonCheckCircle = Icons.circle_outlined;
  static const search = Icons.search;
  static const trash = Icons.delete;
}

final myTheme = ThemeData(
  primaryColor: AppColors.blueDark,
  colorScheme: const ColorScheme.light(
    primary: AppColors.blueDark,
    secondary: AppColors.blue,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  ),
  scaffoldBackgroundColor: AppColors.white,
  iconTheme: const IconThemeData(size: 30),
  appBarTheme: const AppBarTheme(
    elevation: 3,
    backgroundColor: AppColors.brownLight,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: MaterialStateBorderSide.resolveWith(
        (_) => const BorderSide(width: 1.5, color: AppColors.blue)),
    fillColor: MaterialStateProperty.all(AppColors.blue),
    checkColor: MaterialStateProperty.all(Colors.white),
  ),
);

/* TextStyles */

TextStyle appDropdown = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

/* Durations */

Duration durationLoading = const Duration(seconds: 30);
