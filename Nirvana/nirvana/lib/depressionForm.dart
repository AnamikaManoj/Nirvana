

import 'package:flutter/material.dart';
import 'package:nirvana/helper/constants.dart';
import 'package:nirvana/home.dart';
import 'package:nirvana/services/database.dart';
import 'package:nirvana/widgets/widget.dart';

class DepressionForm extends StatefulWidget {
  @override
  _DepressionFormState createState() => _DepressionFormState();
}

class _DepressionFormState extends State<DepressionForm> {
GlobalKey formKey=GlobalKey<FormState>();
List<String> Options=['Not at all','Several days','More than half the days','Nearly Everyday'];
String q1='1. Little interest or pleasure in doing things',
    q2='2. Feeling down, depressed, or hopeless',
    q3='3. Trouble falling or staying asleep, or sleeping too much',
    q4='4. Feeling tired or having little energy',
    q5='5. Poor appetite or overeating',
    q6='6. Feeling bad about yourself — or that you are a failure or have let yourself or your family down ',
    q7='7. Trouble concentrating on things, such as reading the newspaper or watching television',
    q8='8. Moving or speaking so slowly that other people could have noticed? Or the opposite — being so fidgety or restless that you have been moving around a lot more than usual',
    q9='9. Thoughts that you would be better off dead or of hurting yourself in some way';
String a1,a2,a3,a4,a5,a6,a7,a8,a9;
int a11,a22,a33,a44,a55,a66,a77,a88,a99;
int score;
DatabaseMethods databaseMethods=DatabaseMethods();
DateTime date=DateTime.now();
String date1;

var report;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarMain(context),
      body:Container(
        child: Form(
          key:formKey,
          autovalidate: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
            Container(

            child:Container(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                child: Column(
                  children: [
                    Text('Over the last 2 weeks, how often have you been bothered by any of the following problems?',style:TextStyle(fontSize: 18,fontFamily: 'Courgette',color: Colors.white),textAlign: TextAlign.justify,),
                  ],
                )),
          ),
             returnCard(q1,),
              DropdownButton(
                  items: Options.map((value)=>DropdownMenuItem(
                    child: Text(value,
                        style:TextStyle(fontSize: 17)
                    ),
                    value: value,
                  )).toList(),
                  isExpanded: true,
                  hint:a1==null?Text('Select your response',style: TextStyle(color:Colors.white,fontSize: 17)):
                  Text(a1,style: TextStyle(color:Colors.white,fontSize: 17)),
                  dropdownColor: Colors.blueGrey,

                  onChanged: (val) {
                    setState(() {
                      a1 = val;
                    });
                  }),
              returnCard(q2,),
              DropdownButton(
                  items: Options.map((value)=>DropdownMenuItem(
                    child: Text(value,
                        style:TextStyle(fontSize: 17)
                    ),
                    value: value,
                  )).toList(),
                  isExpanded: true,
                  hint:a2==null?Text('Select your response',style: TextStyle(color:Colors.white,fontSize: 17)):
                  Text(a2,style: TextStyle(color:Colors.white,fontSize: 17)),
                  dropdownColor: Colors.blueGrey,

                  onChanged: (val) {
                    setState(() {
                      a2 = val;
                    });
                  }),
              returnCard(q3,),
              DropdownButton(
                  items: Options.map((value)=>DropdownMenuItem(
                    child: Text(value,
                        style:TextStyle(fontSize: 17)
                    ),
                    value: value,
                  )).toList(),
                  isExpanded: true,
                  hint:a3==null?Text('Select your response',style: TextStyle(color:Colors.white,fontSize: 17)):
                  Text(a3,style: TextStyle(color:Colors.white,fontSize: 17)),
                  dropdownColor: Colors.blueGrey,

                  onChanged: (val) {
                    setState(() {
                      a3 = val;
                    });
                  }),
              returnCard(q4,),
              DropdownButton(
                  items: Options.map((value)=>DropdownMenuItem(
                    child: Text(value,
                        style:TextStyle(fontSize: 17)
                    ),
                    value: value,
                  )).toList(),
                  isExpanded: true,
                  hint:a4==null?Text('Select your response',style: TextStyle(color:Colors.white,fontSize: 17)):
                  Text(a4,style: TextStyle(color:Colors.white,fontSize: 17)),
                  dropdownColor: Colors.blueGrey,

                  onChanged: (val) {
                    setState(() {
                      a4 = val;
                    });
                  }),
              returnCard(q5,),
              DropdownButton(
                  items: Options.map((value)=>DropdownMenuItem(
                    child: Text(value,
                        style:TextStyle(fontSize: 17)
                    ),
                    value: value,
                  )).toList(),
                  isExpanded: true,
                  hint:a5==null?Text('Select your response',style: TextStyle(color:Colors.white,fontSize: 17)):
                  Text(a5,style: TextStyle(color:Colors.white,fontSize: 17)),
                  dropdownColor: Colors.blueGrey,

                  onChanged: (val) {
                    setState(() {
                      a5 = val;
                    });
                  }),
              returnCard(q6,),
              DropdownButton(
                  items: Options.map((value)=>DropdownMenuItem(
                    child: Text(value,
                        style:TextStyle(fontSize: 17)
                    ),
                    value: value,
                  )).toList(),
                  isExpanded: true,
                  hint:a6==null?Text('Select your response',style: TextStyle(color:Colors.white,fontSize: 17)):
                  Text(a6,style: TextStyle(color:Colors.white,fontSize: 17)),
                  dropdownColor: Colors.blueGrey,

                  onChanged: (val) {
                    setState(() {
                      a6 = val;
                    });
                  }),
              returnCard(q7,),
              DropdownButton(
                  items: Options.map((value)=>DropdownMenuItem(
                    child: Text(value,
                        style:TextStyle(fontSize: 17)
                    ),
                    value: value,
                  )).toList(),
                  isExpanded: true,
                  hint:a7==null?Text('Select your response',style: TextStyle(color:Colors.white,fontSize: 17)):
                  Text(a7,style: TextStyle(color:Colors.white,fontSize: 17)),
                  dropdownColor: Colors.blueGrey,

                  onChanged: (val) {
                    setState(() {
                      a7 = val;
                    });
                  }),
              returnCard(q8,),
              DropdownButton(
                  items: Options.map((value)=>DropdownMenuItem(
                    child: Text(value,
                        style:TextStyle(fontSize: 17)
                    ),
                    value: value,
                  )).toList(),
                  isExpanded: true,
                  hint:a8==null?Text('Select your response',style: TextStyle(color:Colors.white,fontSize: 17)):
                  Text(a8,style: TextStyle(color:Colors.white,fontSize: 17)),
                  dropdownColor: Colors.blueGrey,

                  onChanged: (val) {
                    setState(() {
                      a8 = val;
                    });
                  }),
              returnCard(q9,),
               DropdownButton(
                    items: Options.map((value)=>DropdownMenuItem(
                      child: Text(value,
                          style:TextStyle(fontSize: 17)
                      ),
                      value: value,
                    )).toList(),
                    isExpanded: true,
                    hint:a9==null?Text('Select your response',style: TextStyle(color:Colors.white,fontSize: 17)):
                    Text(a9,style: TextStyle(color:Colors.white,fontSize: 17)),
                    dropdownColor: Colors.blueGrey,

                    onChanged: (val) {
                      setState(() {
                        a9 = val;
                      });
                    }),

              SizedBox(height: 16,),
              GestureDetector(
                onTap:(){
                  date1='${date.day}.${date.month}.${date.year}';
                  if(a1!=null&&a2!=null&&a3!=null&&a4!=null&&a5!=null&&a6!=null&&a7!=null&&a8!=null&&a9!=null){
                    a11=Scorer(a1);
                    a22=Scorer(a2);
                    a33=Scorer(a3);
                    a44=Scorer(a4);
                    a55=Scorer(a5);
                    a66=Scorer(a6);
                    a77=Scorer(a7);
                    a88=Scorer(a8);
                    a99=Scorer(a9);
                    score=a11+a22+a33+a44+a55+a66+a77+a88+a99;
                    report="${q1}\nResponse:${a1}\n\n"
                        "${q2}\nResponse:${a2}\n\n"
                        "${q3}\nResponse:${a3}\n\n"
                        "${q4}\nResponse:${a4}\n\n"
                        "${q5}\nResponse:${a5}\n\n"
                        "${q6}\nResponse:${a6}\n\n"
                        "${q7}\nResponse:${a7}\n\n"
                        "${q8}\nResponse:${a8}\n\n"
                        "${q9}\nResponse:${a9}\n\n";
                   Map<String,String> map={
                     "date":date1,
                     "report":report
                   };
                   databaseMethods.UploadReport(map, 'Depression Test', Constants.myName);
                    //print(score);
                    if (score<5)
                      createDialog(context, 'Yay!You do not have any symptoms of depression');
                    else if(4<score&&score<10)
                      createDialog(context, 'Your Symptoms may imply a mild depression.We recommend you to consider talking to a counselor');
                    else if(9<score&&score<15)
                      createDialog(context, 'Your Symptoms may imply a moderate depression.We recommend you to consider talking to a counselor');
                    else if(14<score&&score<20)
                      createDialog(context, 'Your Symptoms may imply a moderately severe depression. It is highly recommended that you consider consulting a counselor as soon as possible. A detailed analysis would be required');
                    else
                      createDialog(context, 'Your Symptoms may imply a severe depression. It is highly recommended that you consider consulting a counselor as soon as possible. A detailed analysis would be required');
                  }else
                    createDialog2(context, 'Please answer all the questions');
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
                  child: Text("Submit Response",style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),),
                ),
              ),
              SizedBox(height: 24,)
            ],
          ),
        ),
      ),
    );
  }
  Scorer(val){
    switch (val){
      case 'Not at all':
        return 0;
      case 'Several days':
        return 1;
      case 'More than half the days':
        return 2;
      case 'Nearly Everyday':
        return 3;
    }

  }

  // upload(x,y,id){
  //
  //     Map<String,dynamic> usermap={
  //       '$id Q':x,
  //       '$id A':y
  //     };
  //     databaseMethods.uploadQuizResult(usermap,id);
  // }

  Widget returnCard(String x){
    //print(x);

   return  Card(
      color: Colors.blueGrey,
      child:Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
          child: Column(
            children: [
              Text(x,style:TextStyle(fontSize: 17),textAlign: TextAlign.justify,),
    ],
          )),
    );
  }
createDialog(BuildContext context,text){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text(text,textAlign: TextAlign.justify,),
      actions: [
        MaterialButton(
          child:Text('OK',style: TextStyle(color: Colors.white),),
          onPressed:(){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home())); }, //UploadDetails(),
        )
      ],
      backgroundColor: Colors.blueGrey,
    );
  });
}

createDialog2(BuildContext context,text){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text(text,textAlign: TextAlign.justify,),
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


