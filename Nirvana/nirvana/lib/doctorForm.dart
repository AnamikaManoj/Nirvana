import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nirvana/docHome.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/helper/helperfunction.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/widgets/widget.dart';

class DoctorForm extends StatefulWidget {
  @override
  _DoctorFormState createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
 DatabaseMethods databaseMethods=DatabaseMethods();
 TextEditingController phoneController=TextEditingController();
 TextEditingController hospitalController=TextEditingController();
 TextEditingController positionController=TextEditingController();
 TextEditingController cityController=TextEditingController();
 TextEditingController  regdController =TextEditingController();
  TextEditingController  slot1 =TextEditingController();
  TextEditingController  slot2 =TextEditingController();
  TextEditingController  slot3 =TextEditingController();
  TextEditingController  slot4 =TextEditingController();

  var email;
 List<String> timehr=['1','2','3','4','5','6','7','8','9','10','11','12'];
  List<String> timemm=['00','15','30','45'];
  List<String> ampm=['AM','PM'];
 String hr1,mm1,am1='AM',am2='AM',hr2,mm2,hr3,hr4,hr5,hr6,mm3,mm4,mm5,mm6,am3='AM',am4='AM',am5='AM',am6='AM';
 bool mon,tue,wed,thur,fri,sat,sun;
 List<String> working=['1','2'];

 getEmail(){
   setState(() {
     email=Constants.userEmail;
   });
 }

