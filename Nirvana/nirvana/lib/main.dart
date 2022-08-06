import 'package:flutter/material.dart';
import 'package:nirvana/bookAppointment.dart';

import 'package:nirvana/chatList.dart';

import 'package:nirvana/depressionForm.dart';
import 'package:nirvana/docHome.dart';
import 'package:nirvana/doctorForm.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/patientChatForm.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/signin.dart';
import 'package:nirvana/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'file:///C:/Users/Danish/AndroidStudioProjects/nirvana/lib/home.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loginState;
  String name;
  String type;


  @override
  void initState() {
    getLoginStatus();
    getUserType();
    getUserName();

    super.initState();
  }

  getLoginStatus() async {
    await HelperFunction.getUserLoggedInState().then((val){
      loginState=val;
    });
  }

  getUserType()async{
    await HelperFunction.getUserType().then((value) {
      Constants.userType=value;
    });
  }

  getUserName()async{
    await HelperFunction.getUserName().then((val){
      Constants.myName=val;
    });
  }

  @override
  Widget build(BuildContext context) {
   // print(Constants.myName+','+Constants.userType);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/root':(context)=>Signup()
      },
      home: loginState !=null?/**/loginState? Constants.userType=='doctor'?DocHome():Home():Signin()/**/:Signin (),
    );

  }
}

