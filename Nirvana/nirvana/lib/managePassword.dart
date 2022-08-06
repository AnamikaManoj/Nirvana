import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nirvana/services/auth.dart';
import 'package:nirvana/widgets/widget.dart';


class ManagePassword extends StatefulWidget {
  @override
  _ManagePasswordState createState() => _ManagePasswordState();
}

class _ManagePasswordState extends State<ManagePassword> {

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  TextEditingController oldPasswordController=TextEditingController();
  TextEditingController newPasswordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  bool checkPassword=true;
  AuthMethods authMethods=AuthMethods();
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
                key: _formKey,
                child:Column(
                  children:[
                    Text("Manage Password",
                        style:TextStyle(
                          color:Colors.white,
                          fontSize: 34,

                        )),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty?
                        "Please Enter your current password":null;
                      },
                      obscureText: true,
                      controller: oldPasswordController,
                      style: SimpleTextstyle(),
                      decoration: InputDecoration(
                        // hintText:'Enter ${hint}',
                          labelText:'Current Password' ,
                          labelStyle: TextStyle(
                            color: Colors.white,

                          ),
                          errorText: checkPassword?null:"Invalid Password",
                          hintStyle: TextStyle(

                            color: Colors.white,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60)
                          )
                      ),
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty || val.length < 8
                            ? "Enter a password with minimum of 8 characters"
                            : null;
                      },
                      obscureText: true,
                      controller: newPasswordController,
                      style: SimpleTextstyle(),
                      decoration: decor('New Password'),
                    ),
                    TextFormField(

                      validator: (val) {
                        return (val!=newPasswordController.text)
                            ? "Passwords does not match"
                            : null;
                      },
                      obscureText: true,
                      controller: confirmPasswordController,
                      style: SimpleTextstyle(),
                      decoration: decor('Confirm new password'),
                    ),
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: () async{
                        if (_formKey.currentState.validate()) {
                          checkPassword= await checkCurrentPassword(oldPasswordController.text);
                          if(checkPassword){
                            authMethods.updatePassword(newPasswordController.text);
                            Navigator.pop(context);
                            ShowSuccess();
                          }else{
                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                                title: Text('Please enter correct password'),
                                actions: [
                                  Center(child:MaterialButton(

                                    child:Text('OK',style: TextStyle(color: Colors.white),),
                                    onPressed:(){Navigator.pop(context); }, //UploadDetails(),
                                  ))
                                ],
                                backgroundColor: Colors.blueGrey,
                              );
                            });
                          }

                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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
                        child: Text("Confirm", style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),),

                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),


    );
  }

  Future<bool> checkCurrentPassword(String password)async{
    return await authMethods.ValidatePassword(password);
  }

  ShowSuccess(){
    return fToast.showToast(
        child:Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.blueGrey.shade50,
          ),child:Text('Password Updated Successfully',style: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),) , ));
  }
}
