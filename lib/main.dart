import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tip_clap/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(
        Theme.of(context).textTheme,
    )),
      debugShowCheckedModeBanner: false,
      title: 'Tip Clap',
      home: const SplashScreen() ,
    );
  }
}

