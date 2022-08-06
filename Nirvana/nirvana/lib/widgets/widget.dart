import 'package:flutter/material.dart';
Widget appBarMain(BuildContext context){
  return AppBar(
    title: Row(
      children: [
        Image.asset('assets/images/Nirvana_logo.png',height: 60.0,),
        Image.asset('assets/images/logo_text.png'),
      ],
    ),
    backgroundColor: Color(0xff145C8D),
  );
}
InputDecoration decor(String hint){
  return  InputDecoration(
     // hintText:'Enter ${hint}',
      labelText:hint ,
      labelStyle: TextStyle(
        color: Colors.white,

      ),
      hintStyle: TextStyle(

        color: Colors.white,
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white60)
      )
  );
}

TextStyle SimpleTextstyle(){
  return TextStyle(
color: Colors.white,
    fontSize: 16,
);
}
TextStyle SimplesTextstyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
}