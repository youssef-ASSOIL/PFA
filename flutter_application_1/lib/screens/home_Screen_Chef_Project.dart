import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Scaffold(
        
        backgroundColor: Colors.grey[100],
        body: Text('Amine',style: GoogleFonts.robotoCondensed(fontSize: 20,fontWeight: FontWeight.bold))
      ),
    );
  }
}