import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maps_abdoukhadre/pages/authentification/otp_sreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_abdoukhadre/pages/mapsPage.dart';


class PhoneAuthService {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser(context) async {

      //on s'assure le user current n'est pas dans la base
      final QuerySnapshot result = await users.where('uid',isEqualTo: user?.uid).get();

      //on recuperela liste de ts les users
      List<DocumentSnapshot> document = result.docs;

      if (document.length > 0 ){
        // user existe..firestore no need
        Navigator.popAndPushNamed(context, HomePage.id);
      } else {
        // user n'existe pas on l'ajoute ds la Databse
        return users.doc(user?.uid)
          .set({
            'uid': user?.uid,
            'mobile': user?.phoneNumber,
            'email': user?.email 
          })
          .then((value) {
            print("User added");
          })
          .catchError((error) {
            print("Echec lors de l'ajout de l'uitilisateur: $error");
          } );
      }
      
    }

    Future<void> verifyPhoneNumber(BuildContext context, number) async {
      final PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential credential) async {
        // Sign the user in (or link) with the auto-generated credential
      await auth.signInWithCredential(credential);        
      };

      final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('Le numeor de telephne fourni nest pas valide');
        }
      };

      final PhoneCodeSent codeSent = (String verificationId, int? resendToken) async {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> OTPScreen(numeroTelephone: number, verID: verificationId)));
      };

      try {
          auth.verifyPhoneNumber(
            phoneNumber: number,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            timeout: const Duration(seconds:60),
            codeAutoRetrievalTimeout: (String verificationId) {
              print("verificationId:...."+verificationId);
            }
          );

          
      } catch(e) { 
        print(e.toString()); 
      }
    }

}