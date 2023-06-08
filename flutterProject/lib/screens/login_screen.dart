import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/UserType.dart';
import 'package:google_fonts/google_fonts.dart';

import '../connectionDb/connection.dart';
import 'Client_screens/Client_Home.dart';

class login_screen extends StatefulWidget {
  final UserType userType;

  const login_screen({Key? key, required this.userType}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  Future signIn() async {
    try {
      if (widget.userType == UserType.Client) {
        GestionClient gestionClient = GestionClient();
        List<Map<String, dynamic>> fetchedClients =
            await gestionClient.connectToMongoDB();
        bool clientExists = false;
        String id="";
        for (var client in fetchedClients) {
          if (client['_id'].toString() == _email.text) {
            final idCompte = client['idCompte'];
            final compte = await fetchCompteById(idCompte);
            if (compte != null &&
                compte['password'].toString() == _password.text) {
              print("Exist");
              clientExists = true;
              id=client['_id'].toString();
              break;
            } else {
              print("Password incorrect");
            }
          }
        }

        if (!clientExists) {
          print("Client doesn't exist");
        }
        print("We're in Client");
        // Navigate to ClientHomeScreen
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientMenu(idClient: id,)),
        );
      } else if (widget.userType == UserType.Employee) {
        // Employee signed in
        // Add your code for employee sign-in
        // ...

        // Navigate to EmployeeHomeScreen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => EmployeeHomeScreen()),
        // );
      } else if (widget.userType == UserType.Manager) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
        
        // Navigate to ManagerHomeScreen
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ManagerHomeScreen()),
        // );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign In Error'),
          content: Text('Failed to sign in. Please check your credentials.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Image
                Image.asset(
                  'images/garbage-truck.png',
                  height: 150,
                ),
                SizedBox(height: 20),
                //title
                Text(
                  'Sign_In',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Welcome To You're app",
                  style: GoogleFonts.robotoCondensed(fontSize: 20),
                ),
                SizedBox(height: 20),
                //email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                //sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign_IN',
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.grey[50],
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //Text:sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sign_UP from here !',
                        style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold)),
                    Text(
                      'Sign_UP',
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.cyan, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
