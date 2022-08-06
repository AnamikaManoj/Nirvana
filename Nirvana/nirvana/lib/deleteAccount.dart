import 'package:flutter/material.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/services/auth.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/signup.dart';
import 'package:nirvana/widgets/widget.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  GlobalKey<FormState>  formKey=GlobalKey<FormState>();
  TextEditingController password=TextEditingController();
  AuthMethods authMethods=AuthMethods();
  DatabaseMethods databaseMethods=DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Your account will be permanently deleted from our systems. If you are sure about this, please enter your password to continue',style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),),
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) {
                    return val.isEmpty || val.length < 8
                        ? "Enter a password with minimum of 8 characters"
                        : null;
                  },
                  controller: password,
                  style: SimpleTextstyle(),
                  decoration: decor('Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap:()async{
                    bool res;
                    res= await authMethods.deleteUserAccount(password.text);
                    print(res);
                    res?
                    createDialog1(context,) :
                    createDialog2(context,);


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
                    child: Text("Delete My Account",style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createDialog1(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Your Account has been deleted Succesfully'),
        actions: [
          MaterialButton(
            child:Text('OK',style: TextStyle(color: Colors.white),),
            onPressed:() {
              databaseMethods.deleteUser(Constants.myName);
              HelperFunction.saveUserLoggedInState(false);
              HelperFunction.saveUserName('');
              HelperFunction.saveUserType('');
              Navigator.pop(context);
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Signup()),(Route<dynamic> route)=>false);}, //UploadDetails(),
            )
        ],
        backgroundColor: Colors.blueGrey,
      );
    });
  }

  createDialog2(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Please enter correct password'),
        actions: [
          MaterialButton(
            child:Text('OK',style: TextStyle(color: Colors.white),),
            onPressed:(){Navigator.pop(context); }, //UploadDetails(),
          )
        ],
        backgroundColor: Colors.blueGrey,
      );
    });
  }
}
