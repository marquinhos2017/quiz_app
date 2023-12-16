import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/widgets/question_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Question> _questions = [
    Question(
      id: '10',
      title: 'What is 2+2 ?',
      options: {'5': false, '30': false,'12': false,'4': true}
    ),
     Question(
      id: '11',
      title: 'What is 1+2 ?',
      options: {'3': true, '30': false,'12': false,'4': false}
    )
  ];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            QuestionWidget(
              question: _questions[index].title, 
              indexAction: index, 
              totalQuestions: _questions.length,
              ),
              const Divider(color: neutral),
          ],
        ),
      ),
    );
  }
}