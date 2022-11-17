import 'package:drinkinggame/components/CustomText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionDisplayPage extends ConsumerStatefulWidget {
  const QuestionDisplayPage({Key? key}) : super(key: key);

  @override
  ConsumerState<QuestionDisplayPage> createState() => _QuestionDisplayPageState();
}

class _QuestionDisplayPageState extends ConsumerState<QuestionDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    return [
      SizedBox(height: 60,),
      CustomText(text: "User", fontSize: 30, fontWeight: FontWeight.w600),
      SizedBox(height: 30,),
      CustomText(text: "Truth/dare", fontSize: 30, fontWeight: FontWeight.w600),
      SizedBox(height: 30,),
      CustomText(text: "Question from db", fontSize: 25, fontWeight: FontWeight.w300),
      SizedBox(height: 30,),
      CustomText(text: "Or..", fontSize: 30, fontWeight: FontWeight.w600),
      SizedBox(height: 30,),
      CustomText(text: "Drink", fontSize: 25, fontWeight: FontWeight.w300),
      SizedBox(height: 30,),
      TextButton(onPressed: () => _nextQuestion(),
          child: Column(
            children: const [
              SizedBox(height: 5),
              Icon(CupertinoIcons.arrow_right, size: 60),
              Text("Next",
                style: TextStyle(fontSize: 25),)
            ],
          )),
    ];
  }
  void _nextQuestion() {

  }
}
