import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nirvana/deleteAccount.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/managePassword.dart';
import 'package:nirvana/services/auth.dart';
import 'package:nirvana/widgets/widget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: appBarMain(context),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Image.asset('assets/images/homeScreen_icon.png',),
            Text(Constants.myName,style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontFamily: 'Cookie'
            ),),
            SizedBox(height:16),

            Column(
              children: [

                SizedBox(height: 16.0,),

                GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagePassword()));
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
                    child: Text("Manage Password",style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),),

                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteAccount()));

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
                    child: Text("Delete My Account",style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),),
                  ),
                ),
                  ],
                ),
    ],
                ),
    ),
        )
    );
  }
}
