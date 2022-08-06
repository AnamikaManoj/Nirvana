import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nirvana_portal/Doctors.dart';
import 'package:nirvana_portal/helperfunction.dart';
import 'package:nirvana_portal/widget.dart';

import 'Sign_in.dart';

class HomePortal extends StatefulWidget {
  @override
  _HomePortalState createState() => _HomePortalState();
}





class _HomePortalState extends State<HomePortal> {
  FToast fToast;
Stream stream;



  @override
  void initState() {
    load();
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
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
              HelperFunction.saveUserLoggedInState(false);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Signin()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.exit_to_app_sharp,size: 30,),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
         margin: EdgeInsets.all(16),
child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
         SizedBox(height:630,child: DocList(),),
    GestureDetector(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Doctors()));
        },
        child:  Container(
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
            child: Text("View All Doctors",style: TextStyle(
              fontSize: 17,
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
  Widget DocList() {
    return StreamBuilder(
        stream: stream,
        builder: (context,snapshot){
          return snapshot.hasData? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                return DocListTile(snapshot.data.docs[index].get('name'),snapshot.data.docs[index].get('regdno'));
              }):Container(
            child: Text("Everyone is verified",style: TextStyle(color: Colors.white,fontFamily: 'Cookie',fontSize: 20),),
          );
        });
  }
  DocListTile (userName,Id){

    return Container(
      color: Colors.black26,
      child: Container(
        decoration:BoxDecoration(
            color: Color(0xff006064),
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        padding: EdgeInsets.all(10),

        child:Row(
          children: [

            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Colors.white30
              ),
              child: Text('${userName.substring(0,1).toUpperCase()}',style: TextStyle(
                fontSize: 30,
                //fontWeight: FontWeight.bold,,
                fontFamily: 'Cookie',
              ),),),

            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName,style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),),
                SizedBox(height: 10,),
                Text('Regd.no: ${Id}',style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                ),),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                FirebaseFirestore.instance.collection('Doctors')
                    .doc(userName)
                    .update({'status':'Verified'});
                fToast.showToast(
                    child:Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blueGrey.shade50,
                      ),child:Text('The Profile is Verified',style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,

                    ),) , ));
                print("verified");
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.green,
                  ),
                  child: Icon(Icons.verified_sharp)),
            ),
            SizedBox(width: 2,),
            GestureDetector(
              onTap: (){
                FirebaseFirestore.instance.collection('Doctors')
                    .doc(userName)
                    .update({'status':'Unverified'});
                fToast.showToast(
                    child:Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blueGrey.shade50,
                      ),child:Text('The Profile is Unverified',style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,

                    ),) , ));
                print("Unverified");
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color(0xffc20007),
                  ),
                  child: Icon(Icons.clear,)),
            ),
            SizedBox(height: 1)
          ],
        ),
      ),
    );
  }
  load()async{
   var val= await FirebaseFirestore.instance.collection('Doctors').where('status',isEqualTo: '')
        .snapshots();
   setState(() {
     stream=val;
   });
  }
}

