import 'package:flutter/material.dart';
import 'package:nirvana/appointments.dart';
import 'package:nirvana/chatList.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/profile.dart';
import 'package:nirvana/services/auth.dart';
import 'package:nirvana/signin.dart';
import 'package:nirvana/widgets/widget.dart';

class DocHome extends StatefulWidget {
  @override
  _DocHomeState createState() => _DocHomeState();
}

class _DocHomeState extends State<DocHome> {
  AuthMethods authMethods=AuthMethods();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Row(
            children: [

              Image.asset('assets/images/Nirvana_logo.png',height: 60.0,),
              Image.asset('assets/images/logo_text.png'),
            ],
          ),
          backgroundColor: Color(0xff145C8D),
          actions: [

            GestureDetector(
              onTap: (){
                authMethods.signOut();
                HelperFunction.saveUserLoggedInState(false);
                HelperFunction.saveUserName('');
                HelperFunction.saveUserType("");
                print('${HelperFunction.getUserLoggedInState()}This is logged in state from signout');
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Signin()),(Route<dynamic> route)=>false);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.exit_to_app_sharp,size: 30,),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height-100,
            padding: EdgeInsets.symmetric(horizontal: 10.0,),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/homeScreen_icon.png',),
                Image.asset('assets/images/logo_text.png'),
                SizedBox(height: 16,),
                Text(
                  "Together We Can Change The World",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Cookie',
                  ),
                ),
                Column(
                  children: [

                    SizedBox(height: 16.0,),

                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Chats()));
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
                        child: Text("Goto Chats",style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),),

                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Appointments()));
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
                        child: Text("View Upcoming Appointments",style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),),
                      ),
                    ),
                    SizedBox(height: 20,),

                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
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
                        child: Text("Goto your Profile",style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),),
                      ),
                    ),

                    SizedBox(height: 20,),
                  ],
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        )
    );
  }
}
