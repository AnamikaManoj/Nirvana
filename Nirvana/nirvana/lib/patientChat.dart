import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:nirvana/chatroom.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/widgets/widget.dart';
class PatientChat extends StatefulWidget {

  @override
  _PatientChatState createState() => _PatientChatState();
}

class _PatientChatState extends State<PatientChat> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  DatabaseMethods databaseMethods=DatabaseMethods();
  var selectedCity;
  var selectedDoc;
  QuerySnapshot snapshot;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Form(
          key: _formKey,
          child: Container(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical:8),
              children: [
                SizedBox(height: 250,),
                Text("Select your Counselor",style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Cookie',
                ),
                  textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Doctors')
                      .where('status',isEqualTo: 'Verified')
                      .snapshots(),
                  builder: (context,snapshot){
                    List<DropdownMenuItem> city=[];
                    if(snapshot.hasData){
                      for(int i=0;i<snapshot.data.docs.length;i++){
                        var snap=snapshot.data.docs[i].get('city');
                        print(snap);
                        city.add(
                            DropdownMenuItem(
                              child: Text
                                (snap,style: TextStyle(color: Colors.black),),
                              value: '${snap}',
                            )
                        );
                        // print('${snap}');
                      }
                    }


                    return DropdownButton(
                      dropdownColor: Colors.blueGrey,

                      items: city,
                      value: selectedCity,
                      onChanged: (val){
                        setState(() {
                          selectedCity=val;
                          print(selectedCity);
                          print("Entered dropdown city");

                        });
                      },
                      isExpanded: true,
                      hint: Text('Select City',style: TextStyle(color: Colors.white),),
                    );

                  },
                ),

                SizedBox(height: 8,),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Doctors').where('city',isEqualTo: selectedCity)
                  .where('status',isEqualTo: 'Verified')
                      .snapshots(),
                  builder: (context,snapshot){
                    List<DropdownMenuItem> doc=[];
                    if(snapshot.hasData){
                      for(int i=0;i<snapshot.data.docs.length;i++){
                        var snap=snapshot.data.docs[i].get(('name'));
                        doc.add(
                            DropdownMenuItem(
                              child: Text
                                (snap,style: TextStyle(color: Colors.black),),
                              value: '${snap}',
                            )
                        );
                        // print('${snap}');
                      }
                    }

                    return DropdownButton(
                      dropdownColor: Colors.blueGrey,

                      items: doc,
                      value: selectedDoc,
                      onChanged: (val){
                        setState(() {
                          selectedDoc=val;
                          print(selectedDoc);
                          print("Entered dropdown");

                        });
                      },
                      isExpanded: true,
                      hint: Text('Select Doctor',style: TextStyle(color: Colors.white),),
                    );

                  },
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap:(){
                    CreatechatRoomApp(selectedDoc);
                    databaseMethods.updateDoc(selectedDoc);
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
                    child: Text("Continue",style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),),

                  ),
                ),
              ],
            ),
          ),
        ),

      )
    );
  }

  CreatechatRoomApp(String username){

    String ChatRoomId=getChatRoomId(username,Constants.myName);
    List<String> users=[username,Constants.myName];

    Map<String,dynamic> chatRoomMap = {
      "Users":users,
      "chatRoomId":ChatRoomId,
    };
    DatabaseMethods().createChatRoomdb(ChatRoomId, chatRoomMap);
    HelperFunction.saveSearchUser(username);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoom(ChatRoomId,username)));
  }



  getChatRoomId(String a,String b){
    print(HelperFunction.getUserName().toString());
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0))
      return '$b\_$a';
    else
      return'$a\_$b';
  }
}
