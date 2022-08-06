import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/widgets/widget.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {

  DatabaseMethods databaseMethods=DatabaseMethods();
  QuerySnapshot searchsnapshot;

  @override
  void initState() {
    LoadAppointments();//retrieve data when this page is opened
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body:Column(
        children: [
          Text("Upcoming Appointments",style: TextStyle(color: Colors.white,
              fontSize: 30,
              fontFamily: 'Cookie')),
          SizedBox(height: 20),
          SearchList(),
        ],
      )//
    );
  }

  Widget SearchList(){
    return searchsnapshot!=null? ListView.builder(
      itemCount:searchsnapshot.docs.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        return SearchTile(
          patientName: searchsnapshot.docs[index].get('patientName'),
          time: searchsnapshot.docs[index].get('time'),
          date: searchsnapshot.docs[index].get('date')
        ) ;
      },
    ):Container(

      child:
      Text('No upcoming appointments',
        style: TextStyle(color: Colors.white,
            fontSize: 24,
            fontFamily: 'Cookie'),
      ),
    );
  }

  Widget SearchTile({String patientName,String time,String date}){

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xff006064),
          ),

          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(patientName,style:TextStyle(
                  color: Colors.white,
                  fontSize: 24
              )),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Text(time,style:TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  )),
                  Spacer(),//SizedBox(width: 50,),
                  Text(date,style:TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  )),
                ],
              ),
            ],
          ),
        ),SizedBox(height: 1,)
      ],
    );
  }

  LoadAppointments()async{
   await databaseMethods.getAppointments(Constants.myName).then((val){
      setState(() {
        searchsnapshot=val;
        print(searchsnapshot);
      });
    });
  }
}
