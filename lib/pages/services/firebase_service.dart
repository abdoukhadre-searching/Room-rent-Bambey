import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maps_abdoukhadre/pages/mapsPage.dart';

class FirebaseService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> updateUser(Map<String, dynamic>data, context) {
  return users
    .doc(user?.uid)
    .update(data)
    .then((value) => Navigator.pushNamed(context, HomePage.id))
    .catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Echec lors de la modifictaion des informations de l'utilisateur"),
        )        
      );
    });
  }
}