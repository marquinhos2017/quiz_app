import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/widgets/next_button.dart';
import 'package:quiz_app/widgets/option_card.dart';
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
  bool isPressed = false;
  void nextQuestion(){
    if(index == _questions.length-1){
      return;
    }else{
       setState(() {
      index++;
      isPressed = false;
    });
    }
   
  }

  void changeColor(){
    setState(() {
      isPressed = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: background,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0),
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
              const SizedBox(height: 25),
              for(int i = 0; i < _questions[index].options.length;i++)
              OptionCard(
                option: _questions[index].options.keys.toList()[i],
                color: isPressed ? _questions[index].options.values.toList()[i] == true
                  ? correct
                  : incorrect  
                : neutral, 
                onTap: changeColor,
              ),
              
                
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}