 @override
  void initState() {
    getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body:SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              // alignment: Alignment.bottomCenter,
              // height: MediaQuery.of(context).size.height-150,

            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Row(
                  children: [
                    Text("Let us get to know you better ",style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cookie',
                      fontSize: 40
                    ),
                    textAlign: TextAlign.center,),
                    SizedBox(width:8),
                    Image.asset("assets/images/happy_icon.png",height: 40,)
                  ],
                ),
                SizedBox(height: 30,),
                //Image.asset('assets/images/Nirvana_logo.png'),
                Text("Personal Details",
                style:TextStyle(
                color:Colors.white,
                  fontSize: 20,
                  decoration: TextDecoration.underline,

                )),
                Form(
                 key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty||!(RegExp(
                              r"^[0-9]+")
                              .hasMatch(val)&&val.length==10 )? "Enter your phone number":null ;
                        },
                       controller: phoneController,
                        style: SimpleTextstyle(),
                        decoration: decor('Phone Number'),
                      ),
                      SizedBox(height: 16,),
                      Text("Proffesional details",
                          style:TextStyle(
                              color:Colors.white,
                              fontSize: 20,
                            decoration: TextDecoration.underline,
                          )),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty?
                          "Please Enter a value":null;
                        },
                        controller: regdController,
                        style: SimpleTextstyle(),
                        decoration: decor('Regd. no'),
                      ),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty?
                              "Please Enter a value":null;
                        },
                       controller: hospitalController,
                        style: SimpleTextstyle(),
                        decoration: decor('Currently working at'),
                      ),
                      TextFormField(

                        validator: (val) {
                          return val.isEmpty
                              ? "Enter the position"
                              : null;
                        },
                        controller: positionController,
                        style: SimpleTextstyle(),
                        decoration: decor('Position'),
                      ),
                      TextFormField(

                        validator: (val) {
                          return val.isEmpty
                              ? "Enter the city"
                              : null;
                        },
                        controller: cityController,
                        style: SimpleTextstyle(),
                        decoration: decor('City'),
                      ),
                      SizedBox(height: 16,),
                      Text("Consultation Time:",style: TextStyle(color:Colors.white,fontSize: 17)),
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("From",style: TextStyle(color:Colors.white,fontSize: 17)),
                            SizedBox(width: 10,),
                            DropdownButton(
                                items: timehr.map((value)=>DropdownMenuItem(
                                  child: Text(value,
                                      style:TextStyle(fontSize: 17)
                                  ),
                                  value: value,
                                )).toList(),

                                hint:hr1==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                                Text(hr1,style: TextStyle(color:Colors.white,fontSize: 17)),
                                dropdownColor: Colors.blueGrey,

                                onChanged: (val) {
                                  setState(() {
                                    hr1 = val;
                                  });
                                }),
                            SizedBox(width: 10,),
                            Text(":",style: TextStyle(color:Colors.white,fontSize: 17)),
                            SizedBox(width: 10,),
                            DropdownButton(
                                items: timemm.map((value)=>DropdownMenuItem(
                                  child: Text(value,
                                      style:TextStyle(fontSize: 17)
                                  ),
                                  value: value,
                                )).toList(),

                                hint:mm1==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                                Text(mm1,style: TextStyle(color:Colors.white,fontSize: 17)),
                                dropdownColor: Colors.blueGrey,

                                onChanged: (val) {
                                  setState(() {
                                    mm1 = val;
                                  });
                                }),
                            SizedBox(width: 5,),
                            DropdownButton(
                                items: ampm.map((value)=>DropdownMenuItem(
                                  child: Text(value,
                                      style:TextStyle(fontSize: 17)
                                  ),
                                  value: value,
                                )).toList(),
                                hint:am1==null?Text('AM',style: TextStyle(color:Colors.white,fontSize: 17)):
                                Text(am1,style: TextStyle(color:Colors.white,fontSize: 17)),
                                dropdownColor: Colors.blueGrey,

                                onChanged: (val) {
                                  setState(() {
                                    am1 = val;
                                  });
                                }),
                            SizedBox(width: 15,),
                            Row(
                              children: [
                                Text("To",style: TextStyle(color:Colors.white,fontSize: 17)),
                                SizedBox(width: 10,),
                                DropdownButton(
                                    items: timehr.map((value)=>DropdownMenuItem(
                                      child: Text(value,
                                          style:TextStyle(fontSize: 17)
                                      ),
                                      value: value,
                                    )).toList(),
                                    hint:hr2==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                                    Text(hr2,style: TextStyle(color:Colors.white,fontSize: 17)),
                                    dropdownColor: Colors.blueGrey,

                                    onChanged: (val) {
                                      setState(() {
                                        hr2 = val;
                                      });
                                    }),
                                SizedBox(width: 10,),
                                Text(":",style: TextStyle(color:Colors.white,fontSize: 17)),
                                SizedBox(width: 10,),
                                DropdownButton(
                                    items: timemm.map((value)=>DropdownMenuItem(
                                      child: Text(value,
                                          style:TextStyle(fontSize: 17)
                                      ),
                                      value: value,
                                    )).toList(),
                                    hint:mm2==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                                    Text(mm2,style: TextStyle(color:Colors.white,fontSize: 17)),
                                    dropdownColor: Colors.blueGrey,

                                    onChanged: (val) {
                                      setState(() {
                                        mm2 = val;
                                      });
                                    }),
                                SizedBox(width: 10,),
                                DropdownButton(
                                    items: ampm.map((value)=>DropdownMenuItem(
                                      child: Text(value,
                                          style:TextStyle(fontSize: 17)
                                      ),
                                      value: value,
                                    )).toList(),
                                    hint:am2==null?Text('AM',style: TextStyle(color:Colors.white,fontSize: 17)):
                                    Text(am2,style: TextStyle(color:Colors.white,fontSize: 17)),
                                    dropdownColor: Colors.blueGrey,

                                    onChanged: (val) {
                                      setState(() {
                                        am2 = val;
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),


                      SizedBox(width:15),
                      Text('Working Days',style: TextStyle(color:Colors.white,fontSize: 17)),
                      Row(
                        children: [
                          Row(
                              children:[
                                //SizedBox(width: 10,),
                                Checkbox(
tristate:true,
                                  checkColor: Colors.blueGrey,
                                  activeColor: Colors.black,
                                  value: this.mon,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.mon = value;
                                    });
                                  },
                                ),
                                Text('Monday',style: TextStyle(fontSize: 18.0,color: Colors.white24), ),
                              ]),
                          Row(
                              children:[
                                //SizedBox(width: 10,),
                                Checkbox(
                                  tristate:true,
                                  checkColor: Colors.blueGrey,
                                  activeColor: Colors.black,
                                  value: this.tue,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.tue = value;
                                    });
                                  },
                                ),
                                Text('Tuesday',style: TextStyle(fontSize: 18.0,color: Colors.white24), ),
                              ]),
                          Row(
                              children:[
                                //SizedBox(width: 10,),
                                Checkbox(
                                  tristate:true,
                                  checkColor: Colors.blueGrey,
                                  activeColor: Colors.black,
                                  value: this.wed,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.wed = value;
                                    });
                                  },
                                ),
                                Text('Wednesday',style: TextStyle(fontSize: 18.0,color: Colors.white24), ),
                              ]),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                              children:[
                                //SizedBox(width: 10,),
                                Checkbox(
                                 tristate:true,
                                  checkColor: Colors.blueGrey,
                                  activeColor: Colors.black,
                                  value: thur,
                                  onChanged: (bool value) {
                                    setState(() {
                                      thur = value;
                                    });
                                  },
                                ),
                                Text('Thursday',style: TextStyle(fontSize: 18.0,color: Colors.white24), ),
                              ]),
                          Row(
                              children:[
                                //SizedBox(width: 10,),
                                Checkbox(
                                  tristate:true,
                                  checkColor: Colors.blueGrey,
                                  activeColor: Colors.black,
                                  value: fri,
                                  onChanged: (bool value) {
                                    setState(() {
                                      fri = value;
                                    });
                                  },
                                ),
                                Text('Friday',style: TextStyle(fontSize: 18.0,color: Colors.white24), ),
                              ]),
                          Row(
                              children:[
                                //SizedBox(width: 10,),
                                Checkbox(
                                  tristate:true,
                                  checkColor: Colors.blueGrey,
                                  activeColor: Colors.black,
                                  value: sat,
                                  onChanged: (bool value) {
                                    setState(() {
                                      sat = value;
                                    });
                                  },
                                ),
                                Text('Saturday',style: TextStyle(fontSize: 18.0,color: Colors.white24), ),
                              ]),
                        ],
                      ),
                      Row(
                          children:[
                            //SizedBox(width: 10,),
                            Checkbox(
                              tristate:true,
                              checkColor: Colors.blueGrey,
                              activeColor: Colors.black,
                              value: sun,
                              onChanged: (bool value) {
                                setState(() {
                                  sun = value;
                                });
                              },
                            ),
                            Text('Sunday',style: TextStyle(fontSize: 18.0,color: Colors.white24), ),
                          ]),
                      Text('Slots for your consultation',style: TextStyle(fontSize: 18.0,color: Colors.white),),
                      Row(
                        children: [
                          Text("Slot 1",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                        SizedBox(width: 15,),
                          DropdownButton(
                              items: timehr.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),

                              hint:hr3==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(hr3,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  hr3 = val;
                                });
                              }),
                          SizedBox(width: 10,),
                          Text(":",style: TextStyle(color:Colors.white,fontSize: 17)),
                          SizedBox(width: 10,),
                          DropdownButton(
                              items: timemm.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),

                              hint:mm3==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(mm3,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  mm3 = val;
                                });
                              }),
                          SizedBox(width: 5,),
                          DropdownButton(
                              items: ampm.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),
                              hint:am3==null?Text('AM',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(am3,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  am3 = val;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Slot 2",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                          SizedBox(width: 15,),
                          DropdownButton(
                              items: timehr.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),

                              hint:hr4==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(hr4,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  hr4 = val;
                                });
                              }),
                          SizedBox(width: 10,),
                          Text(":",style: TextStyle(color:Colors.white,fontSize: 17)),
                          SizedBox(width: 10,),
                          DropdownButton(
                              items: timemm.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),

                              hint:mm4==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(mm4,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  mm4 = val;
                                });
                              }),
                          SizedBox(width: 5,),
                          DropdownButton(
                              items: ampm.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),
                              hint:am4==null?Text('AM',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(am4,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  am4 = val;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Slot 3",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                          SizedBox(width: 15,),
                          DropdownButton(
                              items: timehr.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),

                              hint:hr5==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(hr5,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  hr5 = val;
                                });
                              }),
                          SizedBox(width: 10,),
                          Text(":",style: TextStyle(color:Colors.white,fontSize: 17)),
                          SizedBox(width: 10,),
                          DropdownButton(
                              items: timemm.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),

                              hint:mm5==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(mm5,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  mm5 = val;
                                });
                              }),
                          SizedBox(width: 5,),
                          DropdownButton(
                              items: ampm.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),
                              hint:am5==null?Text('AM',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(am5,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  am5 = val;
                                });
                              }),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Slot 4",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                          SizedBox(width: 15,),
                          DropdownButton(
                              items: timehr.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),

                              hint:hr6==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(hr6,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  hr6 = val;
                                });
                              }),
                          SizedBox(width: 10,),
                          Text(":",style: TextStyle(color:Colors.white,fontSize: 17)),
                          SizedBox(width: 10,),
                          DropdownButton(
                              items: timemm.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),

                              hint:mm6==null?Text('__',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(mm6,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  mm6 = val;
                                });
                              }),
                          SizedBox(width: 5,),
                          DropdownButton(
                              items: ampm.map((value)=>DropdownMenuItem(
                                child: Text(value,
                                    style:TextStyle(fontSize: 17)
                                ),
                                value: value,
                              )).toList(),
                              hint:am6==null?Text('AM',style: TextStyle(color:Colors.white,fontSize: 17)):
                              Text(am6,style: TextStyle(color:Colors.white,fontSize: 17)),
                              dropdownColor: Colors.blueGrey,

                              onChanged: (val) {
                                setState(() {
                                  am6 = val;
                                });
                              }),
                        ],
                      )

                    ],
                  ),
                ),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
    if (_formKey.currentState.validate()) {
        createDialog(this.context);

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
                    child: Text("Continue", style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),),

                  ),
                ),


                SizedBox(height: 50,)
              ],
            ),
            ),
          ),

    );
  }

  UploadDetails(){
   // if(mon==true){
   //   working.add('1');
   // }
   // if(tue==true){
   //   working.add('2');
   // }if(wed==true){
   //   working.add('3');
   // }if(thur==true){
   //   working.add('4');
   // }if(fri==true){
   //   working.add('5');
   // }if(sat==true){
   //   working.add('6');
   // }if(sun==true){
   //   working.add('7');
   // }
    Map<String,dynamic> map={
      'name':Constants.myName,
      'email': email,
      'phone':phoneController.text,
      'regdno':regdController.text,
      'hospital':hospitalController.text,
      'position':positionController.text,
      'city':cityController.text,
      'status':'',
      'workingFrom':'${hr1}:${mm1} ${am1}',
      'WorkingTo':'${hr2}:${mm2} ${am2}',
     // 'WorkingDays':working
    };
   print(working);
    Map<String,dynamic> map2={
      'slot1':"${hr3}:${mm3} ${am3}",
      'slot2':"${hr4}:${mm4} ${am4}",
    'slot3':"${hr5}:${mm5} ${am5}",
    'slot4':"${hr6}:${mm6} ${am6}",

    };
    bool res,res2;
   res= databaseMethods.uploadDocInfo(map, Constants.myName);
   res2=databaseMethods.uploadTimeInfo(map2,Constants.myName);
   if(res&&res2)
   return;
  }
  
  createDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Your License will be verified within 24 hours. Till then take your time to explore Nirvana'),
        actions: [
          MaterialButton(
            child:Text('OK',style: TextStyle(color: Colors.white)),
            onPressed:(){UploadDetails();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DocHome()));}, //UploadDetails(),
          )
        ],
        backgroundColor: Colors.blueGrey,

      );
    });
  }

}
