import 'package:flutter/material.dart';
import 'package:tip_clap/screens/home_screen.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
        backgroundColor: const Color(0xFFF6F8FC),
       appBar: AppBar(
    leading: IconButton(
    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
    onPressed: () {
    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
    },
    ),
    backgroundColor: Colors.deepOrangeAccent,
    title: const Text(
    'Feedback',
    style: TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16.0 : 32.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please Share your honest feedback',
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFFF495057),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                hintText: 'Enter your feedback here',
                contentPadding: EdgeInsets.all(12.0),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(

                onPressed: () {
                  // Handle feedback submission logic here
                  String feedback = _feedbackController.text;
                  // Perform any action with feedback, like sending it to a server
                  print('Feedback submitted: $feedback');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(screenWidth*0.70, 48),
                  backgroundColor: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                child: Text(
                  'Submit Feedback',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
