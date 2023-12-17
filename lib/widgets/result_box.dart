import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key, 
    required this.result, 
    required this.questionLenght,
    required this.onPressed,
    }) : super(key: key);

    final int result;
    final int questionLenght;
    final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Result",
              style: TextStyle(
                color: neutral,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              child: Text(
                '$result/$questionLenght',
                style: TextStyle(
                  fontSize: 30,
                  
                ), 

              ),
              radius: 70,
              backgroundColor: result == questionLenght/2
                    ? Colors.yellow
                    : result < questionLenght/2
                      ? incorrect
                      : correct,
            ),
            const SizedBox(height: 20,),
            Text(
             result == questionLenght/2 ? "Almost There" : result < questionLenght/2 ? "Try again" : "Great",
             style: TextStyle(color: neutral),
                
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: onPressed,
              child: Text(
                "Start Over",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}