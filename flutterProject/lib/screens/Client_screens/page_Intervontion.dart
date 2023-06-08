import 'package:flutter/material.dart';

class PageIntervention extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intervention Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Title info d\'intervention',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Type de dechet',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter the type of waste',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Quantity',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter the quantity',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Date and Hour',
              style: TextStyle(fontSize: 16),
            ),
            InkWell(
              onTap: () {
                // Handle date and time picker
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  'Select Date and Hour',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle confirmation button press
                  },
                  child: Text('Confirmer'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle cancel button press
                  },
                  child: Text('Annuler'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
