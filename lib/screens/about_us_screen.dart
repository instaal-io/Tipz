import 'package:flutter/material.dart';
import 'package:tip_clap/screens/home_screen.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // This centers the title
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16.0 : 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Adjust image size for responsiveness
              Image.asset(
                'assets/TipLogo.png',
                width: isSmallScreen ? 150 : 250, // Example sizes
                height: isSmallScreen ? 150 : 250,
              ),
              const SizedBox(height: 24),
              // Responsive text size
              Text(
                'TipCal',
                style: TextStyle(
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Version: 184/1.0.0.1 2024',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w900
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Instaal Studio',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Copyright @2024',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
