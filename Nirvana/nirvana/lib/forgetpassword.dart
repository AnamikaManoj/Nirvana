import 'package:flutter/material.dart';
import 'package:nirvana/services/auth.dart';
import 'package:nirvana/signin.dart';
import 'package:nirvana/widgets/widget.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState>  formKey=GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  AuthMethods authMethods=AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please enter your registered email ID to receive a reset password link.',style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),textAlign: TextAlign.justify,),
              TextFormField(
                validator: (val) {
                  return RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val)
                      ? null
                      : "Please Enter Correct Email";;
                },
                controller: email,
                style: SimpleTextstyle(),
                decoration: decor('Email'),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap:(){
                  authMethods.resetPass(email.text);
                  createDialog(context);
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
                  child: Text("Reset Password",style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  createDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Successful'),
        content: Text('A password reset link has been sent to your mail'),
        actions: [
          MaterialButton(
            child:Text('OK',style: TextStyle(color: Colors.white)),
            onPressed:(){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signin()));}, //UploadDetails(),
          )
        ],
        backgroundColor: Colors.blueGrey,
      );
    });
  }
}
