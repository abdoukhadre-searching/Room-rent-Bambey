import 'package:flutter/material.dart';
import 'package:maps_abdoukhadre/pages/authentification/phoneauth-screen.dart';
import 'package:maps_abdoukhadre/widgets/buttons.dart';

class AuthUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          Column(
            children: [              
              MaterialButton(
                onPressed: (){
                  Navigator.pushNamed(context, PhoneAuthScreen.id);
                },
                child: ButtonCustom(colorText: Color.fromARGB(255, 4, 14, 58), text: "Connexion avec Téléphone", cheminIcone: 'assets/icons/icons8_phone_24px.png', colorBg: Colors.white)),
              MaterialButton(onPressed: (){},child: ButtonCustom(colorText: Color.fromARGB(255, 4, 14, 58), text: "Connexion avec Google", cheminIcone: 'assets/icons/icons8_google_24px.png', colorBg: Colors.white)),
              MaterialButton(onPressed: (){},child: ButtonCustom(colorText: Colors.white, text: "Connexion avec Facebook", cheminIcone: 'assets/icons/icons8_facebook_24px_1.png', colorBg: Color.fromARGB(255, 3, 110, 232)))
            ]
          )
        ],
      )
    );
  }
}