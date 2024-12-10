import 'dart:async';
import 'package:flutter/material.dart';

import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Navigate to the Intro screen after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Centered Image and Text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/TipLogo.png',
                  width: isSmallScreen ? screenSize.width * 0.6 : screenSize.width * 0.4,
                  height: isSmallScreen ? screenSize.width * 0.6 : screenSize.width * 0.4,
                ),
                SizedBox(height: isSmallScreen ? 20 : 30),
                // Optionally add a text here if needed
                // Text(
                //   'Welcome to TipCal',
                //   style: TextStyle(
                //     fontSize: isSmallScreen ? 18 : 24,
                //     color: Colors.deepOrangeAccent,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
          // Bottom Centered Loading Indicator
          Positioned(
            bottom: 40, // Adjust as needed for spacing from bottom
            left: 0,
            right: 0,
            child: Center(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return SweepGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1), // White
                      Color.fromRGBO(194, 194, 194, 1), // Gray
                    ],
                    startAngle: 0.0,
                    endAngle: 3.14 * 2,
                    tileMode: TileMode.clamp,
                  ).createShader(bounds);
                },
                child: SizedBox(
                  width: isSmallScreen ? 40 : 50,
                  height: isSmallScreen ? 40 : 50,
                  child: CircularProgressIndicator(
                    strokeWidth: isSmallScreen ? 5 : 7,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
