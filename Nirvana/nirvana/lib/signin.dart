//import 'dart:html';
//import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nirvana/chatList.dart';
import 'package:nirvana/depressionForm.dart';
import 'package:nirvana/docHome.dart';
import 'package:nirvana/forgetpassword.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/home.dart';
import 'package:nirvana/services/auth.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/signup.dart';
import 'package:nirvana/widgets/widget.dart';

import 'helper/helperfunction.dart';

class Signin extends StatefulWidget {


  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {


  bool isLoading=false;
  final  formKey=GlobalKey<FormState>();
  DatabaseMethods databaseMethods=DatabaseMethods();
  AuthMethods authMethods=AuthMethods();
  QuerySnapshot snapshot;
  FToast fToast;
var status;

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();





  SignMeIn(){


    if(formKey.currentState.validate()){    //if validation is true
      HelperFunction.saveUserEmail(email.text);   //saving the email of user who is logging in
      setState(() {
        isLoading=true;   //loading screen is visible
      });

      setState(() {
        Constants.userEmail=email.text;
      });


        authMethods.signInWithEmailAndPass(email.text, password.text).then((value){   //authenticating user
          if (value!=null){
            HelperFunction.saveUserLoggedInState(true);
            print("authmethods works perfectly");

          // User();

            databaseMethods.getUserbyMail(email.text)    //calling this function to retrieve data from database about the username
                .then((val) {

                    if(val!=null) {
                      snapshot = val; //snapshot will have the documents
                      String name=snapshot.docs[0].get('name');
                                    HelperFunction.saveUserName(name); //the name is retrieved and stored in sharedPreference
                      setState(() {
                        Constants.myName=name;
                      });
                                       var userType=snapshot.docs[0].get('type') ;
                                       HelperFunction.saveUserType(userType);
        setState(() {
         Constants.userType=userType;

        });
        setState(() {
          Constants.userEmail=email.text;
        });
        userType=='doctor'?Doctor():User();
                    }else
                      print("Val is null");
              });
          }else{
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

          }
        });



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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 10.0,),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 150,),
              Image.asset('assets/images/Nirvana_logo.png'),
             Form(
               key: formKey,
               child: Column(
                 children: [
                   TextFormField(
                     validator: (val) {
                       return RegExp(
                           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                           .hasMatch(val)
                           ? null
                           : "Please Enter Correct Email";
                     },
                     controller: email,
                     style: SimpleTextstyle(),
                     decoration: decor('Email'),
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
              SizedBox(height: 8.0,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ForgotPassword(),));
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                    child: Text("Forgot Password?",style: SimpleTextstyle(),),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap:(){
                  SignMeIn();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
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

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    'Dont Have an Account? ',
                    style: SimplesTextstyle(),
                  ),
                  GestureDetector(
                    onTap:(){
                       isLoading=true;
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signup(),));
                    },child: Text(
                          'Register Now',
                          style:
                       TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      )
    );
  }
User(){
  HelperFunction.saveUserType('user');
  Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) =>
          Home()));
}
Doctor(){

    HelperFunction.saveUserType('doctor');
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>DocHome()));
}

}
