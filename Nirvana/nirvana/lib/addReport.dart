

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/viewReport.dart';
import 'package:nirvana/widgets/widget.dart';
class AddReport extends StatefulWidget {
  final String name;
  AddReport(this.name);
  @override
  _AddReportState createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  final _formKey = GlobalKey<FormState>();
  DateTime date=DateTime.now();
  DatabaseMethods databaseMethods=DatabaseMethods();
  TextEditingController report=TextEditingController();
  FToast fToast;
  var title;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    title='${date.day}.${date.month}.${date.year}';
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),

            child:Form(
                key:_formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,style: TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  ),),
                  TextFormField(
                    controller: report,
                    style: SimpleTextstyle(),
                    decoration: InputDecoration(
                      hintText:'Enter your message...',

                        labelStyle: TextStyle(
                          color: Colors.white,

                        ),
                        hintStyle: TextStyle(

                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:BorderSide.none
                        ),
                        border:OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        )

                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 30,
                    maxLines: null,

                  ),
                  GestureDetector(
                    onTap:(){
                      UploadDoc();
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
                      child: Text("Add Report",style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),),

                    ),
                  ),

                ],
              ),
            )

          ),

      ),
    );
  }

  UploadDoc(){
    if (report.text.isNotEmpty){
      Map<String,String>userMap= {
        "doctor":Constants.myName,
        "date":title,
        "report":report.text,
      };
      databaseMethods.UploadReport(userMap, title,widget.name);
      Navigator.pop(context);
    }else{
      fToast.showToast(
          child:Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.blueGrey.shade50,
            ),child:Text('The report is empty',style: TextStyle(
            fontSize: 17,
            color: Colors.black,

          ),) , ));
    }
  }
}

// class ChatListTile extends StatelessWidget {
//   final String reportId;
//   final String chatRoomId;
//   ChatListTile(this.reportId,this.chatRoomId);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewReport()));
//             },
//             child:Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(30)),
//
//                 color: Color(0xff006064),
//               ),
//               child:
//               Container(
//
//                 margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
//                 child:Row(
//                   children: [
//                     Text(userName,style: TextStyle(
//                       fontSize: 17,
//                       color: Colors.white,
//                     )
//                     ),
//                   ],
//                 ),
//
//               ),
//             )
//         ),
//         SizedBox(height: 1,)
//       ],
//     );
//   }
// }
