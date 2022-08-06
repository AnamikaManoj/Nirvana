import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nirvana/chatroom.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/search.dart';
import 'package:nirvana/services/auth.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/signin.dart';
import 'package:nirvana/widgets/widget.dart';
class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}


class _ChatsState extends State<Chats> {
  AuthMethods authMethods=new AuthMethods();
  DatabaseMethods databaseMethods=DatabaseMethods();

  Stream chatListStream;
  String name;

  Widget ChatList(){
    return chatListStream!=null?StreamBuilder(
      stream: chatListStream,
        builder: (context,snapshot){
        return snapshot.data.docs.length!=0? ListView.builder(
          itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
            return ChatListTile(snapshot.data.docs[index].get("chatRoomId")
            .toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                snapshot.data.docs[index].get("chatRoomId").toString());
            }):Container();
        }):Container();
  }

  @override
  void initState() {
    getLoginName();
    getUserInfo();
    super.initState();
  }



  getUserInfo()async{
  Constants.myName=await HelperFunction.getUserName();
  databaseMethods.getChats(Constants.myName).then((val){
    setState(() {
      chatListStream=val;
    });
  });
  }

  getLoginName() async {
    await HelperFunction.getUserName().then((val){
      name=val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [

            Image.asset('assets/images/Nirvana_logo.png',height: 60.0,),
            Image.asset('assets/images/logo_text.png'),

          ],
        ),
        backgroundColor: Color(0xff145C8D),

      ),
      body:chatListStream!=null?Container(
        margin: EdgeInsets.all(16),
        child: ChatList(),
      ):Container(),

    );
  }
}

class ChatListTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatListTile(this.userName,this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoom(chatRoomId,userName)));
          },
          child:Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),

            color: Color(0xff006064),
          ),
          child:
               Container(

                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  child:Row(
                    children: [

                      Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        //padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.white30,
                        ),
                          child: Text('${userName.substring(0,1).toUpperCase()}',style: TextStyle(
                            fontSize: 30,
                            //fontWeight: FontWeight.bold,,
                            fontFamily: 'Cookie',
                          ),),),

                      SizedBox(width: 8.0),
                      Text(userName,style: TextStyle(
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
