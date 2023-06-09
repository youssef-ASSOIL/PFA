import 'package:flutter/material.dart';

Widget helpPage(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Help'),
      backgroundColor: Color(0xFF0E8388), // Set the app bar color here
    ),
    body: Container(
      color: Color(0xFFCBE4DE), // Set the desired background color here
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'How can we assist you?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text('Contact Support'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2E4F4F), // Set the button color here
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text('FAQs'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2E4F4F), // Set the button color here
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              child: Text('Tutorials'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF2E4F4F), // Set the button color here
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
