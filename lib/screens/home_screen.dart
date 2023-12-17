import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/widgets/next_button.dart';
import 'package:quiz_app/widgets/option_card.dart';
import 'package:quiz_app/widgets/question_widget.dart';
import 'package:quiz_app/widgets/result_box.dart';

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
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  void nextQuestion(){
    if(index == _questions.length-1){
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (ctx) => ResultBox(result: score,questionLenght: _questions.length,));
    }else{
      if(isPressed){
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: const Text("Please select any option"),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20),
          ));
      }
       
    }
   
  }

  void checkAnswerandUpdate(bool value){
    
    if(isAlreadySelected){
      return;
    }else{
      
      if(value == true){
        print("Selecionado a correta");
        score++;
        setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
      }else{
        setState(() {
          isPressed = true;
          
        });
        print("Selecionado a errada");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Quiz App',
          style: TextStyle(
            color: neutral,
          ),
        ),
        backgroundColor: background,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0),
        actions: [
          Padding(padding: const EdgeInsets.all(10), 
          child: Text(
            'Score: $score',
            style: TextStyle(
              fontSize: 20,
              color: neutral
              ),
            ),
          )
        ],
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
                GestureDetector(
                  onTap: () => checkAnswerandUpdate(_questions[index].options.values.toList()[i] ),
                  child: OptionCard(
                    option: _questions[index].options.keys.toList()[i],
                    color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                        ? correct
                        : incorrect  
                    : neutral, 
                  
                  ),
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