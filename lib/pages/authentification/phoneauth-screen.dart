import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_abdoukhadre/pages/services/phoneauthservice.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const String id = 'phone-auth-page';
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
    
    bool validate = false;  

    var indicateurPaysController = TextEditingController(text: '+221');
    
    var phoneNumberController = TextEditingController();

    SimpleFontelicoProgressDialog? _dialog ;

    void _showDialog({required SimpleFontelicoProgressDialogType type, required String text, required BuildContext context}) async{
      _dialog =  SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false);

      _dialog!.show(
        message: text, 
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        type: type,     
        horizontal: true, 
        width: 200,           
      );
      await Future.delayed(Duration(seconds: 3));
      _dialog?.hide();

    }

    // showAlertDialog(BuildContext context){
    //   AlertDialog alert = new AlertDialog(
    //     content: Row(children: [
    //       CircularProgressIndicator(),
    //       SizedBox(width: 30),
    //       Text("Traitement...", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    //     ],)
    //   );
    //   showDialog(
    //     barrierDismissible: false,
    //     context: context, 
    //     builder: (BuildContext context){
    //     return alert;
    //   });
    // }
    
    PhoneAuthService _service = PhoneAuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 12, 40),
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Login', style: TextStyle(color: Colors.white)),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            
            SizedBox(height: 40), //
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Color.fromARGB(255, 36, 40, 57),
                child: Image.asset("assets/images/avatar-5.png", fit: BoxFit.cover)
              ),
            ),
            SizedBox(height: 20), //
            Text('Entrer votre numéro de telephone',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 26, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 10), //
            Text('Vous allez recevoir un code de vérification sur votre numéro de téléphone',
              style: TextStyle(color: Color.fromARGB(255, 179, 179, 179),fontSize: 15, fontWeight: FontWeight.normal, fontFamily: 'Ubuntu')
            ), 
            SizedBox(height: 30), 
            Row(children: [
              Expanded(flex: 1,child: TextFormField(
                style: TextStyle(color:Color.fromARGB(255, 113, 113, 113)),
                controller: indicateurPaysController,
                enabled: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 37),
                  labelText: 'Pays',
                  labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color:Color.fromARGB(255, 3, 110, 232)),
                ),
              )),
              SizedBox(width: 15),
              Expanded(
                  flex: 3,
                  child: TextFormField(        
                    onChanged: (value){
                      if (value.length == 9){
                        setState(() {
                          validate = true;
                        });
                      } else {
                        setState(() {
                          validate = false;
                        });
                      }
                    },
                    maxLength: 9,            
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.white),
                    controller: phoneNumberController,
                    autofocus: true,                    
                    decoration:  new InputDecoration(
                      counterStyle: TextStyle(color:Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color.fromARGB(255, 105, 211, 240), width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color:Color.fromARGB(255, 3, 110, 232), width: 1.0),
                      ),
                      hintText: 'Numéro de téléphone',
                      hintStyle: TextStyle(fontSize: 14, color: Color.fromARGB(255, 113, 113, 113))
                    ),
                  )
                )
              ]
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
           color: validate ? Color.fromARGB(255, 3, 110, 232): Colors.grey,
        ),
        child: AbsorbPointer(
          absorbing: validate ? false : true,
          child: MaterialButton(
            elevation: 2.0,
            onPressed: () {

              String numero  = '${indicateurPaysController.text}${phoneNumberController.text}';             

              _service.verifyPhoneNumber(context, numero);     

              Fluttertoast.showToast(msg: "Chargement...");
              
            },
            child: Text("Suivant",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,color: Colors.white)
            )
          ),
        ),
      ),
    )
    );
  }
}