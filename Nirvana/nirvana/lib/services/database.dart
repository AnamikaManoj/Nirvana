import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';

class DatabaseMethods {
DateTime datee=DateTime.now();
  getUserbyName(String username) async {
    return await FirebaseFirestore.instance.collection('Doctors')
        .where("name",isEqualTo: username)
        .get();
  }

  getUserbyMail(String email) async {
    return await FirebaseFirestore.instance.collection('Users')
        .where("email",isEqualTo: email)
        .get();
  }

  getDocbyMail(String email) async {
    return await FirebaseFirestore.instance.collection('Doctors')
        .where("email",isEqualTo: email)
        .get();
  }

  uploadInfo(userMap,name) {
    FirebaseFirestore.instance.collection("Users")
        .doc(name).set(userMap).catchError((e) {
      print(e);
    });
  }

    searchUser(username)async{
      String val='dbdb';
    await FirebaseFirestore.instance.collection("Users")
     .doc(username).get().
     then((value) {

          if(value.exists){
            print('doc exist');
            val= 'Username already in use';
          }
          else if (!value.exists){
            print('doc not exist');
            val= "";
          }
          print('val from db: $val');
          return val.toString();
    }) ;
    return val;
  }

  uploadDocInfo(userMap,name) {

    FirebaseFirestore.instance.collection("Doctors")
        .doc(name).set(userMap).catchError((e) {
      print(e);
      print('false');
      return false;
    });
    return true;
  }
uploadTimeInfo(userMap,name) {

  FirebaseFirestore.instance.collection("Doctors")
      .doc(name).collection('TimeSlots').doc('slots').set(userMap).catchError((e) {
    print(e);
    print('false');
    return false;
  });
  return true;
}

UploadTimeSlot(map,name,date){
    FirebaseFirestore.instance.collection('TimeSlots')
        .doc(name)
        .collection('appointments')
        .doc(date)
        .set(map,SetOptions(merge: true));
}

  uploadAppointment(userMap) {
    FirebaseFirestore.instance.collection("Appointments")
        .add(userMap).catchError((e) {
      print(e);
    });
  }

  uploadQuizResult(userMap,id) {
    FirebaseFirestore.instance.collection("Users")
    .doc(Constants.myName)
    .collection('Reports')
    .doc('DepressionTest')
        .set(userMap,SetOptions(merge: true)).catchError((e) {
      print(e);
    });
  }

  createChatRoomdb(String ChatRoomId,chatRoomMap){
    FirebaseFirestore.instance.collection("Chatrooms")
        .doc(ChatRoomId).set(chatRoomMap).catchError((e){
          print(e);
    });
  }

  StoreConversation(String ChatRoomId,messageMap){
    FirebaseFirestore.instance.collection("Chatrooms")
        .doc(ChatRoomId)
        .collection("chats")
        //.doc(DateTime.now().millisecondsSinceEpoch.toString())
        .add(messageMap).catchError((e){
      print(e);
    });
  }

  UploadReport(userMap,id,name){
    FirebaseFirestore.instance.collection("Users")
        .doc(name)
        .collection('Reports')
        .doc(id)
        .set(userMap,SetOptions(merge: true)).catchError((e) {
      print(e);
    });
  }

  checkConsultationStatus()async{
    print("inside function");
    var x;
    await FirebaseFirestore.instance.collection("Users")
        .doc(Constants.myName)
        .get().then((value){
          if(value.data().containsKey('consulting')){
          //print(value.get('consulting'));
         x=value.get('consulting');
          }
          else{
            x=null;
          }
      return x;
    });
    return x;
  }

  LoadReportList(name) async {
   return await FirebaseFirestore.instance.collection("Users")
        .doc(name)
        .collection('Reports')
       .orderBy('date')
        .snapshots();
  }

  LoadReport(name,id)async{
    return await FirebaseFirestore.instance.collection("Users")
        .doc(name)
        .collection('Reports')
    .doc(id)
        .get();

  }


  updateDoc(name){
    FirebaseFirestore.instance.collection("Users")
        .doc(Constants.myName)
        .update({'consulting':name});
  }

  getConversation(String ChatRoomId)async{
    return await FirebaseFirestore.instance.collection("Chatrooms")
        .doc(ChatRoomId)
        .collection("chats")
        .orderBy('time',descending: false)
        .snapshots();

  }

  getAppointments(String name)async{
    return await FirebaseFirestore.instance.collection("Appointments")
    .where("doctor",isEqualTo: name)
    .where('date1',isGreaterThan:datee )
    //.orderBy('date',descending:false )// the recent ones on top
    .get();
  }
  
  getChats(String username)async{
    return await FirebaseFirestore.instance.collection("Chatrooms")
        .where('Users',arrayContains: username)
        .snapshots();
  }

  deleteUser(name)async{
    await FirebaseFirestore.instance.collection('Users')
        .doc(name).delete().catchError((onError){
      print(onError);
    });
      print('deleted');


    if(await HelperFunction.getUserType()=='doctor'){
    FirebaseFirestore.instance.collection('Doctors')
    .doc(name).delete().catchError((onError){
      print(onError);
    });}
    print('Deleted from doctrs');
  }

}

