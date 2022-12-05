import 'package:drinkinggame/model/questions/OpenQuestion.dart';
import 'package:drinkinggame/model/questions/Question.dart';
import 'package:drinkinggame/model/questions/TruthOrDareQuestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {

  ///Makes an instance of the question widget.
  ///[question] the question
  ///[onPressed] on pressed function
  QuestionWidget({required this.question, required this.onPressed , Key? key}) : super(key: key);

  final Question question;

  final Function(Question) onPressed;

  @override
  Widget build(BuildContext context) {
    String questionText = "";
    if(question is OpenQuestion){
      questionText = question.getQuestionText();
    }else if(question is TruthOrDareQuestion){
      TruthOrDareQuestion truthOrDare = question as TruthOrDareQuestion;
      questionText = "${truthOrDare.getTruthOrDare().name.toLowerCase()}: ${question.getQuestionText()}";
    }
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 35),
          Expanded(
              child: Text(
                questionText,
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.clip,
              )),
          TextButton(
              onPressed: () => onPressed(question),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Icon(
                    CupertinoIcons.minus,
                    size: 30,
                  ),
                ],
              )),
        ]);
  }
}
