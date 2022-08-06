
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nirvana/chatroom.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/patientChat.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/widgets/widget.dart';

class PatientChatForm extends StatefulWidget {
  @override
  _PatientChatFormState createState() => _PatientChatFormState();
}

class _PatientChatFormState extends State<PatientChatForm> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  DatabaseMethods databaseMethods=DatabaseMethods();
  var selectedCity;
  var selectedDoc;
  QuerySnapshot snapshot;
  bool chatsExist=true;
  var doctor;


  List  Doc;

@override
  void initState() {
    show();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarMain(context),
      body:Container(
        margin: EdgeInsets.all(20),
            child: Column(
       children:[
         GestureDetector(
              onTap: (){
                String ChatRoomId=getChatRoomId(doctor,Constants.myName);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoom(ChatRoomId,doctor)));
              },
              child:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),

                  color: Color(0xff006064),
                ),
                child:
                Container(

                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  child:Row(
                    children: [

                      Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.white30,
                        ),
                        child:doctor!=null? Text('${doctor.substring(0,1).toUpperCase()}',style: TextStyle(
                          fontSize: 30,
                          //fontWeight: FontWeight.bold,,
                          fontFamily: 'Cookie',
                        ),):Text("_")),

                      SizedBox(width: 8.0),
                      doctor!=null?Text(doctor,style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      )
                      ):Text("_"),
                    ],
                  ),

                ),
              )
        ),
        Spacer(),
         GestureDetector(
             onTap:(){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PatientChat()));
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
               child: Text("Change your Counsellor",style: TextStyle(
                 fontSize: 17,
                 color: Colors.white,
               ),),

             ),
         ),


     ] ),
          ));

  }

  getChatRoomId(String a,String b){
    print(HelperFunction.getUserName().toString());
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0))
      return '$b\_$a';
    else
      return'$a\_$b';
  }

  show()async{
   var x=await databaseMethods.checkConsultationStatus();
   setState(() {
     chatsExist=x==null;
     doctor=x;
   });
  }


}
