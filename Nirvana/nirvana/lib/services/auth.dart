import 'package:firebase_auth/firebase_auth.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/module/user.dart';
import 'package:nirvana/services/database.dart';

class AuthMethods{
  DatabaseMethods databaseMethods=DatabaseMethods();
  final FirebaseAuth _auth= FirebaseAuth.instance;

  User1 _userFromFireBaseUser(User user){
    return user!=null ? User1(UserId: user.uid) : null;
  }

  Future signInWithEmailAndPass(String email,String password) async {
    try{

      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser=result.user;//get user id
      return _userFromFireBaseUser(firebaseUser);
    }catch(e){
     // print(e.toString());
      print("Error in SignIn");
      print(e);

    }
  }

  Future signupWithEmailAndPass(String email,String password) async {
    try{

      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser=result.user;//get user id
      return _userFromFireBaseUser(firebaseUser);
    }catch(e){
     // print(e.toString());

    }
  }
  Future resetPass(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

  Future<bool> ValidatePassword(String password) async{
    try{
      var firebaseUser = await _auth.currentUser;
      var authCredential = EmailAuthProvider.credential(
          email: firebaseUser.email, password: password);

      var authResult = await firebaseUser.reauthenticateWithCredential(
          authCredential);
      return authResult.user != null;
    }catch(e) {
      print(e.toString());
      return false;
    }
  }

  updatePassword(password)async{
    var firebaseuser= await _auth.currentUser;
    firebaseuser.updatePassword(password);
  }

  Future deleteUserAccount(String password)async{
    try{
      User user =await _auth.currentUser;
      print(user);
      AuthCredential authCredential=EmailAuthProvider.credential(email: Constants.userEmail, password: password);
      await user.reauthenticateWithCredential(authCredential).then((val)async{
        databaseMethods.deleteUser(Constants.myName);
        await val.user.delete();
      });
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }
}