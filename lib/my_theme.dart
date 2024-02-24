import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static Color primaryColor = Color(0xff5D9CEC);
  static Color lightBody = Color(0xffDFECDB);
  static Color wightColor = Color(0xffFFFFFF);
  static Color grayColor = Color(0xffC8C9CB);
  static Color deepGrayColor = Color(0xff707070);
  static Color blackColor = Color(0xff5383838);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color darkBlackColor = Color(0xff141922);
  static Color darkBody = Color(0xff060E1E);

  static ThemeData lightTheme = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBody,
      textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins(
              fontSize: 22, fontWeight: FontWeight.bold, color: wightColor)),
      bottomAppBarTheme: BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: primaryColor,
          unselectedItemColor: grayColor),
      appBarTheme: AppBarTheme(
        backgroundColor: MyTheme.primaryColor,
        elevation: 0,
      ));

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
  );
}
