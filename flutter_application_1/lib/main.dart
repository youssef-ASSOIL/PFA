
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PFA());
}
class PFA extends StatelessWidget {
  const PFA({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primarySwatch: Colors.amber
      ),
       home: const login_screen() ,
    );
   
  }
}