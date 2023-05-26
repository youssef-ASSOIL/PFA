import 'package:flutter/material.dart';
import 'package:then_number_two/main_tracker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
                return const MainTrackerPage();
              },
            ),
          );
        },
        child: const Text("Main Tracker"),
      ),
    );
  }
}
