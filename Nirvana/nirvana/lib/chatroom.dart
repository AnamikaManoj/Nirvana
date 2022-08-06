import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nirvana/docProfile.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/report.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/widgets/widget.dart';

class ChatRoom extends StatefulWidget {

  final String chatRoomId;
  final String username;

  ChatRoom(this.chatRoomId,this.username);


  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  TextEditingController messageController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream chatMessageStream;
  var usertype;
  FToast fToast;
String rName;
setRName() {
  if (Constants.userType == 'doctor') {
    setState(() {
      rName=widget.username;
    });
  }else{
    setState(() {
      rName=Constants.myName;
    });
  }
}
  Widget ChatMessageList() {
    return StreamBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return MessageTile(snapshot.data.docs[index].get('message'),
                snapshot.data.docs[index].get('sendBy') == Constants.myName);
          },
        ) : Container();
      },
      stream: chatMessageStream,

    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        // "name": ,
        "message": messageController.text,
        "sendBy": Constants.myName,
        'time': DateTime
            .now()
            .millisecondsSinceEpoch,
      };
      databaseMethods.StoreConversation(widget.chatRoomId, messageMap);
    }
  }

  getType() {
    setState(() {
      usertype = HelperFunction.getUserType();
    });
  }

  @override
  void initState() {
  setRName();
    print('$widget.chatRoomId');
    databaseMethods.getConversation(widget.chatRoomId).then((val) {
      setState(() {
        chatMessageStream = val;
      });
      getType();
    });
    fToast = FToast();
    fToast.init(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              children: [
                Text(widget.username),
                if (Constants.userType == 'user')Expanded(
                  child: Container(
                    //width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerRight,
                      //padding:EdgeInsets.all(10),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DocProfile(widget.username)));
                          },
                          child:Icon(Icons.account_circle_outlined)
                  ),
                )),
                    Constants.userType=='doctor'?Spacer():SizedBox(width:16),
                    GestureDetector(
                    onTap: () {

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Report(rName)));
        },

          child: Icon(
            Icons.menu_book_sharp, color: Colors.white,),
        )
              ]), backgroundColor: Color(0xff145C8D),),

        body: Container(
          margin: EdgeInsets.all(10),
          child: Stack(
            children: [
              ChatMessageList(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Color(0xffc5cae9),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TextField(
                           //MessageTextfield
                            controller: messageController,
                            style: TextStyle(
                              color: Color(0xff000051),
                              fontSize: 17,
                            ),
                            decoration: InputDecoration(
                              hintText: "Enter your Message...",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                              ),
                              border: InputBorder.none,
                            ),
                          )
                      ),

                      GestureDetector(
                        onTap: () {
                          //return SearchText.text!=Constants.myName ?InitiateSearch():Container();
                          if(messageController.text.isNotEmpty){
                          sendMessage();
                          messageController.clear();
                          // print("Message send");
                          }else{
                            fToast.showToast(
                                child:Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.blueGrey.shade50,
                                  ),child:Text('The message is empty',style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,

                                ),) , ));
                          }
                        },
                        child: Container( //search icon
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(50),
                            ),

                            child: Icon(Icons.send, size: 30, color: Color(
                                0xff6f79a8),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }


}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message,this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:isSendByMe?0:16,right: isSendByMe?16:0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe?Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
        decoration: BoxDecoration(
          borderRadius:isSendByMe?
          BorderRadius.only(topLeft:Radius.circular(23),topRight: Radius.circular(23),bottomLeft: Radius.circular((23))):
          BorderRadius.only(topLeft:Radius.circular(23),topRight: Radius.circular(23),bottomRight: Radius.circular((23))),
          gradient: LinearGradient(
            colors:
              isSendByMe?[
                Color(0xff3f7690),
                Color(0xff33677f)
              ]:[
                  Color(0xff2e2d2d),
              Color(0xff2e2d2d),]
          )
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white
          ),
        ),
      ),
    );
  }


}

