import 'package:flutter/material.dart';
import 'package:nirvana/bookAppointment.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/patientChat.dart';
import 'package:nirvana/patientChatForm.dart';
import 'package:nirvana/profile.dart';
import 'package:nirvana/services/auth.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/signin.dart';
import 'package:nirvana/widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthMethods authMethods=AuthMethods();
  bool chatsExist;
  DatabaseMethods databaseMethods=DatabaseMethods();
  @override
  void initState() {
   show();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              print('${HelperFunction.getUserLoggedInState().toString()}This is logged in state from signout');
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
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height-100,
          padding: EdgeInsets.symmetric(horizontal: 10.0,),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/homeScreen_icon.png',),
              Image.asset('assets/images/logo_text.png'),
SizedBox(height:16),
              Text(
                  "We Are Here To Help You",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Cookie',
                ),
              ),
              Column(
                children: [

              SizedBox(height: 16.0,),

              GestureDetector(
                onTap:()async{
                   var x=await databaseMethods.checkConsultationStatus();
                   setState(() {
                     chatsExist=x!=null;
                     print(chatsExist);
                   });
                  chatsExist
                      ?Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientChatForm()))
                  :Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientChat()));
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
                  child: Text("Online consultation with a psycologist",style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),),

                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BookAppointments()));

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
                  child: Text("Book an Appointment for offline Consultation",style: TextStyle(
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

                ],
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      )
    );
  }

  show()async{
    print("show is called");
    var x;
    await databaseMethods.checkConsultationStatus();
    print("show is called1");
    print("$x uuu");
    setState(() {
      chatsExist=x!=null;

    });
  }
}
