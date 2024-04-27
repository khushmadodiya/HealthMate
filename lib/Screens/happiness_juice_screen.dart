import 'package:flutter/material.dart';
import 'package:health_mate/Screens/questions_screen.dart';

class HappinessJuiceScreen extends StatefulWidget {
  const HappinessJuiceScreen({super.key});

  @override
  State<HappinessJuiceScreen> createState() => _HappinessJuiceScreenState();
}

class _HappinessJuiceScreenState extends State<HappinessJuiceScreen> {
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: Width > 600
            ? EdgeInsets.symmetric(horizontal: Width / 2.9)
            : const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionS()));}, child: Text('Questions are ready to be answered')),


            ],
          ),
        ),
      )
    );
  }
}
