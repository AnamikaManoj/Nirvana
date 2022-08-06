import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nirvana_portal/docProfile.dart';
import 'package:nirvana_portal/widget.dart';

class Doctors extends StatefulWidget {
  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  Stream stream;

  @override
  void initState() {
    print(stream);
    load();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarMain(context),
      backgroundColor: Colors.black,
      body:stream==null?Container():Container(
        margin:EdgeInsets.all(16),
          child:DocList()
      )
    );
  }
  Widget DocList(){
    return StreamBuilder(
        stream: stream,
        builder: (context,snapshot){

          return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                return DocListTile(snapshot.data.docs[index].get('name'));
              }):Container(
            child: Text("",style: TextStyle(color: Colors.white,fontFamily: 'Cookie',fontSize: 20),),
          );
        });
  }

  DocListTile (userName){

    return Column(
      children: [
        Container(
          color: Colors.black26,
          child: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DocProfile(userName)));
            },
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

                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 1)
      ],
    );
  }

  load()async{
    var val;
    val=await FirebaseFirestore.instance.collection('Doctors')
        .snapshots();
    setState(() {
      stream=val;
      print(stream);
    });
  }
}
