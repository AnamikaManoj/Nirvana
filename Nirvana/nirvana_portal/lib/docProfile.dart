import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nirvana_portal/widget.dart';

class DocProfile extends StatefulWidget {
  final String name;
  DocProfile(this.name);
  @override
  _DocProfileState createState() => _DocProfileState();
}

class _DocProfileState extends State<DocProfile> {
  DocumentSnapshot snap;
  var email="",hospital="",phone="",position="",regdno="",status="",city="";
  FToast fToast;
  @override
  void initState() {
    LoadData();
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  LoadData()async{
    await FirebaseFirestore.instance.collection('Doctors')
        .doc(widget.name)
        .get().then((value) {
          setState(() {
            snap=value;
          });
          AssignVal();
    });
  }

  AssignVal(){
    snap!=null?
    setState(() {
      email=snap.get('email');
      hospital=snap.get('hospital');
      phone=snap.get('phone');
      position=snap.get('position');
      regdno=snap.get('regdno');
      status=snap.get('status');
      city=snap.get('city');
    }):null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarMain(context),
      body:Column(
        children: [
          Image.asset('assets/images/Nirvana_logo.png'),
          SizedBox(height: 16,),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            color: Colors.blueGrey,),
            child:Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Text(widget.name,style: TextStyle(fontSize: 24),)),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Phone',style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text('Email',style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text('Currently Working at',style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text('City',style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text('Position',style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text('Regd. No',style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text('Status',style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(":",style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(":",style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(":",style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(":",style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(":",style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(":",style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(":",style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(phone,style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(email,style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(hospital,style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(city,style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(position,style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(regdno,style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),
                          Text(status,style: TextStyle(fontSize: 17),),
                          SizedBox(height: 16),

                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Change Status",style: TextStyle(fontSize: 17),),
                      Spacer(flex: 1,),
                      GestureDetector(
                        onTap: (){
                          FirebaseFirestore.instance.collection('Doctors')
                              .doc(widget.name)
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
                            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                            alignment: Alignment.center,
                            //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.green,
                            ),
                            child: Text("Verify",style: TextStyle(fontSize: 17),)),
                      ),
                      SizedBox(width: 2,),
                      GestureDetector(
                        onTap: (){
                          FirebaseFirestore.instance.collection('Doctors')
                              .doc(widget.name)
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
                            child: Text("Unverify",style: TextStyle(fontSize: 17),),),
                      ),
                      Spacer(flex: 3,),
                    ],
                  )
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}
