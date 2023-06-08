import 'package:flutter/material.dart';

Widget helpPage(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Help'),
    ),
    body: Padding(
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
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Handle button press
            },
            child: Text('FAQs'),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Handle button press
            },
            child: Text('Tutorials'),
          ),
        ],
      ),
    ),
  );
}
