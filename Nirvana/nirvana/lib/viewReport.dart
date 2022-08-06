import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/widgets/widget.dart';
class ViewReport extends StatefulWidget {
  final String id;
  final String name;
  ViewReport(this.id,this.name);
  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
  DatabaseMethods databaseMethods=DatabaseMethods();
  String message;
  @override
  void initState() {
    getInfo();
    super.initState();
  }

  getInfo()async{
    await databaseMethods.LoadReport(widget.name,widget.id).then((val){
      setState(() {
        message=val.get('report');
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body:Container(
        margin: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text('${widget.id}',style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              )),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.blueGrey,
                  ),
                  child: Text(message, style:TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  )),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
