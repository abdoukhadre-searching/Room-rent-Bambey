import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maps_abdoukhadre/pages/LoginPage.dart';
import 'package:maps_abdoukhadre/pages/authentification/phoneauth-screen.dart';
import 'package:maps_abdoukhadre/pages/mapsPage.dart';
import 'pages/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 5)),
      builder:(context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false
          );
        } else {
          return MaterialApp(            
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.black,
              fontFamily: 'Cambria'
            ),
            home: LoginPage(),
            initialRoute: SplashScreen.id,
            routes: {
              //ici on a toutes les routes pour les differentes pages de notreapplication
              SplashScreen.id: (context)=> SplashScreen(),
              LoginPage.id: (context)=> LoginPage(),
              PhoneAuthScreen.id: (context)=> PhoneAuthScreen(),
              HomePage.id: (context)=> HomePage(),
            }
          );
        }
      }
    );
  }
}
