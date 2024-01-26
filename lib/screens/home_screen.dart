import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/widgets/next_button.dart';
import 'package:quiz_app/widgets/question_widget.dart';
import 'package:quiz_app/widgets/result_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Question> _questions = [
    Question(
      id: '1',
      title: 'Where did the Ten Commandments come from?',
      options: {'God gave them to Noah.': true, 'God gave them to Moses.': false,' Jesus gave them to us.': false}
    ),
     Question(
      id: '2',
      title: 'What happened to the prophet Jonah?',
      options: {'He was thrown into a den of lions.': true, 'He was thrown into a fiery furnace.': false,'He was swallowed by a giant fish.': false}
    ),
    Question(
      id: '3',
      title: 'What happened to the prophet Daniel?',
      options: {'He was thrown into a den of lions.': true, 'He was thrown into a fiery furnace.': false,'He was swallowed by a giant fish.': false}
    )
  ];
  int index=0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;
  int itemclicado = 0;

  Color chooseColor(bool value, int idClicado, int i){
    if(value == true){
      print("Valor Correto e Clicado no Correto");
      return Colors.green;
    }if(value == false && idClicado == i){
      print("Clicado no Valor Incorreto $idClicado");
      return Colors.red;
    }else{
      return neutral;
    }

  }

  void nextQuestion(){
    if(index == _questions.length-1){
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (ctx) => ResultBox(result: score,questionLenght: _questions.length, onPressed: startOver,));
    }else{
      if(isPressed){
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
         backgroundColor: Colors.black,
          padding:EdgeInsets.all(8),
            content: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text("Please select any option"),
            ),
            elevation: 6.0,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20),
          ));
      }
       
    }
   
  }

  void checkAnswerandUpdate(bool value, int i){
    itemclicado = i;
    if(isAlreadySelected){
      return;
    }else{
      
      if(value == true){

        //print("Selecionado a correta");
        score++;
        setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
      }else{
       //print("Selecionado a errada");
      }
       setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
    }
  }
  

  void startOver(){
    setState(() {
      index=0;
      score=0;
      isPressed=false;
      isAlreadySelected=false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Bble Quiz',
          style: TextStyle(
            color: neutral,
            fontSize: 20
          ),
        ),
        backgroundColor: background,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0),
        actions: [
          Padding(padding: const EdgeInsets.only(right:20), 
          child: Text(
            'Score: $score',
            style: const TextStyle(
              fontSize: 16,
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
                  onTap: () => checkAnswerandUpdate(_questions[index].options.values.toList()[i], i),
                  child: 
                        Card(
                        color:  isPressed ? chooseColor(_questions[index].options.values.toList()[i], itemclicado, i) :neutral,
                        child: ListTile(
                          title: Text(
                            _questions[index].options.keys.toList()[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: isPressed ? Colors.black : Colors.black
                            ),
                          ),
                        ),
                      )
                    
                 
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