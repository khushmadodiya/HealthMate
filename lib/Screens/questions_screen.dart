import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Widgets/question_widget.dart';
class QuestionS extends StatefulWidget {
  const QuestionS({super.key});

  @override
  State<QuestionS> createState() => _QuestionSState();
}

class _QuestionSState extends State<QuestionS> {
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Questions',style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        padding: Width > 600
            ? EdgeInsets.symmetric(horizontal: Width / 2.9)
            : const EdgeInsets.symmetric(horizontal: 5),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('khush').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
           return ListView.builder(
                itemCount: snapshot.data!.docs.length + 1,
                itemBuilder: (context, index) {
                  return index == snapshot.data!.docs.length
                      ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Width > 600 ? Width * 0.3 : 30,
                        vertical: Width > 600 ? 15 : 10,
                      ),
                      width: double.infinity,
                      child: FilledButton(onPressed:(){
                        // _submit(snapshot.data!.docs.length.toString());
                        }, child: Text('Submit'))
                  )
                      : QuestionWidget(
                    snap: snapshot.data!.docs[index].data(),
                    index: index + 1,
                  );
                });
          },
        ),
      ),
    );
  }
}
