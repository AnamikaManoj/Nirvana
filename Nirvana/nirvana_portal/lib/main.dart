import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nirvana_portal/Sign_in.dart';
import 'package:nirvana_portal/helperfunction.dart';
import 'package:nirvana_portal/homePortal.dart';

Future<void> main() async{
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
  @override
  void initState() {
    getLoginStatus();
    super.initState();
  }

  getLoginStatus() async {
    await HelperFunction.getUserLoggedInState().then((val){
      loginState=val;
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
      home: loginState !=null?/**/loginState? HomePortal():Signin():Signin(),
    );

  }
}

