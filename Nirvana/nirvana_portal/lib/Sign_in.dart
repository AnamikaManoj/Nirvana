//import 'dart:html';
//import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nirvana_portal/helperfunction.dart';
import 'package:nirvana_portal/homePortal.dart';
import 'package:nirvana_portal/widget.dart';



class Signin extends StatefulWidget {


  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {


  bool isLoading=false;
  final  formKey=GlobalKey<FormState>();
  QuerySnapshot snapshot;
  FToast fToast;

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();



  SignMeIn(){


    if(formKey.currentState.validate()){    //if validation is true
      setState(() {
        isLoading=true;   //loading screen is visible
      });

      if(email.text=='admin@nirvana'&&password.text=='root1234') {
        HelperFunction.saveUserLoggedInState(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>
                HomePortal()));
      }
        else{
          print("No record found from database");
          fToast.showToast(
              child:Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.blueGrey,
                ),child:Text('Invalid Credentials',style: TextStyle(
                fontSize: 24,
                color: Color(0xffc20000),
              ),) , ));

        };


    }
  }
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: appBarMain(context),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(

            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: 10.0,),

            child: Column(
              // mainAxisSize: MainAxisSize.min,

              children: [
                SizedBox(height: 150,),
                Image.asset('assets/images/Nirvana_logo.png'),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty
                              ? "Please Enter username"
                              : null;
                        },
                        controller: email,
                        style: SimpleTextstyle(),
                        decoration: decor('UserName'),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val) {
                          return val.isEmpty || val.length < 8
                              ? "Enter a password with minimum of 8 characters"
                              : null;
                        },
                        controller: password,
                        style: SimpleTextstyle(),
                        decoration: decor('Password'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                GestureDetector(
                  onTap:(){
                    SignMeIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 500,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xff007EF4),
                            const Color(0xff2A75BC)
                          ]
                      ),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Text("Sign In",style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),),

                  ),
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        )
    );
  }
}
