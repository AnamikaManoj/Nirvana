import 'package:flutter/material.dart';
import 'package:nirvana/addReport.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/viewReport.dart';
import 'package:nirvana/widgets/widget.dart';

class Report extends StatefulWidget {
  final String name;
  Report(this.name);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  DatabaseMethods databaseMethods=DatabaseMethods();
  Stream ReportStream;



  Widget ChatList(){
    return ReportStream!=null?StreamBuilder(
        stream: ReportStream,
        builder: (context,snapshot){
          return snapshot.hasData? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                return ChatListTile(snapshot.data.docs[index].id,widget.name);
              }):Container();
        }):Container();
  }

  getUserInfo()async{

    await databaseMethods.LoadReportList(widget.name).then((val){
      setState(() {
        ReportStream=val;
        print('done');
      });
    });
  }
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body:ReportStream!=null?Container(
        margin: EdgeInsets.all(24),
      child: Stack(
        children: [
   ChatList(),//Center(child: Text('Your chats will be displayed here',style: TextStyle(color: Colors.white,fontSize: 17),)),//ChatList(),

   if(Constants.userType=='doctor')
     Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(right: 20,bottom: 30),
      child: FloatingActionButton(
        //creating a search option to connect to a person using username
      child: Icon(Icons.note_add),
      onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddReport(widget.name)));
      },
      ),
    )],
      ),


    ):Container());
  }

}

class ChatListTile extends StatelessWidget {
  final String title;
  final String uname;
  ChatListTile(this.title,this.uname);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewReport(title,uname)));
            },
            child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),

                color: Color(0xff006064),
              ),
              child:
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                child:Row(
                  children: [
                    Text(title,style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    )
                    ),
                  ],
                ),

              ),
            )
        ),
        SizedBox(height: 1,)
      ],
    );
  }
}
