import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_mate/Screens/questions_screen.dart';
import 'package:health_mate/Widgets/dropdownforfiler.dart';
import 'package:health_mate/Widgets/pichart.dart';
import 'package:health_mate/globle.dart';
import 'package:health_mate/resources/featchQuizQuestion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../facial-model/image-model.dart';

class HappinessJuiceScreen extends StatefulWidget {
  const HappinessJuiceScreen({super.key});

  @override
  State<HappinessJuiceScreen> createState() => _HappinessJuiceScreenState();
}

class _HappinessJuiceScreenState extends State<HappinessJuiceScreen> {
  String Exelent = 'Congratulations! You\'re excelling in multiple areas of your well-being. Keep up the positive momentum and continue nurturing your social connections, personal fulfillment, and financial stability. Remember to celebrate your achievements and maintain the habits that contribute to your happiness and success.';
  String Good = 'Well done! You\'re doing great overall, but there\'s always room for growth. Continue to build upon your strengths and address any areas where you feel less satisfied. Stay motivated and committed to your personal growth journey, and don\'t hesitate to seek support or guidance when needed.';
  String normal = 'You\'re making progress, but there\'s potential for improvement. Take this opportunity to reflect on your responses and identify areas where you\'d like to see positive changes. Set achievable goals and take small steps towards enhancing your well-being in all aspects of your life.';
  String bad ='It\'s okay to face challenges, and your responses indicate areas where you may need additional support or attention. Take this as an opportunity to prioritize your well-being and seek help where necessary. Remember that progress takes time, and every step towards improvement is worth celebrating. Stay resilient and keep moving forward.';
  bool flag = false;
  late List<Map<String, String>> queslist;
  late List<Map<String, String>> totalMarks;
  late bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getstatus();
    getmarks();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      body: flag
          ? Center(child: CircularProgressIndicator(color: Colors.deepPurple,))
          : Container(
        padding: Width > 600
            ? EdgeInsets.symmetric(horizontal: Width / 2.9)
            : const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Stack(
                  children: [ Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: PiChart(ans: totalMarks,)
                  ),
                    Positioned(
                        right: 20,
                        child: InkWell(
                          child: Icon(Icons.filter_list, size: 35,),
                          onTap: () {
                            _showdialog(context);
                          },
                        )
                    )
                  ]
              ),
              SizedBox(height: 20,),
              Container(
                // height: MediaQuery.of(context).size.height/2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.deepPurple.shade100,
                ),
                child: Text(
                   Exelent
                ),
              ),
              FilledButton(onPressed: () async {
                if (status == true) {
                  Fluttertoast.showToast(msg: 'Already given');
                }
                else {
                  List<Map<String, String>> queslist = await FetchQuizQuestion()
                      .fetchQuestionAndOption();
                  print(queslist);
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuestionS(
                        queslist: queslist,)));
                }
              }, child: Text('Questions are ready to be answered')),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyModelImage()));
      },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  void getstatus() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection(
        'admin')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('happiness')
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()).toString())
        .get();
    status = snapshot['status'];
  }

  void getmarks() async {
    setState(() {
      flag = true;
    });
    totalMarks = await FetchQuizQuestion().getmarks(selectedfilter);
    setState(() {
      flag = false;
    });
  }

  _showdialog(BuildContext context,) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            // backgroundColor: Colors.black,
            children: [
              SimpleDialogOption(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Text(
                            'Day',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )),
                  onPressed: () {
                    setState(() {
                      selectedfilter = 'day';
                    });
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade100,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Text(
                            'Week',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )),
                  onPressed: () {
                    setState(() {
                      selectedfilter = 'week';
                    });
                    Navigator.pop(context);
                  }),
              SimpleDialogOption(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade100,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Text(
                            'Month',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )),
                  onPressed: () {
                    setState(() {
                      selectedfilter = 'month';
                    });
                    Navigator.pop(context);
                  })
            ],
          );
        }
    );
  }
}

