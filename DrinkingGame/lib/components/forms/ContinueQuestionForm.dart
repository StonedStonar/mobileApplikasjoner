import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CustomText.dart';
class ContinueQuestionForm extends StatelessWidget{


  String mainTitle;

  String subTitle;

  Widget yesWidget;

  Widget noWidget;

  ContinueQuestionForm({required this.mainTitle, required this.subTitle, required this.yesWidget, required this.noWidget ,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
      getFormItems(context),
    );
  }

  List<Widget> getFormItems(BuildContext context) {
    return [
      buildHeadLineText(mainTitle, 30, FontWeight.w500),
      SizedBox(height: 10,),
      buildHeadLineText(subTitle, 20, FontWeight.w300),
      SizedBox(height: 50,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: () => _navigateToPage(yesWidget, context), child: Column(
            children: const [
              SizedBox(height: 5),
              Icon(CupertinoIcons.check_mark, size: 60,),
              Text("Yes",
                style: TextStyle(fontSize: 25),)
            ],
          )),
          SizedBox(width: 80,),
          TextButton(onPressed: () => _navigateToPage(noWidget, context),
              child: Column(
                children: const [
                  SizedBox(height: 5),
                  Icon(CupertinoIcons.xmark, size: 60),
                  Text("No",
                    style: TextStyle(fontSize: 25),)
                ],
              )),
        ],
      ),
    ];
  }

  void _navigateToPage(Widget widget, BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
  }
}

