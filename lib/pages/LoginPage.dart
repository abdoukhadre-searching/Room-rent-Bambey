import 'package:firebase_auth/firebase_auth.dart';
import 'package:maps_abdoukhadre/pages/mapsPage.dart';
import 'package:maps_abdoukhadre/widgets/auth_ui.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  //for the route name
  static const String id = 'login-page';

  // form key
  final _formKey = GlobalKey<FormState>();

  // Editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // Firebase instance 
  final _auth = FirebaseAuth.instance;  
  // Variable pour l'affichage de message d'erreurs flash 
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
  //  function for 'singIn' process
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Connection réussie "),                  
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage())),
            });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Votre email est mal consigné";

            break;
          case "wrong-password":
            errorMessage = "Mot de passe incorrect";
            break;
          case "user-not-found":
            errorMessage = "Cet email n'existe pas.";
            break;
          case "user-disabled":
            errorMessage = "L'eamil de cet ustilisateur est désactivé";
            break;
          case "too-many-requests":
            errorMessage = "Oops ! Beaucoup de requettes ";
            break;
          case "operation-not-allowed":
            errorMessage = "Connection avec Email/Mot de passe est désactivée.";
            break;
          default:
            errorMessage = "Vérifier l'etat d evotre connection Internet";
        }
        Fluttertoast.showToast(msg: " Erreur survenue : "+ errorMessage!);
        print(error.code);
      }
    }
  }
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      backgroundColor: Color.fromARGB(255, 4, 14, 58),
      body: Column(
        children: [
          SizedBox(height: 20),
          Image.asset('assets/images/alafunty_white.png', width: MediaQuery.of(context).size.width * 0.30),
          Expanded(
            child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Login", 
                          style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                          SizedBox(height: 30,),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Color.fromARGB(255, 226, 226, 226)))
                                  ),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Email requise");
                                      }
                                      // reg expression for email validation
                                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                          .hasMatch(value)) {
                                        return ("Votre email n'est pas conforme");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      emailController.text = value!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                      hintText: "Email"
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                  ),
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: passwordController,
                                    obscureText: true,
                                    validator: (value) {
                                      RegExp regex = new RegExp(r'^.{6,}$');
                                      if (value!.isEmpty) {
                                        return ("Mot de passe requise");
                                      }
                                      if (!regex.hasMatch(value)) {
                                        return ("Entrer un mot de passe valide (Min. 5 caractères)");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      passwordController.text = value!;
                                    },
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                                      hintText: "Mot de passe"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30,),
                          Center(
                            child: Container(
                              height: 50,
                              width: 150,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 3, 110, 232)
                              ),
                              child: MaterialButton(
                                onPressed: () {                    
                                  signIn(emailController.text, passwordController.text);
                                 },
                                child: Center(
                                  child: Text(
                                    "Se connecter", 
                                    style: TextStyle(color: Colors.white),)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ),
          // Expanded(
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                  Color.fromARGB(255, 4, 14, 58),
                  Color.fromARGB(255, 0, 0, 0)
                  ]
                ),
              ),
              child: AuthUI(),              
              // color: Colors.white
              ),
            ],
      ),
    );
  }

}