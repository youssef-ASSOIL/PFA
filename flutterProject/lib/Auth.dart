import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_Screen_Chef_Project.dart';


class Auth extends StatelessWidget {
  const Auth({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream:  FirebaseAuth.instance.authStateChanges(),
        builder: ((context,snapshot){
           if (snapshot.hasData) {
             return HomeScreen();
                   
           }else{
            return helpPage(context);
          }

        })
      ),
    );
  }
}