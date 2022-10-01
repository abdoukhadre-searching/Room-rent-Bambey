import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final String cheminIcone;
  final Color colorBg;
  final Color colorText;
  
  const ButtonCustom({required this.colorText,required this.text, required this.colorBg,required this.cheminIcone,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorBg
        ),
        child: MaterialButton(
          elevation: 2.0,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(cheminIcone),
              SizedBox(width: 15),
              Text(text,style: TextStyle(fontFamily: 'Ubuntu',fontSize: 16, fontWeight: FontWeight.bold ,color: colorText))
            ],
          )
        ),
      ),
    );
  }
}