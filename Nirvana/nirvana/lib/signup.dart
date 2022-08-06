import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nirvana/chatList.dart';
import 'package:nirvana/depressionForm.dart';
import 'package:nirvana/doctorForm.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/patientChatForm.dart';
import 'package:nirvana/services/auth.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/signin.dart';
import 'package:nirvana/widgets/widget.dart';
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {


  bool isLoading = false;
  QuerySnapshot res;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethod=DatabaseMethods();



  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEdittingController = TextEditingController();
  TextEditingController passwordTextEdittingController = TextEditingController();
  TextEditingController usernameTextEdittingController = TextEditingController();
  bool docCheck=false;
  bool isNameCheck=false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body:

          isLoading ? Container(
            alignment: Alignment.center,
              child: Center(child: CircularProgressIndicator())
          ) :SingleChildScrollView(
            child:
          Container(

            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(horizontal: 10.0,),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 100,),
                Image.asset('assets/images/Nirvana_logo.png'),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator:(val) {
                          namecheck(val);
                        },
                        controller: usernameTextEdittingController,
                        style: SimpleTextstyle(),
                        decoration: decor('UserName'),
                      ),
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)
                              ? null
                              : "Please Enter Correct Email";;
                        },
                        controller: emailTextEdittingController,
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
                        controller: passwordTextEdittingController,
                        style: SimpleTextstyle(),
                        decoration: decor('Password'),
                      ),
                    ],
                  ),
                ),
               Row(
                 children:[
                //SizedBox(width: 10,),
                Checkbox(

                  checkColor: Colors.blueGrey,
                  activeColor: Colors.black,
                  value: this.docCheck,
                  onChanged: (bool value) {
                    setState(() {
                      this.docCheck = value;
                    });
                  },
                ),
                Text('SignUp as a doctor ',style: TextStyle(fontSize: 18.0,color: Colors.white24), ),
                ]),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                   
       docCheck?
      signMeUpDoc() :
      signMeUp();

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
                    child: Text("Sign Up", style: TextStyle(
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
                      'Already Have an Account? ',
                      style: SimplesTextstyle(),
                    ),
                    GestureDetector(
                      onTap: (){
                        isLoading = true;
                       setState(() {
                         CircularProgressIndicator();
                       });
print('Working');
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context)=>Signin() // goto the signin page
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                          ),
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

  signMeUp() {

    if (formKey.currentState.validate()) {
      if (isNameCheck) {
        Map<String,String>userInfoMap= {
            "name":usernameTextEdittingController.text,
            "email":emailTextEdittingController.text,
            "type": "user",
          };
        
          HelperFunction.saveUserType('user');
          Constants.userType='user';
        
          String name=usernameTextEdittingController.text;
        
          HelperFunction.saveUserEmail(emailTextEdittingController.text);
          HelperFunction.saveUserName(usernameTextEdittingController.text);
          setState(() {
            Constants.myName=name;
          });
          setState(() {
            Constants.userEmail=emailTextEdittingController.text;
          });
          authMethods.signupWithEmailAndPass(
              emailTextEdittingController.text, passwordTextEdittingController.text)
              .then((val) {
            print("$val");
        
        
            setState(() {
              isLoading = true;
            });
        
            HelperFunction.saveUserLoggedInState(true);
            databaseMethod.uploadInfo(userInfoMap,usernameTextEdittingController.text);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=>DepressionForm(),// builder: (context)=>DepressionDetectionForm(),
            ));
          });
      }
    }
  }

  signMeUpDoc(){
    if (formKey.currentState.validate()) {
      if (isNameCheck) {
        Map<String,String>userInfoMap= {
          "name":usernameTextEdittingController.text,
          "email":emailTextEdittingController.text,
          "type":"doctor",
        };
        
        HelperFunction.saveUserType('doctor');
        Constants.userType='doctor';
        
        String name=usernameTextEdittingController.text;
        HelperFunction.saveUserEmail(emailTextEdittingController.text);
        HelperFunction.saveUserName(usernameTextEdittingController.text);
        setState(() {
          Constants.myName=name;
        });
        setState(() {
          Constants.userEmail=emailTextEdittingController.text;
        });
        authMethods.signupWithEmailAndPass(
            emailTextEdittingController.text, passwordTextEdittingController.text)
            .then((val) {
          print("$val");
        
        
          setState(() {
            isLoading = true;
          });
        
          HelperFunction.saveUserLoggedInState(true);
          databaseMethod.uploadInfo(userInfoMap,usernameTextEdittingController.text,);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=>DoctorForm(),
          ));
        });
      }
    }
  }


  namecheck(val)async{
    {

      return  val.isEmpty ? "Enter a Username" :
      await databaseMethod.searchUser(usernameTextEdittingController.text).then((value) {
       print('$value uuu');
       if (value!="") {
         return showDialog(context: context, builder: (context){
           return AlertDialog(
             title: Text(value),
             actions: [
               MaterialButton(
                 child:Text('OK',style: TextStyle(color: Colors.white)),
                 onPressed:(){
                   Navigator.pop(context);
                 } 
               )
             ],
             backgroundColor: Colors.blueGrey,
         
           );
         });
       }else
         setState(() {
           isNameCheck=true;
         });
      });
      // return mes;

     }


  }
}