import 'package:calendar_page/screens/home_screen.dart';
import 'package:calendar_page/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Define the default font family.
        fontFamily: 'ClashDisplay',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          headline2: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          headline3: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          headline4: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          bodyText1: GoogleFonts.poppins(
            fontSize: 15.0,
            fontStyle: FontStyle.normal,
            color: textColor,
          ),
          
        ),
      ),
      home: HomeScreen(),
    );
  }
}
