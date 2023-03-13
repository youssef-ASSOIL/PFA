import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                  children:[
                    //Image
                    Image.asset(
                      'images/garbage-truck.png',
                        height:150
                      ),
                      SizedBox(height: 20),
                //title
                     Text(
                       'Sign_In',
                       style: GoogleFonts.robotoCondensed(fontSize: 40,fontWeight: FontWeight.bold),
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
                        borderRadius:  BorderRadius.circular(12)
                        ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
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
                        borderRadius:  BorderRadius.circular(12)
                        ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                            obscureText: true,
                             decoration: InputDecoration(
                             border: InputBorder.none,
                             hintText: 'Password',
                                  ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 15,),
                //sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text('Sign_IN',
                    style: GoogleFonts.robotoCondensed( color: Colors.grey[50],fontWeight: FontWeight.bold ,fontSize: 18),
                   
                    )),
                    
                  ),
                ),

                SizedBox(height:20),
              
                //Text:sign up
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [  
                    Text('Sign_UP from here !',style: GoogleFonts.robotoCondensed(fontWeight: FontWeight.bold)),
                    Text('Sign_UP' ,style: GoogleFonts.robotoCondensed(color: Colors.cyan,fontWeight: FontWeight.bold),)
                    
                  ],
                )
              ],
          ),
        ),
      ),
    );
  }
}