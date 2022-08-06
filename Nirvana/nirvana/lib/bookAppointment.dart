import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/home.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/widgets/widget.dart';

class BookAppointments extends StatefulWidget {
  @override
  _BookAppointmentsState createState() => _BookAppointmentsState();
}

class _BookAppointmentsState extends State<BookAppointments> {
  DateTime currentDate=DateTime.now();
  TimeOfDay currentTime=TimeOfDay.now();
  String selectedDoc;
  DatabaseMethods databaseMethods=DatabaseMethods();
  FToast fToast;
  List<String> slots=['Slot 1','Slot 2','Slot 3','Slot 4'];
  String slot;
  DocumentSnapshot snapshot,timeSnaps;
  String p,q,r,s;
  List<String> abc=[];
 var snap;

  @override
  void initState() {

    super.initState();
    fToast = FToast();
    fToast.init(context);
    //pickedDate=DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: appBarMain(context),
        body:SingleChildScrollView(

          //height: MediaQuery.of(context).size.height,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
            child:Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: 100,),
                ListTile(
                  title: Text('Appointment Booking Details ',style: TextStyle(fontSize: 17,color: Colors.white)),
                ),

                ListTile(
                  title: Text("Select Appointment Date",style: TextStyle(fontSize: 17,color: Colors.white),),
                  trailing: Icon(Icons.arrow_drop_down,color: Colors.white,),
                  onTap: () {
                    
                  _selectDate(context);
                  }
                ),
                ListTile(
                  title: Text('${currentDate.day}/${currentDate.month}/${currentDate.year} ',style: TextStyle(fontSize: 17,color: Colors.white)),
                ),
            ListTile(
              title: Text("Select Your Counselor",style: TextStyle(fontSize: 17,color: Colors.white,


              ),),),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Doctors')
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
                                  ('Dr.$snap',style: TextStyle(color: Colors.black),),
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
                            fun(selectedDoc);
                            LoadSlots();
                          });
                        },
                        isExpanded: true,
                        hint: Text('Select Doctor',style: TextStyle(color: Colors.white),),
                      );

                    },
                  ),
                ),
                ListTile(
                  title: selectedDoc!=null?Text('Dr.$selectedDoc',style: TextStyle(fontSize: 17,color: Colors.white)):Text(''),
                ),
                ListTile(
                  title: Text("Select Appointment Time Slot",style: TextStyle(fontSize: 17,color: Colors.white,


                  ),),

                ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 15),
                //   child:DropdownButton(
                //     items: abc.map((value)=>DropdownMenuItem(
                //       child: Text(value,
                //           style:TextStyle(fontSize: 17)
                //       ),
                //       value: value,
                //     )).toList(),
                //
                //     hint:slot==null?Text('Select your Slot',style: TextStyle(color:Colors.white,fontSize: 17)):
                //     Text(slot,style: TextStyle(color:Colors.white,fontSize: 17)),
                //     dropdownColor: Colors.blueGrey,
                //     isExpanded: true,
                //     onChanged: (val) {
                //       setState(() {
                //         slot = val;
                //         fun(selectedDoc);
                //       });
                //     }),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('TimeSlots')
                        .doc(selectedDoc)
                        .collection('${currentDate.day}.${currentDate.month}.${currentDate.year} ')
                        .where('status',isEqualTo: 'Unbooked')
                        .snapshots(),
                    builder: (context,snapshot){
                      List<DropdownMenuItem> doc=[];
                      if(snapshot.hasData){
                        for(int i=0;i<snapshot.data.docs.length;i++){
                          var snap=snapshot.data.docs[i].get(('slot'));
                          doc.add(
                              DropdownMenuItem(
                                child: Text
                                  ('$snap',style: TextStyle(color: Colors.black),),
                                value: '${snap}',
                              )
                          );
                          // print('${snap}');
                        }
                      }

                      return DropdownButton(

                        dropdownColor: Colors.blueGrey,
                        items: doc,
                        value: slot,
                        onChanged: (val){
                          setState(() {
                            slot=val;
                            print(slot);
                            print("Entered dropdown");

                          });
                        },
                        isExpanded: true,
                        hint: Text('Select Appointment time',style: TextStyle(color: Colors.white),),
                      );

                    },
                  ),
                ),
                ListTile(
                  title: Text(show(slot),style: TextStyle(fontSize: 17,color: Colors.white)),
                ),

                SizedBox(height: 16,),
                GestureDetector(
                  onTap:(){
                    book();
                    fToast.showToast(
                        child:Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.blueGrey.shade50,
                          ),child:Text('Appointment Booked Successfully\n'
                            '${currentDate.day}/${currentDate.month}/${currentDate.year} at ${show(slot)}',style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,

                        ),) , ));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(),));
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
                    child: Text("Book an Appointment",style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),),

                  ),
                ),
              ],
            )
          ),
        ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }
  setTime(){
    String hr,mm;
    if(currentTime.hour.toInt().toString().length==1){
      print('hr:${currentTime.hour.bitLength}');
      hr='0${currentTime.hour}';
      print(hr);
    }

    else{
      hr='${currentTime.hour}';
    print(hr);}
    if(currentTime.minute.toInt().toString().length==1){
      mm='0${currentTime.minute}';
    print(mm);}
    else
      mm='${currentTime.minute}';
    return '${hr}:${mm}';
    }
  book(){
Map <String,dynamic> details={
  "date":'${currentDate.day}/${currentDate.month}/${currentDate.year} ',
  "date1":currentDate,
  "time":show(slot),
  "doctor":selectedDoc,
  "patientName":Constants.myName
};
databaseMethods.uploadAppointment(details);
FirebaseFirestore.instance.collection('TimeSlots')
    .doc(selectedDoc)
    .collection('${currentDate.day}.${currentDate.month}.${currentDate.year} ')
    .doc(slot)
.update({'status':'Booked'});

  }
  fun(name)async{


    snapshot=await FirebaseFirestore.instance.collection("Doctors")
        .doc(name).collection('TimeSlots').doc('slots').get();
    setState(() {
      p = snapshot.get('slot1');
      q = snapshot.get('slot2');
      r = snapshot.get('slot3');
      s = snapshot.get('slot4');
    });
    abc.addAll([p,q,r,s]);
    print('${abc} s is printed');
    return s;
  }

  show(val){
    if(val=='Slot 1')
      return p;
    else if(val=='Slot 2')
      return q;
    else if(val=='Slot 3')
      return r;
    else if(val=='Slot 4')
      return s;
    else
      return'';
  }

  LoadSlots()async{
    timeSnaps=await FirebaseFirestore.instance.collection('TimeSlots')
        .doc(selectedDoc)
        .collection('${currentDate.day}.${currentDate.month}.${currentDate.year} ')
        .doc('Slot 1')
        .get();
    if(!timeSnaps.exists){
      for(int i=1;i<5;i++){
        FirebaseFirestore.instance.collection('TimeSlots')
            .doc(selectedDoc)
            .collection('${currentDate.day}.${currentDate.month}.${currentDate.year} ')
            .doc('Slot $i')
            .set({'slot':'Slot $i','status':'Unbooked'});
        print("Created");
      }
    }
// abc.clear();
//       snap=await FirebaseFirestore.instance.collection('TimeSlots')
//           .doc(selectedDoc)
//           .collection('${currentDate.day}.${currentDate.month}.${currentDate.year} ')
//           .where('status',isEqualTo: 'Unbooked')
//       .get().then((value) {
//         int len;
//         len=value.docs.length;
//         for(int i=0;i<len;i++){
//           String a= value.docs[i].get('slot');
//           abc.add(a);
//           print(a);
//         }
//         print(abc);
//       });



  }
}


