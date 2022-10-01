import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maps_abdoukhadre/pages/LoginPage.dart';
import 'package:maps_abdoukhadre/pages/mapsPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String id = "splash-screen_page";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
      FirebaseAuth.instance.authStateChanges().listen((User? user){
         if (user == null) {
          Navigator.pushReplacementNamed(context, LoginPage.id);
        } else {
          Navigator.pushReplacementNamed(context, HomePage.id);
        }
      });
      
      }
    );      

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 14, 58),
      body:  Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Color.fromARGB(255, 4, 14, 58),
            // decoration: BoxDecoration(
            //   shape: BoxShape.rectangle,
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/team_alafunty.jpg"), fit: BoxFit.cover),
            // ),
            // child: Container(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         Colors.white.withOpacity(0),
            //         Colors.black.withOpacity(0.7)
            //       ],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter
            //     )
            //   )
            // )          
          ),
          Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200.0,
                    child: Image.asset('assets/images/alafunty_white.png', width: MediaQuery.of(context).size.width * 0.60)

                    // AnimatedTextKit(
                    //   animatedTexts: [
                    //     ColorizeAnimatedText(
                    //       'CODING FOR BETTER LIVE BY TEH',                      
                    //       textAlign: TextAlign.center,
                    //       textStyle: colorizeTextStyle,
                    //       colors: colorizeColors,
                    //     ),
                    //   ],
                    //   isRepeatingAnimation: true,
                    //   onTap: () {
                    //     print("Tap Event");
                    //   },
                    // ),
                  ), 

                ],
              ),
          ),
        ],
      ), 
    );
  }
}