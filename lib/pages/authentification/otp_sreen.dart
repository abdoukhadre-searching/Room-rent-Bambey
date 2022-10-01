import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maps_abdoukhadre/pages/authentification/phoneauth-screen.dart';
import 'package:maps_abdoukhadre/pages/mapsPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_abdoukhadre/pages/services/phoneauthservice.dart';

class OTPScreen extends StatefulWidget {
  final String numeroTelephone, verID;
  const OTPScreen({required this.numeroTelephone,  required this.verID});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  bool _chargement = false;
  late String erreurs = "";

  PhoneAuthService _service = PhoneAuthService();

  var _text1 = TextEditingController();
  var _text2 = TextEditingController();
  var _text3 = TextEditingController();
  var _text4 = TextEditingController();
  var _text5 = TextEditingController();
  var _text6 = TextEditingController();

  // ignore: non_constant_identifier_names
  Future <void> IdentifiantTelephone(BuildContext context, String otp) async {

    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential identifiant = PhoneAuthProvider.credential(
        verificationId: widget.verID,
        smsCode: otp
      );
      //maintenant on valide l'auth de ce user
      final User? user = (await _auth.signInWithCredential(identifiant)).user;

      if (user!=null) {
        // on se connecte
        //en ajouter les info du user
        _service.addUser(context);
        Navigator.pushReplacementNamed(context, HomePage.id);
      } else {
        Fluttertoast.showToast(msg: "Echec lors de tentative de connexion");
        if (mounted){
          setState(() {
            erreurs = "Echec de connexion";
          });
        }
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        setState(() {
          erreurs = "OTP invalide";
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 12, 40),
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(' Login', style: TextStyle(color: Colors.white)),   
        automaticallyImplyLeading: false,     
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            
            SizedBox(height: 40), //
            CircleAvatar(
                radius: 40,
                backgroundColor: Color.fromARGB(255, 36, 40, 57),
                child: Image.asset("assets/images/avatar-5.png", fit: BoxFit.cover)
            ),
            SizedBox(height: 20), //
            Text('Code de Vérification',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 26, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 10), //
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vous avez normalement reçu un code de vérification à 6 chiffres sur le numéro suivant:',
                  style: TextStyle(color: Color.fromARGB(255, 179, 179, 179),fontSize: 15, fontWeight: FontWeight.normal, fontFamily: 'Ubuntu')
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(widget.numeroTelephone, 
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 110, 232), 
                          fontSize: 15, 
                          fontWeight: FontWeight.bold, 
                          fontFamily: 'Ubuntu'
                        )
                      )
                    ), 
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => PhoneAuthScreen()));
                      },
                      child: Icon(Icons.edit, color: Colors.white, size: 15))
                  ]
                ),

              ],
            ), 
            SizedBox(height: 30), 
            Row(children: [
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  controller: _text1,
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    if (value.length == 1) {
                      node.nextFocus();
                    }   
                  },
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color.fromARGB(255, 105, 211, 240), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color:Color.fromARGB(255, 3, 110, 232), width: 1.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  controller: _text2,
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    if (value.length == 1) {
                      node.nextFocus();
                    }   
                  },
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color.fromARGB(255, 105, 211, 240), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color:Color.fromARGB(255, 3, 110, 232), width: 1.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  controller: _text3,
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    if (value.length == 1) {
                      node.nextFocus();
                    }   
                  },
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color.fromARGB(255, 105, 211, 240), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color:Color.fromARGB(255, 3, 110, 232), width: 1.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  controller: _text4,
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    if (value.length == 1) {
                      node.nextFocus();
                    }   
                  },
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color.fromARGB(255, 105, 211, 240), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color:Color.fromARGB(255, 3, 110, 232), width: 1.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  controller: _text5,
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    if (value.length == 1) {
                      node.nextFocus();
                    }   
                  },
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color.fromARGB(255, 105, 211, 240), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color:Color.fromARGB(255, 3, 110, 232), width: 1.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  controller: _text6,
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    if (value.length == 1) {
                      if (_text1.text.length == 1) {
                        if (_text2.text.length == 1) {
                          if (_text3.text.length == 1) {
                            if(_text4.text.length == 1) {
                              if(_text5.text.length == 1) {
                                if(_text6.text.length == 1) {
                                  // c'ets le otp recu depuis firebase
                                  String _otp = '${_text1.text}${_text2.text}${_text3.text}${_text4.text}${_text5.text}${_text6.text}';
                                  //login 
                                  setState(() {
                                    _chargement = true;
                                  });
                                  IdentifiantTelephone(context, _otp);
                                }
                              }
                            }
                          }
                        }
                      }
                    } else {
                      setState(() {
                        _chargement = false;
                      });
                    }
                  },
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color.fromARGB(255, 105, 211, 240), width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color:Color.fromARGB(255, 3, 110, 232), width: 1.0),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 20),
            
            if (_chargement)
            
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50,
                child: LinearProgressIndicator(
                  minHeight: 2,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 3, 110, 232))
                )
              ),
            ),

            SizedBox(height:  18),

            Text(erreurs,style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold))
          ]
        )
      )
    );
    
  }
}