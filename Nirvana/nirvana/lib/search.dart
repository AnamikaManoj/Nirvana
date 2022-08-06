import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nirvana/chatList.dart';
import 'package:nirvana/chatroom.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/widgets/widget.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

 class _SearchState extends State<Search> {
  DatabaseMethods databaseMethods=DatabaseMethods();
  TextEditingController SearchText=TextEditingController();
  QuerySnapshot searchsnapshot;
  ChatRoom chatRoom;

  Widget SearchList(){
    return searchsnapshot!=null? ListView.builder(
      itemCount:searchsnapshot.docs.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        return SearchTile(
          username: searchsnapshot.docs[0].get('name'),
          hospital: searchsnapshot.docs[index].get('hospital'),
        ) ;
      },
    ):Container();
  }

  InitiateSearch(){
    databaseMethods.getUserbyName(SearchText.text).then((val){
      setState(() {
        searchsnapshot=val;
      });
    });
  }

  CreatechatRoomApp(String username){

    String ChatRoomId=getChatRoomId(username,Constants.myName);
    List<String> users=[username,Constants.myName];

    Map<String,dynamic> chatRoomMap = {
      "Users":users,
      "chatRoomId":ChatRoomId,
    };
    DatabaseMethods().createChatRoomdb(ChatRoomId, chatRoomMap);
    HelperFunction.saveSearchUser(username);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoom(ChatRoomId,username)));
  }

  Widget SearchTile({String username,String hospital}){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
      child: Row(
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dr. '+username,style:TextStyle(
                  color: Colors.white,
                  fontSize: 17
              )),
              SizedBox(height: 4.0),
              Text(hospital,style:TextStyle(
                  color: Colors.white,
                  fontSize: 17
              )),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              CreatechatRoomApp(username);
              SearchText.clear();
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff4DD0E1),
                    Color(0xff00BCD4),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: Text("Message",style: TextStyle(fontSize: 18),),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),//appbar for the screen
      body: Container(
        child: Column(    //because below the search bar comes the search results

            children:[
            Container(//for the search bar which consists of text and an image for search
              color: Color(0xff00ACC1),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical:16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: TextField( //searchTextfield
                        controller: SearchText,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search Username",
                          hintStyle: TextStyle(
                            color: Colors.white60,
                          ),
                          border: InputBorder.none,
                        ),
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                    // return SearchText.text!=Constants.myName ?InitiateSearch():Container();
                      return InitiateSearch();
                    },
                    child: Container(    //search icon
                      height: 40,
                        width: 40,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff4DD0E1),
                              Color(0xff00BCD4)
                              ]
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),

                        child: Icon(Icons.search,color: Colors.black,)),
                  ),
                ],
              ),
            ),
            SearchList(),
          ]
        )
      )
    );
  }
  getChatRoomId(String a,String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0))
      return '$b\_$a';
    else
      return'$a\_$b';
  }
}





