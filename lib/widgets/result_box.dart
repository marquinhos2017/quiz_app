import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key, 
    required this.result, 
    required this.questionLenght,
    }) : super(key: key);

    final int result;
    final int questionLenght;

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
            )
          ],
        ),
      ),
    );
  }
}